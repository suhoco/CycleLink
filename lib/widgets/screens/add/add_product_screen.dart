import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/text_styles.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();
  
  String _selectedCategory = '';
  String _selectedCondition = '좋음';
  bool _isNegotiable = false;
  List<String> _selectedImages = [];
  
  final List<String> _categories = [
    '로드바이크', '산악자전거', '하이브리드', '접이식자전거', '전기자전거', 
    '미니벨로', '픽시', '커스텀', '부품', '기타'
  ];
  
  final List<String> _conditions = ['새상품', '좋음', '보통', '나쁨'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('상품 등록'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _submitProduct,
            child: const Text(
              '완료',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildImageSection(),
              const SizedBox(height: AppDimensions.spacingMedium),
              _buildFormSection(),
              const SizedBox(height: AppDimensions.spacingXLarge),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      margin: const EdgeInsets.all(AppDimensions.marginMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '상품 사진',
                  style: AppTextStyles.subtitle1,
                ),
                const SizedBox(width: AppDimensions.spacingSmall),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingSmall,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                  ),
                  child: const Text(
                    '필수',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spacingSmall),
            Text(
              '상품 사진을 등록해주세요 (최대 5장)',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingMedium),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: AppDimensions.marginSmall),
                    child: _buildImageSlot(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSlot(int index) {
    final hasImage = index < _selectedImages.length;
    
    return GestureDetector(
      onTap: hasImage ? () => _removeImage(index) : () => _addImage(index),
      child: Container(
        decoration: BoxDecoration(
          color: hasImage ? AppColors.surface : AppColors.background,
          border: Border.all(
            color: hasImage ? Colors.transparent : AppColors.divider,
            style: hasImage ? BorderStyle.none : BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        ),
        child: hasImage
            ? Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: AppColors.primary.withOpacity(0.1),
                      child: Icon(
                        Icons.image,
                        color: AppColors.primary,
                        size: 40,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    index == 0 ? Icons.camera_alt : Icons.add,
                    color: AppColors.textLight,
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    index == 0 ? '대표' : '${index + 1}',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textLight,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildFormSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.marginMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              controller: _titleController,
              label: '제목',
              hint: '상품명을 입력해주세요',
              required: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '제목을 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.spacingLarge),
            _buildCategorySelector(),
            const SizedBox(height: AppDimensions.spacingLarge),
            _buildConditionSelector(),
            const SizedBox(height: AppDimensions.spacingLarge),
            _buildTextField(
              controller: _priceController,
              label: '가격',
              hint: '가격을 입력해주세요',
              required: true,
              keyboardType: TextInputType.number,
              suffix: '원',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                _ThousandsSeparatorInputFormatter(),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '가격을 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.spacingMedium),
            _buildNegotiableSwitch(),
            const SizedBox(height: AppDimensions.spacingLarge),
            _buildTextField(
              controller: _descriptionController,
              label: '상품 설명',
              hint: '상품에 대한 자세한 설명을 작성해주세요',
              required: true,
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '상품 설명을 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.spacingLarge),
            _buildTextField(
              controller: _locationController,
              label: '거래 희망 지역',
              hint: '거래를 희망하는 지역을 입력해주세요',
              required: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '거래 희망 지역을 입력해주세요';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool required = false,
    TextInputType? keyboardType,
    String? suffix,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTextStyles.subtitle2,
            ),
            if (required) ...[
              const SizedBox(width: AppDimensions.spacingXSmall),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 1,
                ),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Text(
                  '필수',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: AppDimensions.spacingSmall),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            suffixText: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            contentPadding: const EdgeInsets.all(AppDimensions.paddingMedium),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '카테고리',
              style: AppTextStyles.subtitle2,
            ),
            const SizedBox(width: AppDimensions.spacingXSmall),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 1,
              ),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(2),
              ),
              child: const Text(
                '필수',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spacingSmall),
        Wrap(
          spacing: AppDimensions.spacingSmall,
          runSpacing: AppDimensions.spacingSmall,
          children: _categories.map((category) {
            final isSelected = _selectedCategory == category;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMedium,
                  vertical: AppDimensions.paddingSmall,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.surface,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.divider,
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                ),
                child: Text(
                  category,
                  style: AppTextStyles.caption.copyWith(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildConditionSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '상품 상태',
          style: AppTextStyles.subtitle2,
        ),
        const SizedBox(height: AppDimensions.spacingSmall),
        Row(
          children: _conditions.map((condition) {
            final isSelected = _selectedCondition == condition;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCondition = condition;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: AppDimensions.marginXSmall),
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.paddingMedium,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.surface,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.divider,
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                  ),
                  child: Text(
                    condition,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption.copyWith(
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNegotiableSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '가격 제안 받기',
          style: AppTextStyles.subtitle2,
        ),
        Switch(
          value: _isNegotiable,
          onChanged: (value) {
            setState(() {
              _isNegotiable = value;
            });
          },
          activeColor: AppColors.primary,
        ),
      ],
    );
  }

  void _addImage(int index) {
    setState(() {
      // In a real app, this would open image picker
      _selectedImages.add('image_$index');
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('이미지 ${index + 1} 추가됨 (실제 구현 시 갤러리/카메라 연동)'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _submitProduct() {
    if (_formKey.currentState!.validate()) {
      if (_selectedImages.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('상품 사진을 최소 1장 등록해주세요'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
      
      if (_selectedCategory.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('카테고리를 선택해주세요'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }

      // In a real app, this would submit to backend
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('상품이 등록되었습니다'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }
}

class _ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove all non-digit characters
    String digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digits.isEmpty) {
      return const TextEditingValue();
    }

    // Format with commas
    String formatted = _addCommas(digits);
    
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _addCommas(String value) {
    final regex = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return value.replaceAllMapped(regex, (Match match) => '${match[1]},');
  }
}