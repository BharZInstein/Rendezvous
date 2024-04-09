import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white, // Background color
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        physics: const BouncingScrollPhysics(),
        children: [
          const BookingSlot(),
          const SizedBox(height: 16.0),
          const DateWidget(),
          const SizedBox(height: 16.0),
          const DurationWidget(),
          const SizedBox(height: 16.0),
          const EventNameWidget(),
          const SizedBox(height: 16.0),
          const AreaWidget(),
          const SizedBox(height: 16.0),
          const EquipmentsWidget(),
          const SizedBox(height: 16.0),
          const NumberOfPlayersWidget(),
          const SizedBox(height: 16.0),
          const RegistrationNumberWidget(),
          const SizedBox(height: 16.0),
          const ContactWidget(),
        ],
      ),
    );
  }
}

class BookingSlot extends StatelessWidget {
  const BookingSlot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: const Text('New Booking Slot'),
      ),
    );
  }
}

class DateWidget extends StatefulWidget {
  const DateWidget({Key? key}) : super(key: key);

  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  DateTime? _selectedDate;

  void _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Date'),
            ElevatedButton(
              onPressed: _showDatePicker,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(_selectedDate != null
                  ? '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}'
                  : 'Select Date'),
            ),
          ],
        ),
      ),
    );
  }
}

class DurationWidget extends StatefulWidget {
  const DurationWidget({Key? key}) : super(key: key);

  @override
  _DurationWidgetState createState() => _DurationWidgetState();
}

class _DurationWidgetState extends State<DurationWidget> {
  TimeOfDay? _selectedTime;

  void _showTimePicker() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Duration'),
            ElevatedButton(
              onPressed: _showTimePicker,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(_selectedTime != null
                  ? '${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
                  : 'Select Time'),
            ),
          ],
        ),
      ),
    );
  }
}

class EventNameWidget extends StatefulWidget {
  const EventNameWidget({Key? key}) : super(key: key);

  @override
  _EventNameWidgetState createState() => _EventNameWidgetState();
}

class _EventNameWidgetState extends State<EventNameWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Name of Event'),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter event name',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AreaWidget extends StatefulWidget {
  const AreaWidget({Key? key}) : super(key: key);

  @override
  _AreaWidgetState createState() => _AreaWidgetState();
}

class _AreaWidgetState extends State<AreaWidget> {
  String? _selectedArea;
  final List<String> _areas = ['AB1', 'AB2', 'A block', 'B block'];

  void _showAreaPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Area'),
          content: SingleChildScrollView(
            child: Column(
              children: _areas
                  .map((area) => ListTile(
                title: Text(area),
                onTap: () {
                  setState(() {
                    _selectedArea = area;
                  });
                  Navigator.of(context).pop();
                },
              ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Area'),
            ElevatedButton(
              onPressed: _showAreaPicker,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(_selectedArea ?? 'Select Area'),
            ),
          ],
        ),
      ),
    );
  }
}

class EquipmentsWidget extends StatefulWidget {
  const EquipmentsWidget({Key? key}) : super(key: key);

  @override
  _EquipmentsWidgetState createState() => _EquipmentsWidgetState();
}

class _EquipmentsWidgetState extends State<EquipmentsWidget> {
  String? _selectedEquipment;
  final List<String> _equipments = ['Yes', 'No'];

  void _showEquipmentsPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Equipment'),
          content: SingleChildScrollView(
            child: Column(
              children: _equipments
                  .map((equipment) => ListTile(
                title: Text(equipment),
                onTap: () {
                  setState(() {
                    _selectedEquipment = equipment;
                  });
                  Navigator.of(context).pop();
                },
              ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Equipments'),
            ElevatedButton(
              onPressed: _showEquipmentsPicker,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(_selectedEquipment ?? 'Select Equipment'),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberOfPlayersWidget extends StatefulWidget {
  const NumberOfPlayersWidget({Key? key}) : super(key: key);

  @override
  _NumberOfPlayersWidgetState createState() => _NumberOfPlayersWidgetState();
}

class _NumberOfPlayersWidgetState extends State<NumberOfPlayersWidget> {
  int? _selectedPlayers;
  final List<int> _players = List.generate(4, (index) => index + 1);

  void _showPlayersPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Number of Players'),
          content: SingleChildScrollView(
            child: Column(
              children: _players
                  .map((player) => ListTile(
                title: Text('$player'),
                onTap: () {
                  setState(() {
                    _selectedPlayers = player;
                  });
                  Navigator.of(context).pop();
                },
              ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Number of Players'),
            ElevatedButton(
              onPressed: _showPlayersPicker,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(_selectedPlayers != null ? '$_selectedPlayers' : 'Select Players'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationNumberWidget extends StatefulWidget {
  const RegistrationNumberWidget({Key? key}) : super(key: key);

  @override
  _RegistrationNumberWidgetState createState() => _RegistrationNumberWidgetState();
}

class _RegistrationNumberWidgetState extends State<RegistrationNumberWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Registration Number'),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter registration number',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactWidget extends StatefulWidget {
  const ContactWidget({Key? key}) : super(key: key);

  @override
  _ContactWidgetState createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Contact'),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter contact information',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}