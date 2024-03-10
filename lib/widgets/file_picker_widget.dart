import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerWidget extends StatefulWidget {
  final String title;
  final Function(FilePickerResult?) onFilePicked;

  const FilePickerWidget(
      {Key? key, required this.title, required this.onFilePicked})
      : super(key: key);

  @override
  _FilePickerWidgetState createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  String? _fileName;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
      widget.onFilePicked(result);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.headline6),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _pickFile,
          child: Text('Selecionar Arquivo'),
        ),
        const SizedBox(height: 8),
        if (_fileName != null) Text('Arquivo Selecionado: $_fileName'),
      ],
    );
  }
}
