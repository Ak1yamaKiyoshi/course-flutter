
  import 'dart:ui';
  import 'styling.dart' as styling;
  import 'package:bloc/bloc.dart';
  import './theme.dart';

  part './theme_state.dart';

  class ThemeCubit extends Cubit<ThemeState> {
    ThemeCubit() : super(
        ThemeState()
    );

    void updateTheme(parameter, value) => emit(
        ThemeState(
            theme: state.theme = state.theme.copyWith(parameter, value)
        )
    );


    void updateNeumorphism(value) => emit(
        ThemeState(
            theme: state.theme = state.theme.copyWith("neumorphism", value)
        )
    );

    void updateAdditional(value) => emit(
        ThemeState(
            theme: state.theme = state.theme.copyWith("additional", value)
        )
    );

  }