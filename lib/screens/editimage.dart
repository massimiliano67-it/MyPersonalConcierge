import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

import '../components/button.dart';
import '../components/displayimage.dart';
import '../utils/constant.dart';

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
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),backgroundColor: const Color(0xFF3E1F92),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            messagephotoprofile,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                  width: 330,
                  child: InkWell(
                      onTap: () async {
                        var image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);

                        if (image == null) return;

                        final location =
                            await getApplicationDocumentsDirectory();
                        final name = basename(image.path);
                        final imageFile = File('${location.path}/$name');
                        final newImage =
                            await File(image.path).copy(imageFile.path);
                        setState(() {
                          retunrpath = newImage.path;
                          widget.imageuser =
                              retunrpath;
                        });
                      },
                      child: DisplayImage(
                        imagePath: widget.imageuser,
                        onPressed: () {},
                      )))),
          Padding(
              padding: EdgeInsets.only(top: 70),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 330,
                    height: 50,
                    child:
                    ElevateGenericButton(
                      title: messagebuttonupdate,
                      ontapp: () async {
                        Navigator.of(context).pop(retunrpath);
                      },
                    )
                  )))
        ],
      ),
    );
  }
}
