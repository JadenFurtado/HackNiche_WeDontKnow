import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter/foundation.dart';

import '../../../core/common.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.settings) : super(const CurrentIndexState(PageType.home)) {
    on<HomeEvent>((event, emit) {});
    on<CurrentIndexEvent>(_currentIndex);
  }

  final Box<dynamic> settings;

  PageType currentPage = PageType.home;

  void _currentIndex(
    CurrentIndexEvent event,
    Emitter<HomeState> emit,
  ) {
    if (currentPage != event.currentPage) {
      currentPage = event.currentPage;
      emit(CurrentIndexState(event.currentPage));
    }
  }

  int getIndexFromPage(PageType currentPage) {
    switch (currentPage) {
      case PageType.accounts:
        return 1;
      case PageType.category:
        return 2;
      case PageType.budgetOverview:
        return 3;
      case PageType.suggestions:
        return 4;
      case PageType.home:
      default:
        return 0;
    }
  }

  PageType getPageFromIndex(int index) {
    switch (index) {
      case 1:
        return PageType.accounts;
      case 2:
        return PageType.category;
      case 3:
        return PageType.budgetOverview;
      case 5:
        return PageType.debts;
      case 4:
        return PageType.suggestions;
      case 0:
      default:
        return PageType.home;
    }
  }
}
