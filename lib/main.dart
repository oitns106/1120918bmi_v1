import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.pinkAccent),
      home: demo(),
    );
  }
}

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {

  final heightController=TextEditingController();
  final weightController=TextEditingController();
  double? result1;
  var status;
  bool validateh=false, validatew=false;

  @override
  void dispose() {
    super.dispose();
    heightController.dispose();
    weightController.dispose();
  }

  void calculateBMI() {
    setState(() {
      double h=double.parse(heightController.text)/100;
      double w=double.parse(weightController.text);
      if (h!=null || w!=null) {
        result1=w/(h*h);
        if (result1!<18.5) status="過輕";
        else if (result1!>24) status="過重";
        else status="正常";
      }
    });
  }

  Color? getTextColor(var s1) {
    if (s1=="正常") return Colors.green;
    else if (s1=="過輕") return Colors.amber;
    else return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '請輸入身高',
                hintText: 'cm',
                errorText: validateh? '不得為空': null,
                icon: Icon(Icons.trending_up),
              ),
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '請輸入體重',
                hintText: 'Kg',
                errorText: validatew? '不得為空': null,
                icon: Icon(Icons.trending_down),
              ),
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 35,),
            ElevatedButton(child: Text('計算', style: TextStyle(color: Colors.white),),
              onPressed: () {
                setState(() {
                  heightController.text.isEmpty? validateh=true : validateh=false;
                  weightController.text.isEmpty? validatew=true : validatew=false;
                });
                calculateBMI();
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 22),
              ),
            ),
            SizedBox(height: 15,),
            Text(result1==null? "":"您的BMI值=${result1!.toStringAsFixed(2)}",
              style: TextStyle(color: Colors.blueAccent,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15,),
//            Text(status==null? "":"您的狀態為：${status}",   //同一顏色
//              style: TextStyle(color: Colors.blue,
//                  fontSize: 22,
//                  fontWeight: FontWeight.w500),
//            ),
            RichText(text: TextSpan(style:TextStyle(color: Colors.blueAccent,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w500),
                                    children:[
                                      TextSpan(text: status==null? "":"您的體重狀態為："),
                                      TextSpan(text: status==null? "":"$status",
                                               style:TextStyle(color: getTextColor(status),
                                                               fontWeight: FontWeight.bold)),
                                    ],
                                   ),
            ),
        ],
      ),
     ),
    );
  }
}
