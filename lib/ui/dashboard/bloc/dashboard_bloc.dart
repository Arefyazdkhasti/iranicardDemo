import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iranicard_demo/data/repository/auth_repository.dart';
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
      if (event is DashboardStarted) { // at first initial of the screen, load data from remoteRepository
        try {
           // show loading before data feteched
          emit(DashboardLoading());
          final accessTocken = await authRepository.loadAuthInfo();
          final banners = await bannerRepository.getAll(accessTocken);
          final onlineShoppings = await itemRepository.getAllOnlineShopping(accessTocken);
          final giftShops = await itemRepository.getAllGiftCards(accessTocken);
          //emit succes and pass list to Ui in order to show to the user
          emit(DashboardSucces(
              banners: banners, onlineShoppings: onlineShoppings, gameGiftCards: giftShops));
        } catch (e) {
          //emit error if sth happended
          emit(
              DashboardError(exeption: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
