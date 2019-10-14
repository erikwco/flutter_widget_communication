import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widget_communication/src/events/client.dart';

class ClientServicePage extends StatefulWidget{
  final Stream<ClientEvents> parentEvents;
  
  ClientServicePage({@required this.parentEvents});

  @override
  ClientServicePageState createState() => ClientServicePageState();
}

class ClientServicePageState extends State<ClientServicePage> {
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _servicePriceController = TextEditingController();
  StreamSubscription<ClientEvents> subEvents;

  @override
  void initState() { 
    super.initState();
    subEvents = widget.parentEvents.asBroadcastStream().listen((event) {
      if (event == ClientEvents.SaveServices){
        print("Information: ${_serviceNameController.text} / ${_servicePriceController.text}");
      }
    }); 
    
  }

  @override
  void dispose() { 
    subEvents.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: TextField(
            controller: _serviceNameController,
            decoration: InputDecoration(
              labelText: 'Service Name'
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: _servicePriceController,
            decoration: InputDecoration(
              labelText: 'Service Price'
            ),
          ),
        ),
        
        
      ],
    );
  }
}