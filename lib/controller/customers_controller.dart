import 'package:account_app/models/customer_model.dart';
import 'package:account_app/service/database/customer_data.dart';
import 'package:get/get.dart';

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
    readAllCustomer();

    return newCustomer?.id ?? 0;
  }

  Future<void> updateCustomer(Customer customer) async {
    customerData.updateCustomer(customer);
    readAllCustomer();
  }

  Future<void> deleteCustomer(int id) async {
    customerData.delete(id);
    readAllCustomer();
  }
}
