part of 'components_helpers.dart';

void mySnackbar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(message),
      duration: const Duration(seconds: 3),
    ),
  );
}
