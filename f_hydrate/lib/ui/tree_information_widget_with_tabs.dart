import 'package:f_hydrate/model/tree_information.dart';
import 'package:f_hydrate/ui/widgets/tree_information_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TreeInformationWidgetTab extends StatefulWidget {
  const TreeInformationWidgetTab(
      {Key? key, required this.model, this.onClosePressed})
      : super(key: key);

  final TreeInformation model;
  final void Function()? onClosePressed;

  @override
  TreeInformationWidgetTabState createState() =>
      TreeInformationWidgetTabState();
}

class TreeInformationWidgetTabState extends State<TreeInformationWidgetTab> {
  final List<Widget> contentWidgets = [];
  Widget content = Container();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('treeInfoWidgetWithTabs.build()');
    initContent();
    return content;
  }

  void initContent() {
    if (!(content is Container)) {
      return;
    }
    double width = MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio;
    content = SizedBox(
      width: width * 0.25,
      child: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            // padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: buildContent(constraints),
          ),
        );
      }),
    );
  }

  Widget buildContent(BoxConstraints constraints) {
    return Stack(
      children: [
        TreeInformationTab(
          treeInfo: widget.model,
          constraints: constraints,
        ),
        buildCloseButton(),
      ],
    );
  }

  ListView buildList() {
    return ListView(
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: contentWidgets);
  }

  String getFormattedDate(DateTime date) {
    return date.day.toString() +
        "." +
        date.month.toString() +
        "." +
        date.year.toString();
  }

  Widget buildCloseButton() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: const Icon(Icons.close_rounded),
        onPressed: () {
          var closePressed = widget.onClosePressed;
          if (closePressed != null) {
            closePressed();
          }
        },
      ),
    );
  }
}
