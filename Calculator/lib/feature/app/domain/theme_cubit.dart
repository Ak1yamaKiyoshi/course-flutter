import 'dart:ui';
import 'styling.dart' as styling;
import 'package:bloc/bloc.dart';
part './theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(
      ThemeState(
        main: styling.originMain,
        secondary: styling.originSecondary,
        accent: styling.originAccent,
        text: styling.originText,
        borderRadius: styling.borderRadius,
        borderWidth: styling.borderWidth,
        gridXAxisSpacing: styling.gridXAxisSpacing,
        gridYAxisSpacing: styling.gridXAxisSpacing,
        buttonBlur: styling.buttonBlur,
        isAutumnTheme: false,
        isNeumorphismTheme: true,
        showAdditionalButtons: false,
      )
  );

  void updateBorderRadius(newBorderRadius) => emit(
    ThemeState(
        main: state.main,
        secondary: state.secondary,
        accent: state.accent,
        text: state.text,
        gridYAxisSpacing: state.gridYAxisSpacing,
        gridXAxisSpacing: state.gridXAxisSpacing,
        buttonBlur: state.buttonBlur,
        borderRadius: newBorderRadius,
        gridRratio: state.gridRratio,
        borderWidth: state.borderWidth,
        isAutumnTheme: state.isAutumnTheme,
        isNeumorphismTheme: state.isNeumorphismTheme,
        showAdditionalButtons: state.showAdditionalButtons
    )
  );
  void updateBorderWidth(newBorderWidth) => emit(
      ThemeState(
          main: state.main,
          secondary: state.secondary,
          accent: state.accent,
          text: state.text,
          gridYAxisSpacing: state.gridYAxisSpacing,
          gridXAxisSpacing: state.gridXAxisSpacing,
          buttonBlur: state.buttonBlur,
          borderRadius: state.borderRadius,
          borderWidth: newBorderWidth,
          gridRratio: state.gridRratio,
          isAutumnTheme: state.isAutumnTheme,
          isNeumorphismTheme: state.isNeumorphismTheme,
          showAdditionalButtons: state.showAdditionalButtons
      )
  );

  void updateButtonBlur(newButtonBlur) => emit(
      ThemeState(
          main: state.main,
          secondary: state.secondary,
          accent: state.accent,
          text: state.text,
          gridYAxisSpacing: state.gridYAxisSpacing,
          gridXAxisSpacing: state.gridXAxisSpacing,
          buttonBlur: newButtonBlur,
          gridRratio: state.gridRratio,
          borderRadius: state.borderRadius,
          borderWidth: state.borderWidth,
          isAutumnTheme: state.isAutumnTheme,
          isNeumorphismTheme: state.isNeumorphismTheme,
          showAdditionalButtons: state.showAdditionalButtons
      )
  );
  void updateGridXSpacing(newValue) => emit(
      ThemeState(
          main: state.main,
          secondary: state.secondary,
          accent: state.accent,
          text: state.text,
          gridYAxisSpacing: state.gridYAxisSpacing,
          gridXAxisSpacing: newValue,
          gridRratio: state.gridRratio,
          buttonBlur: state.buttonBlur,
          borderRadius: state.borderRadius,
          borderWidth: state.borderWidth,
          isAutumnTheme: state.isAutumnTheme,
          isNeumorphismTheme: state.isNeumorphismTheme,
          showAdditionalButtons: state.showAdditionalButtons
      )
  );
  void updateGridYSpacing(newValue) => emit(
      ThemeState(
          main: state.main,
          secondary: state.secondary,
          accent: state.accent,
          text: state.text,
          gridRratio: state.gridRratio,
          gridYAxisSpacing: newValue,
          gridXAxisSpacing: state.gridXAxisSpacing,
          buttonBlur: state.buttonBlur,
          borderRadius: state.borderRadius,
          borderWidth: state.borderWidth,
          isAutumnTheme: state.isAutumnTheme,
          isNeumorphismTheme: state.isNeumorphismTheme,
          showAdditionalButtons: state.showAdditionalButtons
      )
  );
  void updateGridRatio(newValue) => emit(
      ThemeState(
          main: state.main,
          secondary: state.secondary,
          accent: state.accent,
          text: state.text,
          gridRratio: newValue,
          gridYAxisSpacing: state.gridYAxisSpacing,
          gridXAxisSpacing: state.gridXAxisSpacing,
          buttonBlur: state.buttonBlur,
          borderRadius: state.borderRadius,
          borderWidth: state.borderWidth,
          isAutumnTheme: state.isAutumnTheme,
          isNeumorphismTheme: state.isNeumorphismTheme,
          showAdditionalButtons: state.showAdditionalButtons
      )
  );
  void updateNeumorphism(newValue) => emit(
      ThemeState(
          main: state.main,
          secondary: state.secondary,
          accent: state.accent,
          text: state.text,
          gridRratio: state.gridRratio,
          gridYAxisSpacing: state.gridYAxisSpacing,
          gridXAxisSpacing: state.gridXAxisSpacing,
          buttonBlur: state.buttonBlur,
          borderRadius: state.borderRadius,
          borderWidth: state.borderWidth,
          isAutumnTheme: state.isAutumnTheme,
          isNeumorphismTheme: newValue,
          showAdditionalButtons: state.showAdditionalButtons
      )
  );

  void updateMain(newValue) => emit(
      ThemeState(
          main: newValue,
          secondary: state.secondary,
          accent: state.accent,
          text: state.text,
          gridRratio: state.gridRratio,
          gridYAxisSpacing: state.gridYAxisSpacing,
          gridXAxisSpacing: state.gridXAxisSpacing,
          buttonBlur: state.buttonBlur,
          borderRadius: state.borderRadius,
          borderWidth: state.borderWidth,
          isAutumnTheme: state.isAutumnTheme,
          isNeumorphismTheme: state.isNeumorphismTheme,
          showAdditionalButtons: state.showAdditionalButtons
      )
  );

  void updateSecondary(newValue) => emit(
      ThemeState(
          main: state.main,
          secondary: newValue,
          accent: state.accent,
          text: state.text,
          gridRratio: state.gridRratio,
          gridYAxisSpacing: state.gridYAxisSpacing,
          gridXAxisSpacing: state.gridXAxisSpacing,
          buttonBlur: state.buttonBlur,
          borderRadius: state.borderRadius,
          borderWidth: state.borderWidth,
          isAutumnTheme: state.isAutumnTheme,
          isNeumorphismTheme: state.isNeumorphismTheme,
          showAdditionalButtons: state.showAdditionalButtons
      )
  );

  void updateText(newValue) => emit(
      ThemeState(
          main: state.main,
          secondary: state.secondary,
          accent: state.accent,
          text: newValue,
          gridRratio: state.gridRratio,
          gridYAxisSpacing: state.gridYAxisSpacing,
          gridXAxisSpacing: state.gridXAxisSpacing,
          buttonBlur: state.buttonBlur,
          borderRadius: state.borderRadius,
          borderWidth: state.borderWidth,
          isAutumnTheme: state.isAutumnTheme,
          isNeumorphismTheme: state.isNeumorphismTheme,
          showAdditionalButtons: state.showAdditionalButtons
      )
  );

  void updateAccent(newValue) => emit(
      ThemeState(
          main: state.main,
          secondary: state.secondary,
          accent: newValue,
          text: state.text,
          gridRratio: state.gridRratio,
          gridYAxisSpacing: state.gridYAxisSpacing,
          gridXAxisSpacing: state.gridXAxisSpacing,
          buttonBlur: state.buttonBlur,
          borderRadius: state.borderRadius,
          borderWidth: state.borderWidth,
          isAutumnTheme: state.isAutumnTheme,
          isNeumorphismTheme: state.isNeumorphismTheme,
          showAdditionalButtons: state.showAdditionalButtons
      )
  );


/*
  void updateBorderRadius() => emit(
    ThemeState(
        main: state.main,
        secondary: state.secondary,
        accent: state.accent,
        text: state.text,
        gridYAxisSpacing: state.gridYAxisSpacing,
        gridXAxisSpacing: state.gridXAxisSpacing,
        buttonBlur: state.buttonBlur,
        borderRadius: state.borderRadius,
        borderWidth: state.borderWidth,
        isAutumnTheme: state.isAutumnTheme,
        isNeumorphismTheme: state.isNeumorphismTheme,
        showAdditionalButtons: state.showAdditionalButtons
    )
  );
  */
}