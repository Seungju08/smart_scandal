import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];
  List<Map<String, dynamic>> _responseResults = [];
  bool _isLoading = false;

  Future<void> _selectImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _selectedImages = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  Future<void> _captureImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  Future<void> _sendImagesToServer() async {
    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이미지를 선택해주세요.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.184.44:3000/api/process-images'),
      );

      for (var image in _selectedImages) {
        request.files.add(
          await http.MultipartFile.fromPath('files', image.path),
        );
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decodedResponse = json.decode(responseBody);

        setState(() {
          _responseResults =
              List<Map<String, dynamic>>.from(decodedResponse['results']);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류 발생: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류 발생: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildResultCard(Map<String, dynamic> result) {
    final type = result['aiResponse']['type'];
    final key1 = result['aiResponse']['key1'];
    final key2 = result['aiResponse']['key2'];

    String typeText;
    String detailText;

    if (type == 1) {
      typeText = '계약서';
      detailText = '요약: $key1\n허점: $key2';
    } else if (type == 0) {
      typeText = '청구서';
      String itemType;
      switch (int.tryParse(key2) ?? -1) {
        case 0:
          itemType = '기타';
          break;
        case 1:
          itemType = '전기';
          break;
        case 2:
          itemType = '수도';
          break;
        case 3:
          itemType = '가스';
          break;
        case 4:
          itemType = '휴대폰';
          break;
        case 5:
          itemType = '세금';
          break;
        case 6:
          itemType = '월세';
          break;
        case 7:
          itemType = '보험';
          break;
        case 8:
          itemType = '할부';
          break;
        case 9:
          itemType = '교육비';
          break;
        case 10:
          itemType = '구독서비스';
          break;
        default:
          itemType = '알 수 없음';
      }
      detailText = '요금: $key1\n종류: $itemType';
    } else {
      typeText = '알 수 없음';
      detailText = '데이터 없음';
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '파일 이름: ${result['file']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('문서 유형: $typeText'),
            const SizedBox(height: 8),
            Text(detailText),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '문서 스캔 및 요약',
          style: TextStyle(
            fontSize: 26,
            fontFamily: 'ggr',
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(),
          Expanded(
            child: _selectedImages.isNotEmpty
                ? ListView.builder(
                    itemCount: _selectedImages.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 1.0,
                            child: Image.file(
                              _selectedImages[index],
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => setState(() {
                                _selectedImages.removeAt(index);
                              }),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : const Center(child: Text('이미지를 선택하거나 촬영해주세요.')),
          ),
          const SizedBox(height: 20),
          if (_responseResults.isNotEmpty) // 결과가 있을 때만 보여줌
            Expanded(
              child: ListView.builder(
                itemCount: _responseResults.length,
                itemBuilder: (context, index) {
                  return _buildResultCard(_responseResults[index]);
                },
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _selectImages,
                icon: const Icon(Icons.photo_library, color: Colors.black),
                label: const Text(
                  '갤러리에서 선택',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  overlayColor: Colors.grey,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(color: Colors.grey),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _captureImage,
                icon: const Icon(Icons.camera_alt, color: Colors.black),
                label: const Text(
                  '사진 촬영',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  overlayColor: Colors.grey,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _isLoading ? null : _sendImagesToServer,
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.black)
                : const Text(
                    'AI요약 및 취약점 분석',
                    style: TextStyle(color: Colors.black),
                  ),
            style: ElevatedButton.styleFrom(
              overlayColor: Colors.grey,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: const BorderSide(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
