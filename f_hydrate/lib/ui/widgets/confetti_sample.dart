import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiSample extends StatefulWidget {
  const ConfettiSample(
      {Key? key, required this.value, required this.targetValue})
      : super(key: key);

  final num value;
  final num targetValue;

  @override
  State<ConfettiSample> createState() => _ConfettiSampleState();
}

class _ConfettiSampleState extends State<ConfettiSample> {
  ConfettiController controller = ConfettiController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value == widget.targetValue) {
      controller.play();
    }
    return Column(
      children: [
        Text(
            'This widget should play confetti? ${widget.value == widget.targetValue}'),
        SizedBox(
          //makes sure the widget's size is not 0x0
          width: 100,
          height: 100,
          child: Container(
            //shows with red color where the sub-widgets should be rendered
            color: Colors.red,
            child: ConfettiWidget(
              //this confetti is placed somewhere outside the container
              confettiController: controller,
            ),
          ),
        ),
      ],
    );
  }
}
