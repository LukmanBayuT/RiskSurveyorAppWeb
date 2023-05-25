import 'package:image_picker/image_picker.dart';
import 'package:native_exif/native_exif.dart';

class Util{
  Future<bool> isImageAllowed(XFile file) async {
    final exif = await Exif.fromPath(file.path);
    final DateTime? originalDate = await exif.getOriginalDate();

    if (originalDate != null) {
      Duration diff = originalDate.difference(DateTime.now()).abs();
      if (diff.inMinutes > 480) {
        return true;
      } else {
        return true;
      }
    } else {
      return true;
    }

  }

  List<String> relationOption = [
    'Agent/Sales',
    'Broker',
    'Driver',
    'Family',
    'Garage',
    'Insured',
    'Leasing',
    'Others',
    'Policy Holder',
    'Staff',
  ];
}
