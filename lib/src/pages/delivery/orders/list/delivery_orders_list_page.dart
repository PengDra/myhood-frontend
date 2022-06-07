import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DeliveryOrderListPage extends StatefulWidget {
  const DeliveryOrderListPage({Key key}) : super(key: key);

  @override
  State<DeliveryOrderListPage> createState() => _DeliveryOrderListPageState();
}

class _DeliveryOrderListPageState extends State<DeliveryOrderListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('DeliveryOrderListPage'),
      ),
      );
  }
}