import 'package:account_app/models/journal_model.dart';
import 'package:account_app/service/database/journal_data.dart';
import 'package:get/get.dart';

class JournalController extends GetxController {
  JournalData journalData = JournalData();

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
    journalData.updateJournal(journal);
  }

  Future<void> deleteJournal(int id) async {
    journalData.delete(id);
  }
}
