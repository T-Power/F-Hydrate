import 'package:f_hydrate/model/geographic_position.dart';
import 'package:f_hydrate/model/sensor.dart';
import 'package:f_hydrate/model/tree_information.dart';
import 'package:f_hydrate/ui/widgets/text_widgets.dart';
import 'package:f_hydrate/util/DateUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateTreeWidget extends StatefulWidget {
  const CreateTreeWidget({Key? key}) : super(key: key);

  @override
  CreateTreeWidgetState createState() => CreateTreeWidgetState();
}

class CreateTreeWidgetState extends State<CreateTreeWidget> {
  bool dataValid = false;

  TextEditingController _idController =
      new TextEditingController(text: "Wird generiert");
  TextEditingController _deviceIdController = new TextEditingController();
  TextEditingController _plantedDateController = new TextEditingController();
  TextEditingController _longitudeController = new TextEditingController();
  TextEditingController _latitudeController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool isYoungTree = true;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Baum erstellen"),
      ),
      key: widget.key,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () => validate()
            ? postTree(context)
            : showSnackBar(context, "Fehler: Daten ungültig."),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: buildListView(),
      ),
    );
  }

  void postTree(BuildContext context) async {
    TreeInformation data = new TreeInformation(
      id: -1,
      deviceId: _deviceIdController.value.text,
      plantedDate: selectedDate,
      position: new GeographicPosition(
          double.parse(_latitudeController.value.text),
          double.parse(_longitudeController.value.text)),
      youngTree: isYoungTree,
      sensor: Sensor.createExample(),
    );
    Map<String, dynamic> json = data.toBackendStringMap();
    if (!validatePassword()) {
      showSnackBar(context, "Passwort falsch.");
      return;
    }
    final response = await http.post(
      Uri.parse('https://fhydrate.fb4.fh-dortmund.de/api/v1/trees'),
      body: json,
      // headers: {
      //   "Accept": "application/json",
      //   "Access-Control-Allow-Origin": "*"
      // }
    );

    //Response status code is not known. It might be 200 == OK or 201 == created or 202 == Accepted, ...
    if (response.statusCode >= 200 && response.statusCode < 300) {
      setState(() {
        showSnackBar(context, "Baum angelegt.");
      });
    } else {
      showSnackBar(context,
          'HTTP Response: Status ${response.statusCode}. Body: ${response.body}');
    }
  }

  showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  bool validate() {
    bool longLatValid = true;
    try {
      double.parse(_longitudeController.value.text);
      double.parse(_latitudeController.value.text);
    } catch (err) {
      longLatValid = false;
      showSnackBar(this.context, "Längen-/Breitengrad nicht numerisch.");
    }
    bool isValid = _deviceIdController.value.text.isNotEmpty &&
        selectedDate.toBackendDateString() != "---" &&
        _longitudeController.value.text.isNotEmpty &&
        _latitudeController.value.text.isNotEmpty &&
        longLatValid;

    return isValid;
  }

  void addChangeListeners() {}

  Widget buildListView() {
    return ListView(
      children: [
        InputField(
          icon: Icons.devices,
          title: "Id",
          controller: _idController,
          readOnly: true,
          text: "Wird generiert.",
        ),
        InputField(
          icon: Icons.devices,
          title: "Device-Id",
          controller: _deviceIdController,
        ),
        InkWell(
          //Child's InkWell would override clicks within the text field. So it is ignored and all clicks are caught by parent InkWell.
          child: IgnorePointer(
            child: InputField(
              icon: Icons.calendar_today,
              title: "Pflanzdatum",
              controller: _plantedDateController,
              readOnly: true,
            ),
          ),
          onTap: () => _selectDate(context),
        ),
        InputField(
          icon: Icons.location_on,
          title: "Längengrad",
          controller: _longitudeController,
          textInputType: TextInputType.number,
        ),
        InputField(
          icon: Icons.location_on,
          title: "Breitengrad",
          controller: _latitudeController,
          textInputType: TextInputType.number,
        ),
        SwitchListTile(
            title: Text('Jungbaum?'),
            value: this.isYoungTree,
            onChanged: (value) => setState(() {
                  this.isYoungTree = value;
                })),
        InputField(
          icon: Icons.lock,
          title: "Passwort",
          controller: _passwordController,
          isSecret: true,
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2099));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _plantedDateController.text = selectedDate.toDateString();
      });
  }

  bool validatePassword() {
    String password = _passwordController.value.text;
    return password == "!Tr3es2022.";
  }
}
