import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mostro_mobile/data/models/order_model.dart';
import 'package:mostro_mobile/presentation/order/bloc/order_details_bloc.dart';
import 'package:mostro_mobile/presentation/order/bloc/order_details_event.dart';
import 'package:mostro_mobile/presentation/order/bloc/order_details_state.dart';
import 'package:mostro_mobile/presentation/widgets/currency_text_field.dart';
import 'package:mostro_mobile/presentation/widgets/exchange_rate_widget.dart';
import 'package:mostro_mobile/providers/riverpod_providers.dart';

class OrderDetailsScreen extends ConsumerWidget {
  final OrderModel initialOrder;

  final _satsAmountController = TextEditingController();

  OrderDetailsScreen({super.key, required this.initialOrder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderRepo = ref.watch(ordersRepositoryProvider);
    return BlocProvider(
      create: (context) =>
          OrderDetailsBloc(orderRepo)..add(LoadOrderDetails(initialOrder)),
      child: BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
        builder: (context, state) {
          if (state.status == OrderDetailsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == OrderDetailsStatus.error) {
            return Center(
                child: Text(state.errorMessage ?? 'An error occurred'));
          }
          if (state.order == null) {
            return const Center(child: Text('Order not found'));
          }
          return _buildContent(context, ref, state.order!);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, OrderModel order) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D212C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const HeroIcon(HeroIcons.arrowLeft, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('${order.type.toUpperCase()} ORDER',
            style: TextStyle(
                color: Colors.white,
                fontFamily: GoogleFonts.robotoCondensed().fontFamily)),
      ),
      body: BlocConsumer<OrderDetailsBloc, OrderDetailsState>(
          listener: (context, state) {
        if (state.status == OrderDetailsStatus.cancelled) {
          Navigator.of(context).pop();
        }
      }, builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildSellerInfo(order),
                      const SizedBox(height: 16),
                      _buildSellerAmount(order, ref),
                      const SizedBox(height: 16),
                      ExchangeRateWidget(currency: order.fiatCurrency),
                      const SizedBox(height: 16),
                      _buildBuyerInfo(order),
                      const SizedBox(height: 16),
                      _buildBuyerAmount(order),
                      const SizedBox(height: 24),
                      _buildActionButtons(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSellerInfo(OrderModel order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF303544),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            child: Text('S', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.sellerName,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text('${order.sellerRating}/5 (${order.sellerReviewCount})',
                    style: const TextStyle(color: Color(0xFF8CC541))),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              // Implementar lógica para leer reseñas
            },
            child: const Text('Read reviews',
                style: TextStyle(color: Color(0xFF8CC541))),
          ),
        ],
      ),
    );
  }

  Widget _buildSellerAmount(OrderModel order, WidgetRef ref) {
    final exchangeRateAsyncValue =
        ref.watch(exchangeRateProvider(order.fiatCurrency));
    return exchangeRateAsyncValue.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, _) => Text('Error: $error'),
      data: (exchangeRate) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF303544),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${order.fiatAmount} ${order.fiatCurrency} (${order.premium}%)',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text('${order.satsAmount} sats',
                  style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const HeroIcon(HeroIcons.creditCard,
                      style: HeroIconStyle.outline,
                      color: Colors.white,
                      size: 16),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      order.paymentMethod,
                      style: const TextStyle(color: Colors.grey),
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBuyerInfo(OrderModel order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF303544),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            child: Text('A', style: TextStyle(color: Colors.white)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Anon (you)',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text('0/5 (0)', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          HeroIcon(HeroIcons.bolt,
              style: HeroIconStyle.solid, color: Color(0xFF8CC541)),
        ],
      ),
    );
  }

  Widget _buildBuyerAmount(OrderModel order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF303544),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CurrencyTextField(controller: _satsAmountController, label: 'sats'),
          const SizedBox(height: 8),
          Text('\$ ${order.buyerFiatAmount}',
              style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          const Row(
            children: [
              HeroIcon(HeroIcons.bolt,
                  style: HeroIconStyle.solid, color: Colors.white, size: 16),
              SizedBox(width: 8),
              Text('Bitcoin Lightning Network',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              context.read<OrderDetailsBloc>().add(CancelOrder());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('CANCEL'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              context.read<OrderDetailsBloc>().add(ContinueOrder());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8CC541),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('CONTINUE'),
          ),
        ),
      ],
    );
  }
}
