import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widget_communication/src/events/client.dart';

class ClientInvoicePage extends StatefulWidget{
  final Stream<ClientEvents> parentEvents;
  
  ClientInvoicePage({@required this.parentEvents});

  @override
  ClientInvoicePageState createState() => ClientInvoicePageState();
}

class ClientInvoicePageState extends State<ClientInvoicePage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _invoiceController = TextEditingController();
  StreamSubscription<ClientEvents> subEvents;

  @override
  void initState() { 
    super.initState();
    subEvents = widget.parentEvents.asBroadcastStream().listen((event) {
      if (event == ClientEvents.SaveInvoices){
        print("Information: ${_addressController.text} / ${_invoiceController.text}");
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
            controller: _addressController,
            decoration: InputDecoration(
              labelText: 'Address'
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: _invoiceController,
            decoration: InputDecoration(
              labelText: 'Invoice Ammount'
            ),
          ),
        ),
        
        
      ],
    );
  }
}