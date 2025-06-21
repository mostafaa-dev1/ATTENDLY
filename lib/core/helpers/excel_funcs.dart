import 'package:academe_mobile_new/features/attendance/model/list_students_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:excel/excel.dart';

class ExcelHelper {
  static Future<bool> isDeviceLessThan10() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String version = androidInfo.version.release;
    if (int.parse(version) <= 10) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<int>?> exportExcel(
      {required ListStudentsModel students}) async {
    final excel = Excel.createExcel();
    final sheetObject = excel['Sheet1'];

    // Set headers
    sheetObject.cell(CellIndex.indexByString('A1')).value =
        TextCellValue('Student name');
    sheetObject.cell(CellIndex.indexByString('B1')).value =
        TextCellValue('Student ID');
    sheetObject.cell(CellIndex.indexByString('C1')).value =
        TextCellValue('Attendance');

    // Populate data
    for (var i = 0; i < students.students.length; i++) {
      final rowData = students.students[i];
      sheetObject.cell(CellIndex.indexByString('A${i + 2}')).value =
          TextCellValue(rowData.name!);
      sheetObject.cell(CellIndex.indexByString('B${i + 2}')).value =
          TextCellValue(rowData.id!);
      sheetObject.cell(CellIndex.indexByString('C${i + 2}')).value =
          TextCellValue(rowData.attendance.toString());
    }

    final fileBytes = excel.save();
    return fileBytes;
  }
}
