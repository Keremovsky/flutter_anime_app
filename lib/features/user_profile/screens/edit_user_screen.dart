import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_anime_app/core/utils/app_bar_back_button.dart';
import 'package:flutter_anime_app/features/user_profile/controller/user_profile_controller.dart';
import 'package:flutter_anime_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditUserScreen extends ConsumerStatefulWidget {
  final String username;
  final String animeName;
  final String profilePicURL;
  final String backgroundPicURL;

  const EditUserScreen({
    super.key,
    required this.username,
    required this.animeName,
    required this.profilePicURL,
    required this.backgroundPicURL,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends ConsumerState<EditUserScreen> {
  String? newBackgroundPicPath;
  String? newProfilePicPath;
  String? newUsername;
  String? newAnimeName;

  final formKey = GlobalKey<FormState>();

  Future<String?> getFilePath() async {
    final filePicker = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', "jpeg"],
    );

    if (filePicker != null) {
      return filePicker.files.single.path!;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit profile",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Palette.mainColor),
        ),
        centerTitle: false,
        leading: const AppBarBackButton(),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(height: height * 0.15 + 50),
              // banner
              Container(
                height: height * 0.15,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: newBackgroundPicPath != null
                      ? DecorationImage(
                          image: FileImage(File(newBackgroundPicPath!)),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(
                          image: NetworkImage(widget.backgroundPicURL),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final filePath = await getFilePath();

                  if (filePath != null) {
                    setState(() {
                      newBackgroundPicPath = filePath;
                    });
                  }
                },
                child: Container(
                  height: height * 0.15,
                  width: double.infinity,
                  color: Palette.background.withOpacity(0.5),
                  child: const Icon(
                    Icons.photo_camera_rounded,
                    size: 40,
                  ),
                ),
              ),
              // profile
              Positioned(
                left: 20,
                bottom: 0,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: newProfilePicPath != null
                        ? DecorationImage(
                            image: FileImage(File(newProfilePicPath!)),
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            image: NetworkImage(widget.profilePicURL),
                            fit: BoxFit.cover,
                          ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Palette.background,
                      width: 6,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 0,
                child: GestureDetector(
                  onTap: () async {
                    final filePath = await getFilePath();

                    if (filePath != null) {
                      setState(() {
                        newProfilePicPath = filePath;
                      });
                    }
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Palette.background.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.photo_camera_rounded,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.username,
                  onSaved: (value) {
                    setState(() {
                      newUsername = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please fill the text field.";
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                TextFormField(
                  initialValue: widget.animeName,
                  onSaved: (value) {
                    setState(() {
                      newAnimeName = value!;
                    });
                  },
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Material(
            color: Palette.mainColor,
            borderRadius: BorderRadius.circular(15),
            child: InkWell(
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();

                  await ref
                      .read(userProfileControllerProvider.notifier)
                      .updateUserProfile(
                        context,
                        newUsername,
                        newAnimeName,
                        newProfilePicPath,
                        newBackgroundPicPath,
                      );
                }
              },
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: 40,
                width: 100,
                child: Center(
                  child: Text(
                    "Save",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
