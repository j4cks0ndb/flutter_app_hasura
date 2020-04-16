import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {

  final String title;

  const LabelWidget({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title,    
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
        ),
    );
    
  }
}
