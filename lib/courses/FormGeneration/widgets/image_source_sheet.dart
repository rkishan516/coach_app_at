import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  final Function(PickedFile) onImageSelected;

  ImageSourceSheet({@required this.onImageSelected});

  void imageSelected(PickedFile image) async {
    if (image != null) {
      onImageSelected(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.camera_enhance),
            title: Text('Camera'),
            onTap: () async {
              PickedFile image =
                  await ImagePicker().getImage(source: ImageSource.camera);
              imageSelected(image);
            },
          ),
          ListTile(
            leading: Icon(Icons.image),
            title: Text('Gallery'),
            onTap: () async {
              PickedFile image =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              imageSelected(image);
            },
          )
        ],
      ),
    );
  }
}
