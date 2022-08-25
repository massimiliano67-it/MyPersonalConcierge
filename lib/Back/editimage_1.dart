
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class EditImage extends StatefulWidget {
   String imageuser;
   EditImage({Key? key, required this.imageuser}) : super(key: key);

  @override
  State<EditImage> createState() => _EditImageState(imageuser);
}

class _EditImageState extends State<EditImage> {
  String imageuser;
  _EditImageState(this.imageuser);

  String retunrpath = '';


  @override
  Widget build(BuildContext context) {
    setState(() {
      retunrpath = widget.imageuser;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3E1F92),
    elevation: 0,
    leading: IconButton(
    icon: const Icon(Icons.arrow_back_ios, color: Colors.white,size: 30,),
    onPressed: () => Navigator.of(context).pop(),
    ),
    ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
              width: 330,
              child: Text(
                "Subes una foto para tu perfil",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                  width: 330,
                  child: GestureDetector(
                    onTap: () async {
                      var image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (image == null) return;

                      final location = await getApplicationDocumentsDirectory();
                      final name = basename(image.path);
                      final imageFile = File('${location.path}/$name');
                      final newImage = await File(image.path).copy(imageFile.path);
                       setState(() {
                         retunrpath = newImage.path;
                         widget.imageuser = retunrpath; //update the returndata with the return result,
                         //update UI with setState()
                       });
                    },
                    child: widget.imageuser.contains('assets') ? Image.asset(widget.imageuser) :
                    widget.imageuser.contains('https://') ? Image.network(widget.imageuser) :
                    Image.file(File(widget.imageuser))
                  ))),
          Padding(
              padding: EdgeInsets.only(top: 40),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 330,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {Navigator.of(context).pop(retunrpath);},
                      child: const Text(
                        'Update',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}
