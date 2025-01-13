import 'package:flutter/material.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    // 샘플 뉴스 데이터
    final List<Map<String, String>> newsList = [
      {
        'image': 'assets/images/news1.jpg', // 이미지 경로
        'title': '주택용·일반용 전기요금 동결…“물가, 서민경제 부담 등 종합 고려”',
        'description': '산업용 전기요금 평균 9.7% 인상…중소기업 주로 사용하는 산업용(갑) 5.2% ↑'
      },
      {
        'image': 'assets/images/news2.jpg',
        'title': '한전, 5분기 연속 흑자…“전기 요금은 단계적 정상화”',
        'description': '한국전력이 올해 3분기 3조 원대 영업이익을 기록하며 5분기 연속 흑자를 이어가고 있습니다.'
      },
      {
        'image': 'assets/images/news3.jpg',
        'title': '전기요금 인상 관련',
        'description': '특히, 정부의 고민이 깊었던 것으로 알고 있습니다. 금번 요금 조정으로 산업용 요금은 한 자릿수 인상률인 평균 9.7% 인상하였으며, 중소기업이 주로 ...'
      },
      {
        'image': 'assets/images/news4.jpg',
        'title': '내년부터 택시 기본요금 4500원 전망',
        'description': '내년부터 울산의 택시 기본요금이 현행 4천 원에서 500원 올라 4천500원이 될 전망입니다. 울산시가 의회에 보고한 요금 조정안에 따르면, 관련 용역 ...'
      },
    ];

    return SizedBox(
      height: 230, // 뉴스 카드 높이
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // 가로 스크롤 설정
        itemCount: newsList.length,
        padding: const EdgeInsets.only(left: 20), // 왼쪽 간격 추가
        itemBuilder: (context, index) {
          final news = newsList[index];
          return Container(
            margin: const EdgeInsets.only(right: 10),
            width: 180, // 카드 너비를 약간 확대
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15), // 둥근 모서리
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3), // 그림자 색상 투명도
                  blurRadius: 8, // 흐림 정도
                  offset: const Offset(0, 4), // 그림자 위치 조정
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    news['image']!,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded( // 텍스트 영역을 아래로 밀기 위해 추가
                  child: Padding(
                    padding: const EdgeInsets.all(10.0), // 전체 간격 조정
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news['title']!,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87, // 제목 색상 변경
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6), // 간격 추가
                        Text(
                          news['description']!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700, // 설명 색상
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
