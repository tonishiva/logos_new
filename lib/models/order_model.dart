class Order {
  double latFrom;
  double latTo;
  double lonFrom;
  double lonTo;
  DateTime arrivalBefore;
  String packgeDescription;
  String orderDescription;
  String packageType;
  double packageWidth;
  double packgeHeight;
  double packageLength;
  double packageWeight;
  DateTime departureAt;

  Order({
    this.arrivalBefore,
    this.departureAt,
    this.latFrom,
    this.latTo,
    this.lonFrom,
    this.lonTo,
    this.orderDescription = '',
    this.packageLength,
    this.packageType,
    this.packageWeight,
    this.packageWidth,
    this.packgeDescription,
    this.packgeHeight,
  });
}
