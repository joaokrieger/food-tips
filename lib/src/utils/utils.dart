import 'package:intl/intl.dart';

class Utils {

  static String fmtData(String data) {

    final inputFmt = DateFormat('dd/MM/yyyy');
    final outputFmt = DateFormat('yyyy-MM-dd');
    final formattedData = inputFmt.parse(data);
    final formattedDataString = outputFmt.format(formattedData);

    return formattedDataString;
  }
}
