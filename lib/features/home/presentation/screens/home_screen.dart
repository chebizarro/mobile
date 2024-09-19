import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mostro_mobile/features/home/presentation/bloc/home_event.dart';
import 'package:mostro_mobile/features/home/presentation/bloc/home_state.dart';
import '../bloc/home_bloc.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/order_list.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D212C),
      appBar: const CustomAppBar(),
      body: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 16), // Añadido margen
        decoration: BoxDecoration(
          color: const Color(0xFF303544),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            _buildTabs(),
            _buildFilterButton(),
            Expanded(
              child: _buildOrderList(),
            ),
            const BottomNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1D212C),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildTab("BUY BTC", state.orderType == OrderType.buy),
              ),
              Expanded(
                child: _buildTab("SELL BTC", state.orderType == OrderType.sell),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTab(String text, bool isActive) {
    return GestureDetector(
      onTap: () {
        // Aquí debes agregar la lógica para cambiar el tipo de orden
        // context.read<HomeBloc>().add(ChangeOrderType(isActive ? OrderType.buy : OrderType.sell));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF303544) : const Color(0xFF1D212C),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isActive ? 20 : 0),
            topRight: Radius.circular(isActive ? 20 : 0),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isActive ? const Color(0xFF8CC541) : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          OutlinedButton.icon(
            onPressed: () {},
            icon: const HeroIcon(HeroIcons.funnel,
                style: HeroIconStyle.outline, color: Colors.white),
            label: const Text("FILTER", style: TextStyle(color: Colors.white)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            "3 offers",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == HomeStatus.loaded) {
          return OrderList(orders: state.filteredOrders);
        } else {
          return const Center(child: Text('Error loading orders'));
        }
      },
    );
  }
}
