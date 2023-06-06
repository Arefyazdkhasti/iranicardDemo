import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iranicard_demo/common/exception.dart';
import 'package:iranicard_demo/data/model/BannerEntity.dart';
import 'package:iranicard_demo/data/model/ItemEntity.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardLoading()) {
    on<DashboardEvent>((event, emit) async {
      if (event is DashboardStarted) {
      }
    });
  }
}
