extension AmountDeductionTypeExtension on String {
  String amountDeductionType() {
    if(this == "1"){
      return "Percent";
    } else {
      return "Flat";
    }
  }
}