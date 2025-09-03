import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/text_styles.dart';
import '../../../data/dummy_data.dart';
import '../../../data/models/product.dart';
import '../../../data/models/category.dart';
import '../../common/custom_app_bar.dart';
import '../../common/product_card.dart';
import '../../common/category_item.dart';
import '../search/search_screen.dart';
import '../product_detail/product_detail_screen.dart';
import '../category_products/category_products_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.home(
        onSearchTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SearchScreen(),
            ),
          );
        },
        onNotificationTap: () {
          // Handle notification tap
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBannerCarousel(),
            const SizedBox(height: AppDimensions.spacingLarge),
            _buildCategorySection(),
            const SizedBox(height: AppDimensions.spacingLarge),
            _buildPopularSection(context),
            const SizedBox(height: AppDimensions.spacingLarge),
            _buildRecentSection(context),
            const SizedBox(height: AppDimensions.spacingLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerCarousel() {
    final banners = [
      _BannerItem(
        title: '새로운 자전거를 찾고 계신가요?',
        subtitle: '다양한 브랜드의 중고 자전거를 만나보세요',
        color: AppColors.primary,
      ),
      _BannerItem(
        title: '안전한 거래를 위한 채팅',
        subtitle: '판매자와 직접 소통하며 거래하세요',
        color: AppColors.secondary,
      ),
      _BannerItem(
        title: '내 자전거도 판매해보세요',
        subtitle: '간편하게 등록하고 빠르게 판매하세요',
        color: AppColors.warning,
      ),
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        viewportFraction: 0.9,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
      ),
      items: banners.map((banner) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.marginSmall,
          ),
          decoration: BoxDecoration(
            color: banner.color,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  banner.title,
                  style: AppTextStyles.headline3.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingSmall),
                Text(
                  banner.subtitle,
                  style: AppTextStyles.body2.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
          ),
          child: Text(
            '카테고리',
            style: AppTextStyles.headline3,
          ),
        ),
        const SizedBox(height: AppDimensions.spacingMedium),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // 4열로 변경
            childAspectRatio: 0.9, // 비율 조정
            crossAxisSpacing: AppDimensions.spacingMedium,
            mainAxisSpacing: AppDimensions.spacingMedium,
          ),
          itemCount: DummyData.categories.length,
          itemBuilder: (context, index) {
            final category = DummyData.categories[index];
            return CategoryItem(
              category: category,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryProductsScreen(category: category),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildPopularSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '인기 상품',
                style: AppTextStyles.headline3,
              ),
              TextButton(
                onPressed: () {
                  // Handle see more
                },
                child: Text(
                  '더보기',
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimensions.spacingMedium),
        SizedBox(
          height: AppDimensions.productCardHeight + 20,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: DummyData.popularProducts.length,
            itemBuilder: (context, index) {
              final product = DummyData.popularProducts[index];
              return Container(
                margin: const EdgeInsets.only(
                  right: AppDimensions.marginMedium,
                ),
                child: ProductCard(
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
                  onFavorite: () {
                    // Handle favorite toggle
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '최근 등록된 상품',
                style: AppTextStyles.headline3,
              ),
              TextButton(
                onPressed: () {
                  // Handle see more
                },
                child: Text(
                  '더보기',
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimensions.spacingMedium),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: DummyData.recentProducts.length,
          itemBuilder: (context, index) {
            final product = DummyData.recentProducts[index];
            return ProductCard(
              product: product,
              type: ProductCardType.list,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      product: product,
                    ),
                  ),
                );
              },
              onFavorite: () {
                // Handle favorite toggle
              },
            );
          },
        ),
      ],
    );
  }
}

class _BannerItem {
  final String title;
  final String subtitle;
  final Color color;

  _BannerItem({
    required this.title,
    required this.subtitle,
    required this.color,
  });
}