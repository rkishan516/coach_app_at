import 'dart:math';

class VyCode {
  static VyCode instance = VyCode._();
  VyCode._();
  String getNextVyCode(String vyCode) {
    return getDecimalToVy(getVyToDecimal(vyCode) + 1);
  }

  int getVyToDecimal(String vyCode) {
    int i, j, n = vyCode.length, dec = 0, c;

    for (i = n; i > 0; --i) {
      c = vyCode[i - 1].codeUnitAt(0);
      if (c < 58) {
        j = c - 48;
      } else if (c < 91) {
        j = 10 + c - 65;
      } else {
        j = 36 + c - 97;
      }
      dec += (j * pow(62, n - i)).toInt();
    }

    return dec;
  }

  String getDecimalToVy(int val) {
    String vyCode = '';
    int i;
    while (val > 0) {
      i = val % 62;

      if (i < 10) {
        vyCode += i.toString();
      } else if (i < 36) {
        i -= 10;
        vyCode += (String.fromCharCode((i + 65)));
      } else {
        i -= 36;
        vyCode += (String.fromCharCode(((i + 97))));
      }

      val ~/= 62;
    }
    return vyCode.split('').reversed.join().padLeft(4, '0');
  }
}
