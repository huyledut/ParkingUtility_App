import 'dart:convert';

import 'package:dut_packing_utility/base/domain/base_observer.dart';
import 'package:dut_packing_utility/feature/authentication/data/models/account_model.dart';
import 'package:dut_packing_utility/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_utility/feature/customer/domain/usecases/get_customer_info_usecase.dart';
import 'package:dut_packing_utility/utils/services/storage_service.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import '../../../../../utils/config/app_navigation.dart';

class RootController extends GetxController {
  RootController(this._storageService, this._getCustomerInfoUsecase);
  final StorageService _storageService;
  final GetCustomerInfoUsecase _getCustomerInfoUsecase;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 1)).whenComplete(() async {
      FlutterNativeSplash.remove();
    });
    appStart();
  }

  void appStart() {
    // _storageService.removeToken();
    _storageService.getToken().then((value) async {
      AccountModel account = AccountModel();

      if (value.isNotEmpty) {
        account = AccountModel.fromJson(jsonDecode(value));
        print(account.toJson());

        _getCustomerInfoUsecase.execute(
          observer: Observer(
            onSubscribe: () {},
            onSuccess: (customer) async {
              print(customer.toJson());
              await _storageService.setCustomer(customer.toJson().toString());
              if (customer.name != null &&
                  customer.gender != null &&
                  customer.birthday != null &&
                  customer.phoneNumber != null &&
                  customer.activityClass != null &&
                  customer.facultyId != null) {
                if (account.roleId == 30) {
                  N.toHome();
                } else {
                  N.toStaffPage();
                }
              } else {
                if (account.roleId == 30) {
                  N.toProfile();
                } else {
                  N.toStaffPage();
                }
              }
            },
            onError: (e) async {
              print(e);
              CustomerModel customer = CustomerModel();
              await _storageService.getCustomer().then((value) {
                customer = CustomerModel.fromJson(jsonDecode(value));
              });
              if (customer.name != null &&
                  customer.gender != null &&
                  customer.birthday != null &&
                  customer.phoneNumber != null &&
                  customer.activityClass != null &&
                  customer.facultyId != null) {
                N.toHome();
              } else {
                appStart();
              }
            },
          ),
        );
      } else {
        N.toWelcomePage();
      }
    });
  }
}
