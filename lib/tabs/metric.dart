import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Metric extends StatefulWidget {
  const Metric({Key? key}) : super(key: key);

  @override
  State<Metric> createState() => _MetricState();
}

class _MetricState extends State<Metric> {
  @override

  double userInput=0.0;
  String? converted;
  String resultMsg='';
  String? initialValue;


  var units = [
    'Meters',
    'Kilometers',
    'Grams',
    'Kilograms',
    'Feet',
    'Miles',
    'Pounds',
    'Ounces'
  ];

  final Map<String,int> unitMap = {
    'Meters':0,
    'Kilometers':1,
    'Grams':2,
    'Kilograms':3,
    'Feet':4,
    'Miles':5,
    'Pounds':6,
    'Ounces':7
  };

  dynamic conversion = {
    '0':[1, 0.001, 0, 0, 3.280, 0.0006213, 0, 0],
    '1':[1000, 1, 0, 0, 3280.84, 0.6213, 0, 0],
    '2':[0, 0, 1, 0.001, 0, 0, 0.00220, 0.035274],
    '3':[0, 0, 1000, 1, 0, 0, 2.2046, 35.274],
    '4':[0.0348, 0.00030, 0, 0, 1, 0.000189, 0, 0],
    '5':[1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6':[0, 0, 453.592, 0.4535, 0, 0, 1, 16],
    '7':[0, 0, 28.3495, 0.02834, 0, 0, 0.0625, 1]
  };

  void calculate (double value, String from, String to) {
    int nFrom = unitMap[from]!;
    int nTo = unitMap[to]!;
    var multiplier = conversion[nFrom.toString()][nTo];
    var result = value * multiplier;

    if(result == 0)
      {
        resultMsg = 'Conversion Not Possible!';
      }
    else
      {
        resultMsg = '${userInput.toString()} $initialValue are ${result.toString()} $converted';
      }
    setState(() {
      resultMsg = resultMsg;
    });

  }
  @override
  void initState() {
    userInput = 0;
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 2000.0,
                child: Text('Unit Conversion', style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              Expanded(child: Center(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       TextField(
                        onChanged: (text) {
                          var input = double.tryParse(text);
                          if(input!=null) {
                            setState(() {
                            userInput=input;
                          });
                          }
                        },
                         decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Enter Value to Convert',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18.0,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                      ),


                      const SizedBox(height: 10,),
                      Text(resultMsg,
                      style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w700)
                      ),


                      const SizedBox(
                        height: 10,
                      ),
                      const Text('From', style: TextStyle(fontSize: 20, color: Colors.white),),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: Container(
                          alignment: AlignmentDirectional.center,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.lime[100],
                          borderRadius: BorderRadius.circular(50).copyWith(bottomRight: const Radius.circular(0)
                        ),
                        ),
                        //drowndown menu 'from'
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: const Text('Enter Your Unit', textAlign: TextAlign.center,),
                            dropdownColor: Colors.white,
                            isExpanded: true, style: const TextStyle(
                            fontSize: 20, color: Colors.teal, fontWeight: FontWeight.bold,

                          ),
                            items: units.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                          }).toList(),
                            onChanged: (value) {
                              setState(() {
                                initialValue=value!;
                              });
                            },
                            value: initialValue,


                          ),
                        ),
                      ),
                      ),

                      //swap button
                      FloatingActionButton(
                          onPressed: (){
                            String? temp = initialValue;
                            setState(() {
                              initialValue = converted;
                              converted = temp!;
                            });
                          },
                          child: const Icon(Icons.sync, size: 55.0, color: Colors.black, ),
                        elevation: 0.0,
                      ),

                      const SizedBox(height: 10,),
                      const Text('To', style: TextStyle(fontSize: 20, color: Colors.white),),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.lime[100],
                            borderRadius: BorderRadius.circular(50).copyWith(bottomRight: const Radius.circular(0)
                            ),
                          ),
                          //drowndown menu 'to'
                          child: Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: const Text('Enter Your Unit'),
                              dropdownColor: Colors.white,
                              isExpanded: true, style: const TextStyle(
                              fontSize: 20, color: Colors.teal, fontWeight: FontWeight.bold


                            ),
                              items: units.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value){
                                setState(() {
                                  converted=value!;

                                });
                              },
                              value: converted,


                            ),
                          ),
                          ),
                        ),
                      ),
                      //convert button
                      const SizedBox(height: 30,),
                      TextButton(
                        onPressed: (){
                         if(initialValue!.isEmpty || converted!.isEmpty || userInput == 0) {
                            return;
                          }
                          else {
                            calculate(userInput, initialValue!, converted!);
                          }
                        },
                        child: Container(
                          width: 250,
                        height: 50,
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                          child: const Text('Convert', style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 40, color: Colors.black
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
