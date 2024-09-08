class CommodityModel {
  String name;
  String url;
  String price;
  CommodityModel({required this.name, required this.url, required this.price});
}

List<CommodityModel> exampleCommodities = [
  CommodityModel(name: "Coffee Beans", url: "coffee.jpg", price: "260"),
  CommodityModel(name: "Corn Kernel", url: "corn.jpg", price: "34"),
  CommodityModel(name: "Cotton Seeds", url: "cotton.jpg", price: "485"),
  CommodityModel(name: "Generic Rice", url: "rice.jpg", price: "87"),
  CommodityModel(name: "Soya Beans", url: "soya.jpg", price: "140"),
  CommodityModel(name: "Tamarind", url: "tamarind.jpg", price: "246"),
  CommodityModel(name: "Tea", url: "tea.jpg", price: "367"),
  CommodityModel(name: "Wheat", url: "wheat.jpg", price: "68"),
];
