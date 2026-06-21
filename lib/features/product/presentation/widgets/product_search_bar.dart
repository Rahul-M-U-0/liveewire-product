import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liveewire_products/core/constants/app_strings.dart';
import 'package:liveewire_products/core/widgets/custom_text_field.dart';
import 'package:liveewire_products/features/product/presentation/bloc/product_bloc.dart';

class ProductSearchBar extends StatefulWidget {
  final TextEditingController controller;

  const ProductSearchBar({
    super.key,
    required this.controller,
  });

  @override
  State<ProductSearchBar> createState() => _ProductSearchBarState();
}

class _ProductSearchBarState extends State<ProductSearchBar> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: CustomTextField(
        controller: widget.controller,
        hintText: AppStrings.searchHint,
        prefixIcon: const Icon(Icons.search),
        onChanged: (query) {
          if (_debounce?.isActive ?? false) _debounce!.cancel();
          _debounce = Timer(const Duration(milliseconds: 500), () {
            context.read<ProductBloc>().add(
                  FilterProductsEvent(query: query),
                );
          });
        },
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: widget.controller,
          builder: (context, value, _) {
            return value.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      widget.controller.clear();
                      context.read<ProductBloc>().add(
                            const FilterProductsEvent(query: ''),
                          );
                    },
                  )
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
