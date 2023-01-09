import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/shared/ui_helpers.dart';
import 'package:project_order_food/ui/widget/a_button.dart';

enum _OptionPickerImage { camera, galley }

class APickerFormField extends FormField<File> {
  APickerFormField({
    super.key,
    FormFieldSetter<File>? onSaved,
    String? urlInit,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : super(
            onSaved: onSaved,
            validator: (v) {
              if (v == null) {
                return 'Bạn buộc phải chọn ảnh';
              }
              return null;
            },
            autovalidateMode: autovalidateMode,
            builder: (state) {
              _ButtonPickerImageFormFieldState field =
                  state as _ButtonPickerImageFormFieldState;
              return urlInit == null || state.value != null
                  ? _ItemButtonPicker(state)
                  : field.loadFile(urlInit, state: state);
            });

  @override
  FormFieldState<File> createState() => _ButtonPickerImageFormFieldState();
}

class _ButtonPickerImageFormFieldState extends FormFieldState<File> {
  @override
  FormField<File> get widget => super.widget;

  @override
  void didChange(File? value) {
    super.didChange(value);
  }

  Widget loadFile(String url, {required FormFieldState<File> state}) {
    return FutureBuilder(
        future: getImageXFileByUrl(url),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                const CircularProgressIndicator(),
                UIHelper.verticalSpaceSmall(),
                AText.body('Đang tải...')
              ],
            );
          } else if (snapshot.hasError) {
            return const Text('Error when load image default ');
          } else if (snapshot.hasData) {
            super.setValue(snapshot.data);
            return _ItemButtonPicker(state);
          }
          return const Text('None');
        });
  }

  Future<File> getImageXFileByUrl(
    String url,
  ) async {
    var rng = Random();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    File file = File('$tempPath${rng.nextInt(100)}.png');
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(Uri.parse(url));
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }
}

class _ItemButtonPicker extends StatelessWidget {
  const _ItemButtonPicker(this.state);

  final FormFieldState<File> state;

  Future<void> upload(
      {required _OptionPickerImage optionPicker,
      required FormFieldState<File> state,
      Function()? afterSuccess}) async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      switch (optionPicker) {
        case _OptionPickerImage.camera:
          pickedImage = await picker.pickImage(
              source: ImageSource.camera, maxWidth: 2000);
          state.didChange(File(pickedImage!.path));
          break;
        case _OptionPickerImage.galley:
          pickedImage = await picker.pickImage(
              source: ImageSource.gallery, maxWidth: 2000);
          state.didChange(File(pickedImage!.path));
          break;
        default:
          state.reset();
          break;
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AButton(
          isExpanded: true,
          onPressed: () {
            showModalBottomSheet(
                context: state.context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.camera),
                        title: const Text('Camera'),
                        onTap: () async {
                          await upload(
                              optionPicker: _OptionPickerImage.camera,
                              state: state);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.library_add),
                        title: const Text('Gallery'),
                        onTap: () async {
                          await upload(
                              optionPicker: _OptionPickerImage.galley,
                              state: state);
                        },
                      ),
                    ],
                  );
                });
          },
          color: AColor.primary,
          child: state.value == null
              ? AText.body(
                  'Chọn hình ảnh',
                )
              : Image.file(
                  state.value!,
                  height: 120,
                  fit: BoxFit.fill,
                ),
        ),
        state.hasError
            ? Column(
                children: [
                  const SizedBox(height: 8),
                  AText.caption(state.errorText!, color: AColor.red),
                ],
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
