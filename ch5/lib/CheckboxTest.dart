import 'package:flutter/material.dart';

class CheckBoxTest extends StatefulWidget {
  const CheckBoxTest({super.key});

  @override
  State<CheckBoxTest> createState() => _CheckBoxTestState();
}

class _CheckBoxTestState extends State<CheckBoxTest> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkbox Test'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value){
                setState(() {
                  isChecked = value;
                });
              },
            ),
            SizedBox(height: 50,),
            Switch(
              value: isChecked!,
              onChanged: (value){
                setState(() {
                  isChecked = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}