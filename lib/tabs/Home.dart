import 'package:flutter/material.dart';
import 'package:simply_converted/tabs/metric.dart';
import 'currency.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Simply Converted',
                style: TextStyle(fontFamily: 'RopaSans')),
          ),
          body: Column(
            children: const [
              TabBar(
                indicatorColor: Colors.red,
                  tabs: [
                Tab(
                    icon: Icon(Icons.local_atm,
                    color: Colors.black,
                    )
                ),
                Tab(
                    icon: Icon(Icons.straighten_outlined,
                        color: Colors.black)
                ),
              ],
              ),
              Expanded(child: TabBarView(children: [

                //currency tab
                Currency(),

                //metric tab
                Metric(),




              ],))
            ],
          )
        ));
  }
}
