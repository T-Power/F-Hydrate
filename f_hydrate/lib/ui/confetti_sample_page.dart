import 'package:f_hydrate/ui/drawer.dart';
import 'package:f_hydrate/ui/widgets/confetti_sample.dart';
import 'package:flutter/material.dart';

class ConfettiSamplePage extends StatefulWidget {
  const ConfettiSamplePage({Key? key}) : super(key: key);

  @override
  _ConfettiSamplePageState createState() => _ConfettiSamplePageState();
}

class _ConfettiSamplePageState extends State<ConfettiSamplePage>
    with TickerProviderStateMixin {
  TabController? controller;

  List<Widget> tabs = [
    ConfettiSample(value: 1, targetValue: 1),
    ConfettiSample(value: 1, targetValue: 1),
    ConfettiSample(value: 1, targetValue: 2),
    ConfettiSample(value: 1, targetValue: 2),
    ConfettiSample(value: 1, targetValue: 1),
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBuilder.build(context),
      appBar: AppBar(
        title: Text("Confetti sample"),
        bottom: TabBar(
          indicatorColor: Theme.of(context).colorScheme.secondary,
          labelColor: Theme.of(context).colorScheme.secondary,
          unselectedLabelColor: Theme.of(context).textTheme.headline1!.color,
          tabs: const [
            Icon(Icons.local_drink),
            Icon(Icons.thermostat),
            Icon(Icons.bolt),
            Icon(Icons.local_florist),
            Icon(Icons.science)
          ],
          controller: controller!,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              children: tabs,
              controller: controller!,
            ),
          ),
          Center(
            child: TabPageSelector(
              controller: controller!,
            ),
          ),
        ],
      ),
    );
  }
}
