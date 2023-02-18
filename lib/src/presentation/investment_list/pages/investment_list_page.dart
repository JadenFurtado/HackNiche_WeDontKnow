import 'package:flutter/material.dart';
import 'package:paisa/src/data/suggestion/models/investment_product_model.dart';

class InvestmentListPage extends StatelessWidget {
  const InvestmentListPage({
    Key? key,
    required this.title,
    required this.products,
  }) : super(key: key);

  final String title;
  final List<InvestmentProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.productName),
            subtitle: Text(
                "${product.productMetadata.creditRating}\n₹${product.productMetadata.cost}\n${product.productMetadata.quantity}"),
            isThreeLine: true,
          );
        },
      ),
    );
  }
}
