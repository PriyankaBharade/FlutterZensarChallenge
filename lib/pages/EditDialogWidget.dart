import 'package:flutter/material.dart';
import 'package:json_parsing_demo/model/userDetails.dart';
import 'package:flutter/material.dart';

Future<T> showTextDialog<T>(
  BuildContext context, {
   String title,
   String value,
}) =>
    showDialog<T>(
      context: context,
      builder: (context) => EditDialogWidget(
        title: title,
        value: value,
      ),
    );


class EditDialogWidget extends StatefulWidget {
  final String title;
  final String value;

  const EditDialogWidget({
    Key key,
     this.title,
     this.value,
  }) : super(key: key);

  @override
  _EditDialogWidget createState() => _EditDialogWidget();
}

class _EditDialogWidget extends State<EditDialogWidget> {
TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(widget.title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          ElevatedButton(
            child: Text('Done'),
            onPressed: () => Navigator.of(context).pop(controller.text),
          )
        ],
      );
}