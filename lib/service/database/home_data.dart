import 'package:account_app/models/acc_and_cur_model.dart';
import 'package:account_app/models/home_model.dart';
import 'package:account_app/service/database/helper/database_service.dart';
import 'package:account_app/service/database/helper/tables_helpers.dart';

class HomeData {
  Future<List<GroupCurency>> getCurencyInAccGroup(int accGroupId) async {
    final db = await DatabaseService().database;
    var result = await db.rawQuery(
        'SELECT cac.curencyId AS crId ,cr.name AS name, cr.symbol AS symbol from customeraccount AS cac JOIN curency AS cr ON cac.curencyId = cr.id WHERE cac.accgroupId = $accGroupId  GROUP BY cac.curencyId');

    return result.map((e) => GroupCurency.fromMap(e)).toList();
  }

  Future<List<HomeModel>> getCustomerAccountsForAccGroup() async {
    final db = await DatabaseService().database;
    final result = await db.rawQuery(
        'SELECT cac.customerId AS caId, ca.name ,cac.id AS cacId,ca.status AS caStatus,cac.status AS cacStatus,totalDebit ,cac.totalCredit , cac.operation, cac.accgroupId AS accGId,cac.curencyId AS curId FROM customeraccount AS cac  JOIN  customer AS ca ON cac.customerId = ca.id order by ca.modifiedAt desc ');

    /*


! SELECT DISTINCT acc.id ,acc.name,cac.curencyid FROM AccGroup  as acc
LEFT JOIN Account as cac
on acc.id = cac.accgroupid

?SELECT DISTINCT acc.id ,acc.name,cac.curencyid FROM AccGroup  as acc
LEFT JOIN Account as cac
on acc.id = cac.accgroupid
ORDER by acc.id , cac.curencyid

        */
    //WHERE cac.accgroupId = $accGroupId AND cac.curencyId = $curencyId
    final lastRes = result.map((e) => HomeModel.fromMap(e)).toList();

    return lastRes;
  }

  Future<List<AccCurencyModel>> getAccGroupsAndCurencies() async {
    final db = await DatabaseService().database;
    final result = await db.rawQuery(
        'SELECT DISTINCT acc.id AS accGroupId,cac.curencyId AS curencyId from ${TableName.accGroupTbl} AS acc LEFT JOIN ${TableName.customerAccountTbl} AS cac ON acc.id = cac.accgroupId ORDER by acc.id , cac.curencyId');

    final lastRes = result.map((e) => AccCurencyModel.fromMap(e)).toList();

    return lastRes;
  }

  Future<List<Map<String, Object?>>> getTodayJournals() async {
    final db = await DatabaseService().database;
    DateTime now = DateTime.now();
    DateTime todayStart = DateTime(now.year, now.month, now.day);
    DateTime todayEnd = todayStart.add(const Duration(days: 1));

    final result = await db.rawQuery(
        "SELECT j.id as jId ,cac.id as cacId , j.debit as debit, j.credit as credit ,j.details as desc,j.registeredAt as date ,j.createdAt as cdAt,j.modifiedAt as mdAt ,ca.name as name, accG.name as accName, cur.symbol,cur.name as curencyName  FROM journal as j join customeraccount as cac on j.customerAccountId = cac.id join customer as ca on cac.customerId = ca.id  join accgroup as accG on cac.accgroupId = accG.id   join curency  as cur on cac.curencyId = cur.id WHERE j.createdAt BETWEEN ? AND ? order by j.createdAt desc",
        [todayStart.toIso8601String(), todayEnd.toIso8601String()]);
    return result;
  }
}
