class PaymentCalculator {
  var taxRate;

  static double splitValue({required double value, required int numOfPeople}) {

    if(numOfPeople == 0) return value;

    var splitValue = value / numOfPeople;

    splitValue *= 100;
    splitValue = (splitValue.ceil()).toDouble();
    splitValue /= 100;

    return double.parse(splitValue.toStringAsFixed(2));
  }

  //! deprecating them for reusable split value method
  double splitTax(double totalTax, int numOfPeople) {
    var splitTax = totalTax / numOfPeople;
    return _formatTipReturn(splitTax);
  }

  double _formatTaxReturn(double tax) {
    var tempTax = tax * 100;
    tempTax = (tempTax.ceil()).toDouble();
    tempTax /= 100;
    return tempTax;
  }

  double splitTip(double totalTip, int numOfPeople) {
    var splitTax = totalTip / numOfPeople;
    return _formatTaxReturn(splitTax);
  }

  double _formatTipReturn(double tip) {
    var tempTip = tip * 100;
    tempTip = (tempTip.ceil()).toDouble();
    tempTip /= 100;
    return tempTip;
  }
}
