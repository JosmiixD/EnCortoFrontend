part of 'helpers.dart';

showAlert( BuildContext context, IconData icon, Color iconColor, String title, String message ) {

  showDialog(
    barrierColor: Colors.black38, 
    context: context,
    builder: ( _ ) => ElasticIn(
      child: CustomAlertDialog(
        icon: icon,
        iconColor: iconColor,
        title: title,
        message: message
      ),
    )
  );
}