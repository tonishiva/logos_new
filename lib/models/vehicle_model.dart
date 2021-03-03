class Vehicle {
  Map<String, dynamic> model;
  Map<String, dynamic> make;
  Map<String, dynamic> bodyType;
  Map<String, dynamic> loadingType;
  int width;
  int height;
  int length;
  int kgAbility;

  Vehicle({
    this.bodyType,
    this.height,
    this.kgAbility = 500,
    this.length,
    this.loadingType,
    this.make,
    this.model,
    this.width,
  });
}
