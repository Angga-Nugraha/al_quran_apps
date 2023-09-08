import 'package:al_quran_apps/common/routes.dart';
import 'package:al_quran_apps/common/utils.dart';
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
          Navigation.intentWithData(detailPageRoutes, lastRead['surah_number']);
        }
      },
      child: Card(
        margin: const EdgeInsets.all(10.0),
        elevation: 2,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                right: 10,
                height: 125,
                width: 125,
                child: Image.asset(
                  'assets/images/mosque.png',
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Row(
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
                    const SizedBox(height: 15),
                    Text(
                      lastRead.isNotEmpty ? lastRead['surah_name'] : 'Empty',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      lastRead.isNotEmpty
                          ? 'Juz: ${lastRead['juz']}, Ayat: ${lastRead['ayat']}'
                          : '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
