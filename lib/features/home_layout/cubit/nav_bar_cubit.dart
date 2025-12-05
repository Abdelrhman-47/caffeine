

import 'package:caffeine/features/home_layout/cubit/nav_bar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarState(index: 0));
  
  void changeIndex(int newIndex) { 
    emit(NavBarState(index: newIndex));  
  }
}

