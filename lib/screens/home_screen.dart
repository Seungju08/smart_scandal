import 'package:flutter/material.dart';
import 'package:hackathon/service/news.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '똑똑스캔들',
                  style: TextStyle(
                    fontFamily: 'ggr',
                    fontSize: 26,
                  ),
                ),
                SizedBox(width: 5),
                Image.asset(
                  'assets/images/logo.png',
                  width: 30,
                  height: 30,
                ),
              ],
            ),
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    _showNotifications(context); // 알림 창 호출
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.grey,
                  ),
                ),
                Transform.translate(
                  offset: Offset(26, 14),
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(),
              SizedBox(height: 20),
              Container(
                width: 370,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    overlayColor:
                        MaterialStateProperty.all(Colors.grey.shade100),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      // 왼쪽 텍스트 정보
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '나의 총 요금',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '123',
                              style: TextStyle(
                                color: Colors.blue.shade600,
                                fontSize: 18,
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '자세히 보려면 클릭',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildBillRow('도시가스세', Colors.orange.shade400, 0.6),
                          SizedBox(height: 10),
                          _buildBillRow(
                              '      전기세', Colors.yellow.shade400, 0.7),
                          SizedBox(height: 10),
                          _buildBillRow('      수도세', Colors.blue.shade300, 0.5),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 370,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    // 왼쪽 텍스트 정보
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/smile.gif',
                            width: 115,
                            height: 115,
                          )
                        ],
                      ),
                    ),
                    Text(
                      '현재 추승주님께서는\n연체된 요금이 없습니다',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'ggr',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    '관련 기사',
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              News(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBillRow(String name, Color color, double widthFactor) {
    return Row(
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 110,
          height: 20,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            widthFactor: widthFactor,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (BuildContext context) {
        // 샘플 알림 데이터
        final List<Map<String, String>> notifications = [
          {'title': '새로운 계약서 분석 완료', 'time': '5분 전'},
          {'title': '부동산 계약서 허점 발견', 'time': '8분 전'},
          {'title': '청구서 요금 납부 기한 도래', 'time': '어제'},
        ];

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Center(
                child: Text(
                  '알림',
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: 'ggr',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return ListTile(
                    leading: Icon(
                      Icons.notifications_active,
                      color: Colors.blue,
                    ),
                    title: Text(notification['title']!),
                    subtitle: Text(notification['time']!),
                    onTap: () {
                      // 알림 클릭 시 동작
                      Navigator.of(context).pop(); // 팝업 닫기
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('알림 "${notification['title']}" 확인')),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
