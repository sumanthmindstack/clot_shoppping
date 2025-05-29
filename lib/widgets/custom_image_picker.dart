import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';

class FilePickerWidget extends StatefulWidget {
  final String labelText;
  final String hintText;
  final XFile? initialValue;
  final FormFieldValidator<XFile>? validator;
  final void Function(XFile?) onFilePicked;
  final AutovalidateMode autovalidateMode;

  const FilePickerWidget({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.onFilePicked,
    this.validator,
    this.initialValue,
    this.autovalidateMode = AutovalidateMode.disabled,
  }) : super(key: key);

  @override
  State<FilePickerWidget> createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  final FocusNode _focusNode = FocusNode();
  XFile? _pickedFile;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _pickedFile = widget.initialValue;
    _focusNode.addListener(() {
      setState(() {}); // Update UI on focus change
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _pickFile(FormFieldState<XFile> state) async {
    _focusNode.requestFocus();
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        _pickedFile = file;
        _errorText = null;
      });
      state.didChange(file);
      widget.onFilePicked(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<XFile>(
      initialValue: _pickedFile,
      validator: (file) {
        final validationError = widget.validator?.call(file);
        setState(() {
          _errorText = validationError;
        });
        return validationError;
      },
      autovalidateMode: widget.autovalidateMode,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FocusScope(
              node: FocusScopeNode(),
              child: GestureDetector(
                onTap: () {
                  _focusNode.requestFocus();
                },
                child: Focus(
                    focusNode: _focusNode,
                    child: InputDecorator(
                      isFocused: _focusNode.hasFocus,
                      isEmpty: _pickedFile == null,
                      decoration: InputDecoration(
                        labelText: widget.labelText,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(color: Colors.black),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 122, 122, 126),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: AppColors
                                .primaryColor, // Replace with your desired focus color
                            width: 2,
                          ),
                        ),
                        errorText: _errorText,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => _pickFile(state),
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.sizeOf(context).width / 4,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                "Choose File",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _pickedFile?.name ?? widget.hintText,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ],
        );
      },
    );
  }
}
