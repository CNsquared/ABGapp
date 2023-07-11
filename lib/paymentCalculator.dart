class paymentCalculator {
  var taxRate;

  double splitTax(double totalTax, int numOfPeople) {
    var splitTax = totalTax / numOfPeople;
    return _formatTaxReturn(splitTax);
  }

  double _formatTaxReturn(double tax) {
    var tempTax = tax * 100;
    tempTax = tempTax.ceil() as double;
    tempTax /= 100;
    return tempTax;
  }

  double splitTip(double totalTip, int numOfPeople) {
    var splitTax = totalTip / numOfPeople;
    return _formatTaxReturn(splitTax);
  }

  double _formatTipReturn(double tip) {
    var tempTip = tip * 100;
    tempTip = tempTip.ceil() as double;
    tempTip /= 100;
    return tempTip;
  }
}
