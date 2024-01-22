import 'package:flutter/cupertino.dart';
import 'package:test_project/commons/constants.dart';
import 'package:test_project/image_permissions/media_service.dart';

class ImagePickerActionSheet extends StatelessWidget {
  const ImagePickerActionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: <Widget>[
        Container(
          color: cardColor,
          child: CupertinoActionSheetAction(
            child: Text(
              'Create Character ₊˚⊹',
              style: TextStyle(color: textColor),
            ),
            onPressed: () {},
          ),
        ),
        Container(
          color: cardColor,
          child: CupertinoActionSheetAction(
            child: Text(
              'Take Photo',
              style: TextStyle(color: textColor),
            ),
            onPressed: () => Navigator.of(context).pop(AppImageSource.camera),
          ),
        ),
        Container(
          color: cardColor,
          child: CupertinoActionSheetAction(
            child: Text(
              'Upload From Gallery',
              style: TextStyle(color: textColor),
            ),
            onPressed: () => Navigator.of(context).pop(AppImageSource.gallery),
          ),
        ),
      ],
      cancelButton: Container(
        color: cardColor,
        child: CupertinoActionSheetAction(
          child: Text(
            'Cancel',
            style: TextStyle(color: textColor),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
