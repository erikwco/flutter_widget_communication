import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:widget_communication/src/events/client.dart';
import 'package:widget_communication/src/pages/client-info.dart';
import 'package:widget_communication/src/pages/client-invoice.dart';
import 'package:widget_communication/src/pages/client-service.dart';

//* ***************************************
//* Main
//* ***************************************
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Communication'),
    );
  }
}

//* ***************************************
//* HomePage Widget
//* ***************************************
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // page index store
  int _pageIndex = 0 ;
  // page view controller
  PageController _pageController;
  //
  StreamController<ClientEvents> events = StreamController<ClientEvents>.broadcast();

  @override
  void initState() { 
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() { 
    events.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: PageView(
          onPageChanged: (int page) {
            setState(() {
             _pageIndex = page; 
            });
          },
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          children: <Widget>[
            ClientInformationPage(parentEvents: events.stream,),
            ClientServicePage(parentEvents: events.stream,),
            ClientInvoicePage(parentEvents: events.stream,),
          ],
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (int pageIndex) {
          print(pageIndex);
          setState(() {
           _pageController.jumpToPage(pageIndex);
          });
        },
        items: [
          BottomNavigationBarItem(title: Text('General info'), icon: Icon(Icons.info_outline,color: Colors.red)),
          BottomNavigationBarItem(title: Text('Services'), icon: Icon(Icons.list,color: Colors.green)),
          BottomNavigationBarItem(title: Text('Invoices'), icon: Icon(Icons.payment,color: Colors.blue)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_pageIndex == 0) {
            events.sink.add(ClientEvents.SaveGeneralInfo);
          } else if (_pageIndex ==1) {
            events.sink.add(ClientEvents.SaveServices);
          } else if (_pageIndex == 2) {
            events.sink.add(ClientEvents.SaveInvoices);
          }
        },
        tooltip: 'Save',
        child: Icon(Icons.save),
      ), 
    );
  }
}
