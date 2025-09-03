import 'package:flutter/material.dart';
import '../../../core/constants/dimensions.dart';
import '../../../data/dummy_data.dart';
import '../../../data/models/category.dart';
import '../../common/product_card.dart';
import '../product_detail/product_detail_screen.dart';

class CategoryProductsScreen extends StatelessWidget {
  final Category category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final products = DummyData.getProductsByCategory(category.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: products.isEmpty
          ? const Center(
              child: Text('이 카테고리에는 아직 상품이 없습니다.'),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: AppDimensions.spacingMedium,
                mainAxisSpacing: AppDimensions.spacingMedium,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  type: ProductCardType.grid,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: product,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
