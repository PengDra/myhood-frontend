import 'package:flutter/material.dart';
import 'package:myhood/src/models/address.dart';
import 'package:myhood/src/models/user.dart';
import 'package:myhood/src/provider/address_provider.dart';
import 'package:myhood/src/utils/shared_pref.dart';

class ClientAdressListController {
  BuildContext context;
  Function refresh;
  List<Address> address = [];
  AddressProvider _addressProvider;
  User user;
  SharedPref _sharedPref = new SharedPref();
  int radioValue = 0;
  bool isCreated = false;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _addressProvider.init(context);
  }

  void goToNewAdress() async {
    var result = await Navigator.pushNamed(context, 'client/adress/create');
    if (result != null) {
      if (result) {
        refresh();
      }
    }
  }

  Future<List<Address>> getAdress() async {
    address = await _addressProvider.getByUser(user.id);
    Address a = Address.fromJson(await _sharedPref.read('address') ?? {});
    int index = address.indexWhere((ad) => ad.id== a.id);
    if (index != -1) {
      radioValue = index;
    }
    return address;
  }

  void handleRadioValueChange(int value) async {
    radioValue = value;
    _sharedPref.save('address', address[value]);
    refresh();
  }
}
