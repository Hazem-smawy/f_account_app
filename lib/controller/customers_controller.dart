import 'package:account_app/models/customer_model.dart';
import 'package:account_app/service/database/customer_data.dart';
import 'package:get/get.dart';

import '../service/database/sitting_data.dart';

class CustomerController extends GetxController {
  CustomerData customerData = CustomerData();
  final allCustomers = <Customer>[].obs;
  final newCustomer = {}.obs;

  @override
  void onInit() {
    readAllCustomer();
    super.onInit();
  }

  Future<void> readAllCustomer() async {
    allCustomers.value = await customerData.readAllCustomers();
  }

  Future<int> createCusomer(Customer customer) async {
    Customer? newCustomer = await customerData.create(customer);
    await readAllCustomer();
    SittingData sittingData = SittingData();
    await sittingData.updateNewData(1);
    return newCustomer?.id ?? 0;
  }

  Future<void> updateCustomer(Customer customer) async {
    await customerData.updateCustomer(customer);
    await readAllCustomer();
    SittingData sittingData = SittingData();
    await sittingData.updateNewData(1);
  }

  Future<void> deleteCustomer(int id) async {
    customerData.delete(id);
    readAllCustomer();
  }
}
