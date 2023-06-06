part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardLoading extends DashboardState {}

class DashboardError extends DashboardState {
  final AppException exeption;
  const DashboardError({required this.exeption});

  @override
  List<Object> get props => [exeption];
}

class DashboardSucces extends DashboardState {
  final List<BannerEntity> banners;
  final List<ItemEntity> bestSellingCards;
  final List<ItemEntity> gameGiftCards;

  const DashboardSucces(
      {required this.banners,
      required this.bestSellingCards,
      required this.gameGiftCards});
}
