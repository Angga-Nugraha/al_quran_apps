part of 'components_helpers.dart';

Future<dynamic> myModalBottomSheet(
    {required BuildContext context, required String content}) {
  return showModalBottomSheet(
    backgroundColor: backgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(10),
        height: 500,
        child: Column(
          children: [
            Container(
              color: foregroundColor,
              height: 4,
              width: 48,
              margin: const EdgeInsets.all(10),
            ),
            const Text(
              'Tasir',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const Divider(
              color: kDavysGrey,
              thickness: 2,
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height,
                child: SizedBox(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Text(
                        content,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
