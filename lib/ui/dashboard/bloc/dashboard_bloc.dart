import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iranicard_demo/data/repository/banner_repository.dart';
import '../../../common/exception.dart';
import '../../../data/model/BannerEntity.dart';
import '../../../data/model/ItemEntity.dart';
import '../../../data/repository/item_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final IBannerRepository bannerRepository;
  final IItemRepository itemRepository;

  DashboardBloc({required this.bannerRepository, required this.itemRepository}) : super(DashboardLoading()) {
    on<DashboardEvent>((event, emit) async {
      if (event is DashboardStarted) {
        try {
          emit(DashboardLoading());
          final banners = await bannerRepository.getAll();
          final onlineShoppings = await itemRepository.getAllOnlineShopping();
          final giftShops = await itemRepository.getAllGiftCards();

          emit(DashboardSucces(
              banners: banners, onlineShoppings: onlineShoppings, gameGiftCards: giftShops));
        } catch (e) {
          emit(
              DashboardError(exeption: e is AppException ? e : AppException(message :e.toString())));
        }
      }
    });
  }
}
