
// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:simply_converted/services/currency_api.dart';
import 'package:simply_converted/widgets/drop_down.dart';


class Currency extends StatefulWidget {
  const Currency({Key? key}) : super(key: key);

  @override
  State<Currency> createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {
  //api client instance
  ApiClient client = ApiClient();


  List<String> currencies =[];
  //set default to USD to CAD
  String from = "USD";
  String to = "CAD";


  //exchange rate var
  double rate = 0.0;
  String result = "";

  //function to call api
  Future<List<String>> getCurrencyList() async{
    return await client.getCurrencies();
  }
  @override
  void initState() {
    super.initState();
    (() async {
      List<String> list = await getCurrencyList();
      setState(() {
        currencies = list;
      });
    })();
  }


  Widget build(BuildContext context) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.yellow[100],
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    //text in tab

                    width: 2000.0,
                    child: const Text('Currency Exchange', style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                        reverse: true,
                        child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextField(
                            onSubmitted: (value) async {
                              rate = await client.getRate(from, to);
                              setState(() {
                                result = (rate * double.parse(value)).toStringAsFixed(3);
                              });
                            },

                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Enter Amount to be Converted',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 18.0,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            //dropdown menu
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customDropDown(currencies, from, (val) {
                                setState(() {
                                  from = val;
                                });
                              }),
                              //exchange currency
                              FloatingActionButton(
                                onPressed: (){
                                String temp = from;
                                setState(() {
                                  from = to;
                                  to = temp;
                                });
                              },
                              child: Icon(Icons.swap_horizontal_circle_outlined, size: 55.0, color: Colors.black,),
                              elevation: 0.0,
                               ),
                              //dropdown menu
                              customDropDown(currencies, to, (val) {
                                setState(() {
                                  to = val;
                                });
                              }),

                            ],
                          ),
                          const SizedBox(height: 50.0),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Column(
                              children: [
                                const Text("Result", style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                                Text(result, style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ],
                            ),
                          ),
                        ],
                    )
                  ),
                      ))
                ],
              ),
            ),

          ),
      );
  }
}

  







