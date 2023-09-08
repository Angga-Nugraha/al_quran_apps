part of 'components_helpers.dart';

Future<dynamic> myModalBottomSheet(
    {required BuildContext context, required String content}) {
  return showModalBottomSheet(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.onPrimary,
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
