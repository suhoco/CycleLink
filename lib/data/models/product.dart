class Product {
  final String id;
  final String title;
  final int price;
  final String description;
  final List<String> images;
  final String category;
  final String location;
  final DateTime createdAt;
  final bool isFavorite;
  final Seller seller;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.category,
    required this.location,
    required this.createdAt,
    required this.isFavorite,
    required this.seller,
  });

  Product copyWith({
    String? id,
    String? title,
    int? price,
    String? description,
    List<String>? images,
    String? category,
    String? location,
    DateTime? createdAt,
    bool? isFavorite,
    Seller? seller,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      images: images ?? this.images,
      category: category ?? this.category,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
      seller: seller ?? this.seller,
    );
  }
}

class Seller {
  final String id;
  final String nickname;
  final String profileImage;
  final String location;
  final List<Product> otherProducts;

  const Seller({
    required this.id,
    required this.nickname,
    required this.profileImage,
    required this.location,
    required this.otherProducts,
  });

  Seller copyWith({
    String? id,
    String? nickname,
    String? profileImage,
    String? location,
    List<Product>? otherProducts,
  }) {
    return Seller(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      profileImage: profileImage ?? this.profileImage,
      location: location ?? this.location,
      otherProducts: otherProducts ?? this.otherProducts,
    );
  }
}