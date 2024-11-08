import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mostro_mobile/presentation/home/bloc/home_bloc.dart';
import 'package:mostro_mobile/presentation/home/bloc/home_event.dart';
import 'package:mostro_mobile/presentation/home/bloc/home_state.dart';
import 'package:mostro_mobile/presentation/widgets/bottom_nav_bar.dart';
import 'package:mostro_mobile/presentation/widgets/custom_app_bar.dart';
import 'package:mostro_mobile/presentation/widgets/order_filter.dart';
import 'package:mostro_mobile/presentation/widgets/order_list.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:mostro_mobile/providers/riverpod_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Cargar las órdenes cuando se inicia la pantalla
    context.read<HomeBloc>().add(LoadOrders());
    return Portal(
        child: Scaffold(
      backgroundColor: const Color(0xFF1D212C),
      appBar: const CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeBloc>().add(LoadOrders());
          await Future.delayed(const Duration(seconds: 1));
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            color: const Color(0xFF303544),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              _buildTabs(),
              _buildFilterButton(context),
              const SizedBox(height: 6.0),
              Expanded(
                child: _buildOrderList(ref),
              ),
              const BottomNavBar(),
            ],
          ),
        ),
      ),
    ));
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
                child: _buildTab("BUY BTC", state.orderType == OrderType.buy,
                    OrderType.buy, context),
              ),
              Expanded(
                child: _buildTab("SELL BTC", state.orderType == OrderType.sell,
                    OrderType.sell, context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTab(
      String text, bool isActive, OrderType type, BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<HomeBloc>().add(ChangeOrderType(type));
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

  Widget _buildFilterButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          PortalTarget(
            visible: false,
            anchor: Aligned(
              follower: Alignment.topLeft,
              target: Alignment.bottomCenter,
            ),
            portalFollower: Padding(
              padding: const EdgeInsets.all(16.0),
              child: OrderFilter(),
            ),
            child: OutlinedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: OrderFilter(),
                    );
                  },
                );
              },
              icon: const HeroIcon(HeroIcons.funnel,
                  style: HeroIconStyle.outline, color: Colors.white),
              label:
                  const Text("FILTER", style: TextStyle(color: Colors.white)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Text(
                "${state.filteredOrders.length} offers",
                style: const TextStyle(color: Colors.white),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(WidgetRef ref) {
    //final homeBloc = ref.watch(homeBlocProvider);
    return BlocBuilder<HomeBloc, HomeState>(
      //bloc: homeBloc,
      builder: (context, state) {
        if (state.status == HomeStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == HomeStatus.loaded) {
          if (state.filteredOrders.isEmpty) {
            return const Center(
              child: Text(
                'No orders available for this type',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return OrderList(orders: state.filteredOrders);
        } else {
          return const Center(
              child: Text('Error loading orders',
                  style: TextStyle(color: Colors.white)));
        }
      },
    );
  }
}
