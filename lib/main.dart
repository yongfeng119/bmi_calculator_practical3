import 'dart:math';

import 'package:flutter/material.dart';

import 'info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //create local variables
  double _weight = 0.0;
  double _height = 0.0;
  double _bmi = 0.0;

  String _bmiOutput = '';
  String _bmiImage = 'assets/images/empty.png';

  // create controller for textfield
  TextEditingController _weightCtrl = TextEditingController();
  TextEditingController _heightCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                fit: StackFit.loose,
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        width: 3
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(_bmiImage),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    alignment: AlignmentDirectional.center,
                    child:
                    _bmi == 0.0 ?
                    Text(
                        textAlign: TextAlign.center,
                        'Enter height and weight to calculate BMI',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black
                        ),
                    )
                        :Text('')
                  ),
                ],
              ),
              const Text(
                'Your BMI is: '
              ),
              Text(
                _bmiOutput,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              TextField(
                controller: _weightCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Enter weight (kg)'
                ),
              ),
              TextField(
                controller: _heightCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter height (meter)'
                ),
              ),
              Expanded(child: SizedBox(height: double.infinity,)),
              IconButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=> Info(bmi: _bmiOutput))
                    );
                  },
                  icon: Icon(Icons.info),
                iconSize:48,
                color: Colors.orangeAccent,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: _resetScreen, child: Text('Reset')),
                  SizedBox(width: 8.0,),
                  ElevatedButton(onPressed: _calculateBMI, child: Text('Calculate')),
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
  //helper function to calculate BMI value
  void _calculateBMI(){
    _weight = double.tryParse(_weightCtrl.text)!;
    _height = double.tryParse(_heightCtrl.text)!;

    setState(() {
      _bmi = _weight / pow(_height, 2);

      if(_bmi < 18.5){
        _bmiImage = 'assets/images/under.png';
        _bmiOutput = '${_bmi.toStringAsFixed(2)} [Underweight]';
      }else if(_bmi >= 25){
        _bmiImage = 'assets/images/over.png';
        _bmiOutput = '${_bmi.toStringAsFixed(2)} [Overweight]';
      }else{
        _bmiImage = 'assets/images/normal.png';
        _bmiOutput = '${_bmi.toStringAsFixed(2)} [Normal]';
      }
    });
  }

  void _resetScreen(){
    _weightCtrl.clear();
    _heightCtrl.clear();

    setState(() {
      _bmi = 0.0;
      _bmiImage = 'assets/images/empty.png';
      _bmiOutput = '';
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _weightCtrl.dispose();
    _heightCtrl.dispose();
  }
}

