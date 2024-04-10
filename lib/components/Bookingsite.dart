import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  final User user;
  const BookingPage({Key? key, required this.user}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final ScrollController _scrollController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // State variables for booking details
  DateTime? _selectedDate;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;

  String? _eventName;
  String? _selectedArea;
  String? _selectedEquipment;
  int? _selectedPlayers;
  String? _contactInfo;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    String eventId;
    Map<String, Object?> eventData;
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        physics: const BouncingScrollPhysics(),
        children: [
          _buildBookingSlot(),
          const SizedBox(height: 16.0),
          _buildDate(context),
          const SizedBox(height: 16.0),
          _buildDuration(context),
          const SizedBox(height: 16.0),
          _buildEventName(context),
          const SizedBox(height: 16.0),
          _buildAreaPicker(context),
          const SizedBox(height: 16.0),
          _buildEquipments(context),
          const SizedBox(height: 16.0),
          _buildNumberOfPlayers(context),
          const SizedBox(height: 16.0),
          const SizedBox(height: 16.0),
          _buildContactInfo(context),
          ElevatedButton(onPressed: () async => {
             eventId = DateTime.now().millisecondsSinceEpoch.toString(),

             eventData = {
              'date': _selectedDate,
              'start_time': "${_selectedStartTime!.hour}:${_selectedStartTime!.minute}",
              'end_time': "${_selectedEndTime!.hour}:${_selectedEndTime!.minute}",
              'event_name': _eventName,
              'area': _selectedArea,
              'equipment': _selectedEquipment,
               'players': _selectedPlayers,
              'contactInfo': _contactInfo,
               'creator_name': widget.user.displayName,
               'creator_email': widget.user.email
            },

        await _firestore.collection('events').doc(eventId).set(eventData),


  }, child: Text("Create Event"))
        ],
      ),
    );
  }
  Widget _buildBookingSlot() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(Icons.add_circle, color: Theme.of(context).colorScheme.primary, size: 32.0),
          const SizedBox(width: 16.0),
          const Text('New Booking Slot'),
        ],
      ),
    );
  }
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

  Widget _buildDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today, color: Theme.of(context).colorScheme.primary, size: 24.0),
              const SizedBox(width: 8.0),
              const Text('Date'),
            ],
          ),
          ElevatedButton(
            onPressed: _showDatePicker,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(_selectedDate != null
                ? '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}'
                : 'Select Date',
              style: Theme.of(context).primaryTextTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
  void _showTimePicker() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedStartTime ?? TimeOfDay.now(),
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
    if (picked != null && picked != _selectedStartTime) {
      setState(() {
        _selectedStartTime = picked;
      });
    }
  }
  void _showEndTimePicker() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime ?? TimeOfDay.now(),
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
    if (picked != null && picked != _selectedEndTime) {
      setState(() {
        _selectedEndTime = picked;
      });
    }
  }

  Widget _buildDuration(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.play_circle_fill_rounded, color: Theme.of(context).colorScheme.primary, size: 24.0),
                  const SizedBox(width: 8.0),
                  const Text('Start'),
                ],
              ),
              ElevatedButton(
                onPressed: _showTimePicker,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(_selectedStartTime != null
                    ? '${_selectedStartTime!.hour}:${_selectedStartTime!.minute.toString().padLeft(2, '0')}'
                    : 'Select Time',
                  style: Theme.of(context).primaryTextTheme.labelMedium
                  ,),
              ),
              
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.stop_circle, color: Theme.of(context).colorScheme.primary, size: 24.0),
                  const SizedBox(width: 8.0),
                  const Text('End'),
                ],
              ),
              ElevatedButton(
                onPressed: _showEndTimePicker,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(_selectedEndTime != null
                    ? '${_selectedEndTime!.hour}:${_selectedEndTime!.minute.toString().padLeft(2, '0')}'
                    : 'Select Time',
                  style: Theme.of(context).primaryTextTheme.labelMedium
                  ,),
              ),

            ],
          )
        ],
      ),
    );
  }
  Widget _buildEventName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.event, color: Theme.of(context).colorScheme.primary, size: 24.0),
              const SizedBox(width: 8.0),
              const Text(''),
            ],
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter event name',
              ),
              onChanged: (value) {
                setState(() {
                  _eventName = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
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
  Widget _buildAreaPicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: Theme.of(context).colorScheme.primary, size: 24.0),
              const SizedBox(width: 8.0),
              const Text('Area'),
            ],
          ),
          ElevatedButton(
            onPressed: _showAreaPicker,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(_selectedArea ?? 'Select Area',style: Theme.of(context).primaryTextTheme.labelMedium),
          ),
        ],
      ),
    );
  }
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

  Widget _buildEquipments(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.shopping_cart, color: Theme.of(context).colorScheme.primary, size: 24.0),
              const SizedBox(width: 8.0),
              const Text('Equipments'),
            ],
          ),
          ElevatedButton(
            onPressed: _showEquipmentsPicker,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(_selectedEquipment ?? 'Select Equipment',style: Theme.of(context).primaryTextTheme.labelMedium),
          ),
        ],
      ),
    );
  }
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

  Widget _buildNumberOfPlayers(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Theme.of(context).colorScheme.primary, size: 24.0),
              const SizedBox(width: 8.0),
              const Text('Number of Players'),
            ],
          ),
          ElevatedButton(
            onPressed: _showPlayersPicker,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(_selectedPlayers != null ? '$_selectedPlayers' : 'Select Players',style: Theme.of(context).primaryTextTheme.labelMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.contact_phone, color: Theme.of(context).colorScheme.primary, size: 24.0),
              const SizedBox(width: 8.0),
              const Text(''),
            ],
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter contact information',
              ),
              onChanged: (value) {
                setState(() {
                  _contactInfo = value; // Update _contactInfo on text change
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
