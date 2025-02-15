extension VerificaitonCheckExtension on int {
  String verificationText() {
    if(this == 0){
      return "Verification Not Required";
    } else {
      return "Verification Required";
    }
  }
}