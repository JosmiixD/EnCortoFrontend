part of 'helpers.dart';

showImageOptions( BuildContext context, Widget child, VoidCallback onClicked ) {

  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return CupertinoActionSheet(
        actions: [
          child
        ], cancelButton: Container(
          child: CustomButton(
            backgroundColor: Colors.white,
            text: 'Cancelar',
            textColor: Colors.black,
            fontSize: 15,
            onPressed: onClicked,
          )
        ),
      );
    }
  );

}
