import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/models/journal_model.dart';
import 'package:account_app/service/database/journal_data.dart';
import 'package:get/get.dart';

class JournalController extends GetxController {
  JournalData journalData = JournalData();
  HomeController homeController = Get.find();
  CustomerAccountController customerAccountController = Get.find();

  final newJournal = {}.obs;

  /*
  _productsController.newProduct.update(
        'status', (value) => value,
        ifAbsent: (() => value));
  }

 */

  Future<List<Journal>> getAllJournalsForCustomerAccount(int cacId) async {
    return journalData.readAllJournalForCustomerAccount(cacId);
  }

  Future<void> createJournal(Journal journal) async {
    journalData.create(journal);
  }

  Future<void> updateJournal(Journal journal) async {
    final newCustomerAccount =
        customerAccountController.allCustomerAccounts.firstWhere(
      (element) => element.id == journal.customerAccountId,
    );
    var totalCredit = 0.0;
    var totalDebit = 0.0;
    if (journal.credit == 0.0) {
      totalDebit =
          newCustomerAccount.totalDebit - newJournal['debit'] + journal.debit;
      totalCredit = newCustomerAccount.totalCredit - newJournal['credit'];
    } else {
      totalDebit = newCustomerAccount.totalDebit - newJournal['debit'];
      totalCredit = newCustomerAccount.totalCredit -
          newJournal['credit'] +
          journal.credit;
    }

    print(totalCredit);
    print(totalDebit);

    customerAccountController.updateCustomerAccount(newCustomerAccount.copyWith(
        totalCredit: totalCredit, totalDebit: totalDebit));
    journalData.updateJournal(journal);
    homeController.getCustomerAccountsFromCurencyAndAccGroupIds();
  }

  Future<void> deleteJournal(int id) async {
    journalData.delete(id);
  }
}
