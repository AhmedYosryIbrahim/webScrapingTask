class Product {
  final String title;
  final String image;
  final List<Price> priceList;
  Product({
    required this.title,
    required this.image,
    this.priceList = const [],
  });
}

class Price {
  final String image;
  final String name;
  final double price;
  final bool stock;

  Price({
    required this.image,
    required this.name,
    required this.price,
    required this.stock,
  });
}