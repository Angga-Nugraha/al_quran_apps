import 'package:al_quran_apps/common/routes.dart';
import 'package:al_quran_apps/common/utils.dart';
import 'package:flutter/material.dart';

import '../../common/colors.dart';

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
      splashColor: kDavysGrey,
      onTap: () {
        if (lastRead.isNotEmpty) {
          Navigation.intentWithData(detailPageRoutes, lastRead['surah_number']);
        }
      },
      child: Card(
        margin: const EdgeInsets.all(10.0),
        elevation: 2,
        shadowColor: kDavysGrey,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
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
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/icon-1.png',
                          color: darkColor,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Terakhir dibaca',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: darkColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      lastRead.isNotEmpty ? lastRead['surah_name'] : 'Empty',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: darkColor,
                          letterSpacing: 1.5),
                    ),
                    Text(
                      lastRead.isNotEmpty
                          ? 'Juz: ${lastRead['juz']}, Ayat: ${lastRead['ayat']}'
                          : '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: darkColor,
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
