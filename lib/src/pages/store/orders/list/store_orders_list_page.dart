import 'package:flutter/material.dart';

class StoreOrderListPage extends StatefulWidget {
  StoreOrderListPage({Key key}) : super(key: key);

  @override
  State<StoreOrderListPage> createState() => _StoreOrderListPageState();
}

class _StoreOrderListPageState extends State<StoreOrderListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('StoreOrderListPage'),
      ),
      );
  }
}