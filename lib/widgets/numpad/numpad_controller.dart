import 'package:flutter/foundation.dart';
import 'package:pos_app/widgets/numpad/formatter.dart';
import 'package:pos_app/widgets/numpad/numpad_format.dart';

//import 'formatting/formatter.dart';

typedef ValidInputCallback = void Function(bool);

///A controller that holds the current state of a Numpad, provides notifications
///when that state is updated via user input, and allows programmatic control
///of clearing text and raising errors.
class NumpadController with ChangeNotifier {
  final NumpadFormat format;

  ///The maximum number of digits a user is allowed to enter based on the
  ///[NumpadFormat] used with this controller.
  late int maxRawLength;

  ///Optional text to be shown when the controller has not received any input,
  ///or after the input has been cleared.
  late String hintText;

  ///The hint text that will be shown if [hintText] is null, based on the
  ///[NumpadFormat] used with this controller.
  late String defaultHintText;

  ///Simple validation. True if [rawString.length] is equal to [maxRawLength].
  late bool inputValid;

  late int _rawNumber;
  get rawNumber => _rawNumber;

  late String _rawString;
  get rawString => _rawString;

  late String _formattedString;

  _setFormattedString(String value) {
    _formattedString = value ?? hintText ?? defaultHintText;
    notifyListeners();
  }

  get formattedString => _formattedString;

  ///Called only when [inputValid] changes value. Used, for instance, to show
  ///or hide a 'Confirm' button based on complete input. For example:
  ///
  ///```dart
  /// //...
  ///class MyWidgetState extends State<MyWidget> {
  ///   bool _confirmEnabled = false;
  ///   final _controller = NumpadController(
  ///     format: NumpadFormat.PHONE,
  ///     onInputValidChange: (bool valid) => setState((){_confirmEnabled = valid;})
  ///   );
  ///}
  /// //...
  ///```
  ValidInputCallback onInputValidChange;

  late VoidCallback _onErrorResetRequest;

  void setErrorResetListener(VoidCallback listener) {
    this._onErrorResetRequest = listener;
  }

  ///Can be called when business logic deems the [Numpad] input invalid. Used
  ///in conjunction with the [animateError] option on [NumpadText].
  void notifyErrorResetListener() {
    _onErrorResetRequest?.call();
  }

  NumpadController(
      {this.format = NumpadFormat.NONE,
      required this.hintText, required this.onInputValidChange}) {
    switch (format) {
      case NumpadFormat.NONE:
        defaultHintText = '0';
        maxRawLength = 3;
        break;
      case NumpadFormat.CURRENCY:
        defaultHintText = '0 ??';
        maxRawLength = 9;
        break;
      case NumpadFormat.AMOUNT:
        defaultHintText = '0 ??';
        maxRawLength = 9;
        break;
      case NumpadFormat.PHONE:
        defaultHintText = '(___) ___-____';
        maxRawLength = 10;
        break;
      case NumpadFormat.PIN4:
        defaultHintText = '----';
        maxRawLength = 4;
        break;
    }
    _formattedString = hintText ?? defaultHintText;
  }

  void parseInput(int input) {
    switch (input) {
      case -2: //Clear
        _rawString = '';
        if (inputValid == true) {
          inputValid = false;
          onInputValidChange?.call(inputValid);
        }
        break;
      case -1: //Backspace
        if (_rawString != null && _rawString.length > 1) {
          _rawString = _rawString.substring(0, _rawString.length - 1);
        } else {
          _rawString = '';
        }
        if (inputValid == true) {
          inputValid = false;
          onInputValidChange?.call(inputValid);
        }
        break;
      default:
        if (_rawString != null) {
          if (_rawString.length < maxRawLength) {
            _rawString += input.toString();
            print(_rawString);
            notifyListeners();
            if (_rawString.length == maxRawLength &&
                format != NumpadFormat.CURRENCY) {
              inputValid = true;
              onInputValidChange?.call(inputValid);
            }
          }
        } else {
          if (input == 0 && format == NumpadFormat.CURRENCY) {
            break;
          }
          _rawString = input.toString();
          if (format == NumpadFormat.CURRENCY) {
            inputValid = true;
            onInputValidChange?.call(inputValid);
          }
        }
        break;
    }
    if (_rawString == null) {
      _rawNumber = 0;
      _setFormattedString('');
    } else {
      _rawNumber = int.parse(_rawString);
      _setFormattedString(formatRawString(_rawString, format)!);
    }
  }

  ///Resets the controller back to its inital state.
  void clear() {
    _rawNumber = 0;
    _rawString = '';
    _formattedString = hintText ?? defaultHintText;
    notifyListeners();
  }
}
