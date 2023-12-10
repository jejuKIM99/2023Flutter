import 'dart:async';

import 'package:flutter/material.dart';
class Stopwatchpage extends StatefulWidget {
  const Stopwatchpage({super.key});

  @override
  State<Stopwatchpage> createState() => _StopwatchpageState();

}

class _StopwatchpageState extends State<Stopwatchpage> {
  Timer? _timer;
  var _time = 0;
  var _isRunning = false;

  List<String> _lapTimes =[];
  void dispose(){
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('스톱워치'),
        backgroundColor: Colors.cyan,
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 500,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {
              _clickButton();
            });
          },
          child:_isRunning ? Icon(Icons.pause): Icon(Icons.play_arrow)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }



  Widget _buildBody(){
    var sec = _time ~/ 100;
    var hundredth  ='${ _time % 100}'.padLeft(2,'0');
    return Center(
      child:Padding(
        padding: EdgeInsets.only(top:30),
        child:Stack(
          children:[
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$sec',
                      style: TextStyle(fontSize: 50),
                    ),
                    Text('$hundredth'),
                  ],
                ),
                Container(
                    width: 100,
                    height: 200,
                    child: ListView(
                      children:  _lapTimes.map((time)=>Text(time)).toList(),
                    )
                )
              ],
            ),
            Positioned(
              left: 10,
              bottom:10,
              child:FloatingActionButton(
                onPressed: (){
                  _reset();

                },
                child: Icon(Icons.rotate_left),
              ),
            ),
            Positioned(
              right: 10,
              bottom:10,
              child:ElevatedButton(
                onPressed: (){
                  setState(() {
                    _recodeLapTime('$sec.$hundredth');
                  });
                },
                child: Text("랩타임"),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _clickButton(){
    _isRunning = !_isRunning;

    if(_isRunning){
      _start();
    }
    else{
      _pause();
    }

  }
  void _start(){
    _timer = Timer.periodic(
        Duration(microseconds: 10),
            (timer){
          setState(() {
            _time++;
          });
        });
  }
  void _pause(){
    _timer?.cancel();
  }
  void _reset(){
    setState(() {

      _isRunning =false;
      _timer?.cancel();
      _lapTimes.clear();
      _time = 0;
    });
  }
  void _recodeLapTime(String time){
    _lapTimes.insert(0,'${_lapTimes.length+1}등 $time');
  }
}