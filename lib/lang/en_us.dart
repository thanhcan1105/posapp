import 'package:pos_app/lang/en/account.dart';
import 'package:pos_app/lang/en/auth.dart';
import 'package:pos_app/lang/en/common.dart';
import 'package:pos_app/lang/en/dialog.dart';
import 'package:pos_app/lang/en/label.dart';
import 'package:pos_app/lang/en/notify.dart';
import 'package:pos_app/lang/en/report.dart';
import 'package:pos_app/lang/en/time.dart';
import './plugins.dart';

Map<String, String> enUS = loadLanguages({
  'common': commonLabels,
  'auth': authLabels,
  'account': accountLabels,
  'time': timeLabels,
  'label': localLables,
  'dialog': dialogLabels,
  'notify': notifyLabels,
  'report': reportLabels,
});
