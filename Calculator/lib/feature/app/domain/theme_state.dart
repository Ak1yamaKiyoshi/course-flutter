

part of 'theme_cubit.dart';

class ThemeState {
  Color main;
  Color secondary;
  Color accent;
  Color text;

  double borderRadius;
  double borderWidth;

  double buttonBlur;

  double gridRratio;
  double gridXAxisSpacing;
  double gridYAxisSpacing;

  bool isAutumnTheme;
  bool isNeumorphismTheme;
  bool showAdditionalButtons;

  ThemeState({
    this.main=styling.originMain,
    this.secondary=styling.originSecondary,
    this.accent=styling.originAccent,
    this.text=styling.originText,
    this.gridYAxisSpacing=styling.gridYAxisSpacing,
    this.gridXAxisSpacing=styling.gridXAxisSpacing,
    this.buttonBlur=styling.buttonBlur,
    this.borderRadius=styling.borderRadius,
    this.borderWidth=styling.borderWidth,
    this.isAutumnTheme=false,
    this.isNeumorphismTheme=true,
    this.showAdditionalButtons=false,
    this.gridRratio=1,
  });
}
