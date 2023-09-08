part of 'components_helpers.dart';

void mySnackbar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      width: MediaQuery.of(context).size.width / 3,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Center(
          child: Text(
        message,
        textAlign: TextAlign.center,
      )),
      duration: const Duration(seconds: 3),
    ),
  );
}
