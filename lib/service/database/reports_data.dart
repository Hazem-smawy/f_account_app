import 'package:account_app/models/journal_model.dart';
import 'package:account_app/service/database/helper/database_service.dart';

class ReportsData {
  Future<List<Map<String, Object?>>> getJournalsReport(
      {required DateTime from,
      required DateTime to,
      required int curencyId}) async {
    print("$from --- $to --- $curencyId");
    final db = await DatabaseService().database;

    final result = await db.rawQuery(
        "SELECT j.id as jId  ,j.details as desc,cac.id as cacId , j.debit as debit, j.credit as credit ,j.createdAt as date,ca.name as name, accG.name as accName, cur.symbol ,cur.name as curencyName FROM journal as j join customeraccount as cac on j.customerAccountId = cac.id join customer as ca on cac.customerId = ca.id  join accgroup as accG on cac.accgroupId = accG.id join curency  as cur on cac.curencyId = cur.id  WHERE cur.id = ? AND j.createdAt BETWEEN ? AND ?  order by j.createdAt desc",
        [curencyId, from.toIso8601String(), to.toIso8601String()]);
    return result;
  }

  Future<List<Map<String, Object?>>> getAllMoneyReport(
      {required DateTime from,
      required DateTime to,
      required int curencyId}) async {
    print("$from --- $to --- $curencyId");
    final db = await DatabaseService().database;

    final result = await db.rawQuery(
        "SELECT j.id as jId ,cac.id as cacId,SUM(j.debit) as allDebit,SUM(j.credit) as allCredit , j.debit as debit, j.credit as credit ,j.createdAt as date,ca.name as name, accG.name as accName, cur.symbol  FROM journal as j join customeraccount as cac on j.customerAccountId = cac.id join customer as ca on cac.customerId = ca.id  join accgroup as accG on cac.accgroupId = accG.id join curency  as cur on cac.curencyId = cur.id  WHERE cur.id = ? AND j.createdAt BETWEEN ? AND ?   GROUP BY cac.id",
        [curencyId, from.toIso8601String(), to.toIso8601String()]);
    return result;
  }

  Future<List<Journal>> getCustomerAccountJournals(
      {required DateTime from,
      required DateTime to,
      required int customerAccount}) async {
    final db = await DatabaseService().database;

    final result = await db.rawQuery(
        "select * from journal WHERE  customerAccountId = ? AND  createdAt BETWEEN ? AND ?   order by createdAt desc ",
        [customerAccount, from.toIso8601String(), to.toIso8601String()]);

    return result.map((e) => Journal.fromMap(e)).toList();
  }
}
