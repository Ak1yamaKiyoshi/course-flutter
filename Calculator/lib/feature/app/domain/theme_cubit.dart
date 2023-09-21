import 'dart:ui';
import 'styling.dart' as styling;
import 'package:bloc/bloc.dart';
part './theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(
      ThemeState(
        theme: styling.theme,
      )
  );

  Map setThemeParameter(theme, parameter, value) {
    Map newtheme = Map.from(theme);
    newtheme[parameter] = value;
    return newtheme;
  }

  void updateTheme(parameter, value) => emit(
      ThemeState(
          theme:
          state.theme = setThemeParameter(
              state.theme,
              parameter,
              value
          )
      )
  );

  void updateNeumorphism(value) => emit(
    ThemeState(
      theme: state.theme = setThemeParameter(
          state.theme,
          "neumorphism",
          value
      )
    )
  );

  void updateAdditional(value) => emit(
      ThemeState(
          theme: state.theme = setThemeParameter(
              state.theme,
              "additional",
              value
          )
      )
  );

}