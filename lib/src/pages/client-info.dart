import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widget_communication/src/events/client.dart';

class ClientInformationPage extends StatefulWidget{
  final Stream<ClientEvents> parentEvents;
  ClientInformationPage({@required this.parentEvents});

  @override
  ClientInformationPageState createState() => ClientInformationPageState();
}

class ClientInformationPageState extends State<ClientInformationPage> {
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _clientPhoneController = TextEditingController();
  StreamSubscription<ClientEvents> _subEvents;

  @override
  void initState() { 
    super.initState();
    _subEvents = widget.parentEvents.asBroadcastStream().listen((event) {
      if (event == ClientEvents.SaveGeneralInfo){
        print("Information: ${_clientNameController.text} / ${_clientPhoneController.text}");
      }
    }); 
    
  }

  @override
  void dispose() { 
    _subEvents.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: TextField(
            controller: _clientNameController,
            decoration: InputDecoration(
              labelText: 'Client Name'
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: TextField(
            keyboardType: TextInputType.phone,
            controller: _clientPhoneController,
            decoration: InputDecoration(
              labelText: 'Client Phone'
            ),
          ),
        ),
        
        
      ],
    );
  }
}