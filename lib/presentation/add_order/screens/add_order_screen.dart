import 'package:bitcoin_icons/bitcoin_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mostro_mobile/core/theme/app_theme.dart';
import 'package:mostro_mobile/presentation/add_order/bloc/add_order_bloc.dart';
import 'package:mostro_mobile/presentation/add_order/bloc/add_order_event.dart';
import 'package:mostro_mobile/presentation/add_order/bloc/add_order_state.dart';
import 'package:mostro_mobile/presentation/home/bloc/home_state.dart';
import 'package:mostro_mobile/presentation/widgets/currency_dropdown.dart';
import 'package:mostro_mobile/presentation/widgets/currency_text_field.dart';
import 'package:mostro_mobile/providers/riverpod_providers.dart';

class AddOrderScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  AddOrderScreen({super.key});

  final _fiatCodeController = TextEditingController();
  final _fiatAmountController = TextEditingController();
  final _satsAmountController = TextEditingController();
  final _paymentMethodController = TextEditingController();
  final _lightningInvoiceController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderRepo = ref.watch(ordersRepositoryProvider);
    return BlocProvider(
      create: (context) => AddOrderBloc(orderRepo),
      child: BlocBuilder<AddOrderBloc, AddOrderState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppTheme.dark1,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const HeroIcon(HeroIcons.arrowLeft, color: AppTheme.cream1),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text('NEW ORDER',
                  style: TextStyle(
                      color: AppTheme.cream1,
                      fontFamily: GoogleFonts.robotoCondensed().fontFamily)),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    decoration: BoxDecoration(
                      color: AppTheme.dark2,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildTabs(context, state),
                            Expanded(
                              child: state.currentType == OrderType.sell
                                  ? _buildSellForm(context)
                                  : _buildBuyForm(context),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabs(BuildContext context, AddOrderState state) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.dark1,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTab(context, "SELL",
                state.currentType == OrderType.sell, OrderType.sell),
          ),
          Expanded(
            child: _buildTab(context, "BUY", state.currentType == OrderType.buy,
                OrderType.buy),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
      BuildContext context, String text, bool isActive, OrderType type) {
    return GestureDetector(
      onTap: () {
        context.read<AddOrderBloc>().add(ChangeOrderType(type));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.dark2 : AppTheme.dark1,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isActive ? 20 : 0),
            topRight: Radius.circular(isActive ? 20 : 0),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isActive ? AppTheme.cream1 : AppTheme.grey2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSellForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Make sure your order is below 20K sats',
              style: TextStyle(color: AppTheme.grey2)),
          const SizedBox(height: 16),
          CurrencyDropdown(label: 'Fiat code', onChanged: (v) {}),
          const SizedBox(height: 16),
          CurrencyTextField(
              controller: _fiatAmountController, label: 'Fiat amount'),
          const SizedBox(height: 16),
          _buildFixedToggle(),
          const SizedBox(height: 16),
          _buildTextField('Sats amount', _satsAmountController,
              suffix: Icon(BitcoinIcons.satoshi_v1_outline).icon),
          const SizedBox(height: 16),
          _buildTextField('Payment method', _paymentMethodController),
          const SizedBox(height: 32),
          _buildActionButtons(context, OrderType.sell),
        ],
      ),
    );
  }

  Widget _buildBuyForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Make sure your order is below 20K sats',
              style: TextStyle(color: AppTheme.grey2)),
          const SizedBox(height: 16),
          CurrencyDropdown(label: 'Fiat code', onChanged: (v) {}),
          const SizedBox(height: 16),
          CurrencyTextField(
              controller: _fiatAmountController, label: 'Fiat amount'),
          const SizedBox(height: 16),
          _buildFixedToggle(),
          const SizedBox(height: 16),
          _buildTextField('Sats amount', _satsAmountController,
              suffix: Icon(BitcoinIcons.satoshi_v1_outline).icon),
          const SizedBox(height: 16),
          _buildTextField('Lightning Invoice without an amount',
              _lightningInvoiceController),
          const SizedBox(height: 16),
          _buildTextField('Payment method', _paymentMethodController),
          const SizedBox(height: 32),
          _buildActionButtons(context, OrderType.sell),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {IconData? suffix}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.dark1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: AppTheme.cream1),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          labelStyle: const TextStyle(color: AppTheme.grey2),
          suffixIcon:
              suffix != null ? Icon(suffix, color: AppTheme.grey2) : null,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a value';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildFixedToggle() {
    return Row(
      children: [
        const Text('Fixed', style: TextStyle(color: AppTheme.cream1)),
        const SizedBox(width: 8),
        Switch(
          value: false, // You should manage this state in the bloc
          onChanged: (value) {
            // Update the state in the bloc
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, OrderType orderType) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('CANCEL', style: TextStyle(color: AppTheme.red2)),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text('Submitting order ${_satsAmountController.text}')),
              );

              context.read<AddOrderBloc>().add(SubmitOrder(
                    fiatCode: _fiatCodeController.text,
                    fiatAmount: double.parse(_fiatAmountController.text),
                    satsAmount: int.parse(_satsAmountController.text),
                    paymentMethod: _paymentMethodController.text,
                    orderType: orderType,
                  ));
              // For now, just print the values and close the screen
              print('Fiat Code: ${_fiatCodeController.text}');
              print('Fiat Amount: ${_fiatAmountController.text}');
              print('Sats Amount: ${_satsAmountController.text}');
              print('Payment Method: ${_paymentMethodController.text}');
              if (_lightningInvoiceController.text.isNotEmpty) {
                print('Lightning Invoice: ${_lightningInvoiceController.text}');
              }
              Navigator.of(context).pop();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.mostroGreen,
          ),
          child: const Text('SUBMIT'),
        ),
      ],
    );
  }
}
