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
  TextEditingController _firstSensorIdController = new TextEditingController(text: "1");
  TextEditingController _secondSensorIdController = new TextEditingController();
  TextEditingController _thirdSensorIdController = new TextEditingController();
  TextEditingController _plantedDateController = new TextEditingController();
  TextEditingController _longitudeController = new TextEditingController(text: "7.4");
  TextEditingController _latitudeController = new TextEditingController(text: "51.5");
  TextEditingController _locationFactorController = new TextEditingController(text: "1");
  TextEditingController _soilTypeFactorController = new TextEditingController(text: "1.1");
  TextEditingController _sunExpositionFactorController =
      new TextEditingController(text: "1.2");
  TextEditingController _passwordController = new TextEditingController(text: "!Tr3es2022.");
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

  void createSensor(List<Sensor> list, String id, String depth) {
    if (id.isNotEmpty) {
      list.add(Sensor.standardValues(
          id: int.parse(id),
          mqtt_sensor_id: int.parse(id),
          depth: int.parse(depth)));
    }
  }

  void postTree(BuildContext context) async {
    List<Sensor> sensors = List.from([], growable: true);
    createSensor(sensors, _firstSensorIdController.value.text, "1");
    createSensor(sensors, _secondSensorIdController.value.text, "2");
    createSensor(sensors, _thirdSensorIdController.value.text, "3");
    TreeInformation data = new TreeInformation(
      id: -1,
      plantedDate: selectedDate,
      position: new GeographicPosition(
          double.parse(_latitudeController.value.text),
          double.parse(_longitudeController.value.text)),
      locationFactor: double.parse(_locationFactorController.value.text),
      soilTypeFactor: double.parse(_soilTypeFactorController.value.text),
      sunExpositionFactor:
          double.parse(_sunExpositionFactorController.value.text),
      youngTree: isYoungTree,
      sensors: sensors,
    );
    if (!validatePassword()) {
      showSnackBar(context, "Passwort falsch.");
      return;
    }
    String json = data.toTreeCreationJson().toString();
    final response = await http.post(
      Uri.parse('https://fhydrate.fb4.fh-dortmund.de/api/v1/trees'),
      body: json,
      headers: {
        "Content-Type": "application/json",
      }
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
    bool sensorIdValid = _firstSensorIdController.value.text.isNotEmpty ||
        _secondSensorIdController.value.text.isNotEmpty ||
        _thirdSensorIdController.value.text.isNotEmpty;
    bool factorsValid = _sunExpositionFactorController.value.text.isNotEmpty &&
        _soilTypeFactorController.value.text.isNotEmpty &&
        _locationFactorController.value.text.isNotEmpty;
    bool isValid = sensorIdValid &&
        factorsValid &&
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
          title: "Sensor Id (Tiefe 1)",
          controller: _firstSensorIdController,
          textInputType: TextInputType.number,
        ),
        InputField(
          icon: Icons.devices,
          title: "Sensor Id (Tiefe 2)",
          controller: _secondSensorIdController,
          textInputType: TextInputType.number,
        ),
        InputField(
          icon: Icons.devices,
          title: "Sensor Id (Tiefe 3)",
          controller: _thirdSensorIdController,
          textInputType: TextInputType.number,
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
        InputField(
          icon: Icons.local_drink,
          title: "Lebensbereich Faktor (L)",
          controller: _locationFactorController,
          textInputType: TextInputType.number,
        ),
        InputField(
          icon: Icons.science,
          title: "Bodenart Faktor (B)",
          controller: _soilTypeFactorController,
          textInputType: TextInputType.number,
        ),
        InputField(
          icon: Icons.wb_sunny,
          title: "Sonnenexposition Faktor (S)",
          controller: _sunExpositionFactorController,
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
