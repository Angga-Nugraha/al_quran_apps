part of 'components_helpers.dart';

Future<dynamic> myModalBottomSheet(
    {required BuildContext context, required String content}) {
  return showModalBottomSheet(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    isScrollControlled: true,
    enableDrag: true,
    useSafeArea: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
    ),
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            const Text(
              'Tasir',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height,
                child: SizedBox(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
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
