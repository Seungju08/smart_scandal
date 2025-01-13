import 'package:flutter/material.dart';

class BillSummaryScreen extends StatelessWidget {
  const BillSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 더미 데이터 (3개의 청구서만 표시)
    final List<Map<String, String>> bills = [
      {'type': '전기 요금', 'amount': '50,000원', 'date': '2025-01-05', 'icon': 'bolt', 'color': 'electric'},
      {'type': '가스 요금', 'amount': '30,000원', 'date': '2025-01-02', 'icon': 'local_fire_department', 'color': 'gas'},
      {'type': '수도 요금', 'amount': '20,000원', 'date': '2024-12-30', 'icon': 'water_drop', 'color': 'water'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '청구서 요약',
          style: TextStyle(
            fontSize: 26,
            fontFamily: 'ggr',
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // 한 줄에 1개의 카드만 보이도록
            childAspectRatio: 2, // 카드의 비율을 조정해서 크게 보이게
          ),
          itemCount: bills.length, // 3개의 청구서만 표시
          itemBuilder: (context, index) {
            return _buildBillCard(bills[index]);
          },
        ),
      ),
    );
  }

  Widget _buildBillCard(Map<String, String> bill) {
    IconData getIcon(String iconName) {
      switch (iconName) {
        case 'bolt':
          return Icons.bolt; // 전기
        case 'local_fire_department':
          return Icons.local_fire_department; // 가스
        case 'water_drop':
          return Icons.water_drop; // 수도
        default:
          return Icons.receipt; // 기본 아이콘
      }
    }

    Color getColor(String billType) {
      switch (billType) {
        case 'electric':
          return Colors.yellow.shade400;
        case 'gas':
          return Colors.orange.shade400;
        case 'water':
          return Colors.blue.shade300; // 파스텔 블루
        default:
          return Colors.grey[200]!; // 기본 색상
      }
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12), // 카드 간격을 넓혀서 여유 있게
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6, // 그림자 효과를 강조하여 입체감을 추가
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20), // 상하 좌우 여백
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: getColor(bill['color']!), // 색상 설정 (파스텔 톤)
              radius: 45,
              child: Icon(
                getIcon(bill['icon']!),
                color: Colors.black, // 아이콘 색상은 검정으로 고정
                size: 45,
              ),
            ),
            const SizedBox(width: 20), // 아이콘과 텍스트 간격
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bill['type']!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8), // 제목과 금액/청구일 사이에 간격
                  Text(
                    '금액: ${bill['amount']}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87, // 텍스트 색상 약간 어두운 톤
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '청구일: ${bill['date']}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
