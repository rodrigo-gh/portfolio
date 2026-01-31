import 'package:flutter/material.dart';
import 'package:portfolio/features/portfolio/widgets/status_counter.dart';

Widget statusBanner(BuildContext context) {
  return SliverToBoxAdapter(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          statusCounter(context, "1", "Sistema Web\nem Produção", Icons.public),
          statusCounter(context, "1", "App na Loja\n(Beta)", Icons.shop),
          statusCounter(context, "2", "Apps em\nDesenvolvimento", Icons.code),
        ],
      ),
    ),
  );
}
