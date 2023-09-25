import 'package:al_quran_apps/data/common/routes.dart';
import 'package:flutter/material.dart';

class LastReadBanner extends StatelessWidget {
  const LastReadBanner({
    required this.lastRead,
    Key? key,
  }) : super(key: key);

  final Map<String, dynamic> lastRead;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        if (lastRead.isNotEmpty) {
          Navigation.intentWithData(detailPageRoutes,
              arguments: lastRead['surah_number']);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.menu_book),
                        SizedBox(width: 8),
                        Text(
                          'Terakhir dibaca',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Text(
                      lastRead.isNotEmpty
                          ? lastRead['surah_name']
                          : 'Data tidak ditemukan,',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      lastRead.isNotEmpty
                          ? 'Juz: ${lastRead['juz']}, Ayat: ${lastRead['ayat']}'
                          : '',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/mosque.png',
              width: 120,
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
      ),
    );
  }
}
