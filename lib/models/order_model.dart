class Order {
  double latFrom;
  double latTo;
  double lonFrom;
  double lonTo;
  DateTime arrivalBefore;
  String packageDescription;
  String orderDescription;
  String packageType;
  double packageWidth;
  double packageHeight;
  double packageLength;
  double packageWeight;
  DateTime departureAt;
  String originAddress;
  String destinationAddress;

  Order({
    this.arrivalBefore,
    this.departureAt,
    this.latFrom,
    this.latTo,
    this.lonFrom,
    this.lonTo,
    this.orderDescription = '',
    this.packageLength,
    this.packageType = 'pallet',
    this.packageWeight,
    this.packageWidth,
    this.packageDescription,
    this.packageHeight,
    this.originAddress,
    this.destinationAddress,
  });
}
