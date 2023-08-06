part of 'components_helpers.dart';

Future<dynamic> myModalBottomSheet(
    {required BuildContext context, required String content}) {
  return showModalBottomSheet(
    backgroundColor: const Color.fromARGB(255, 27, 26, 26),
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
              color: Colors.white,
              height: 4,
              width: 48,
              margin: const EdgeInsets.all(10),
            ),
            const Text(
              'Tasir',
              style: TextStyle(fontSize: 16, color: Colors.white),
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
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
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