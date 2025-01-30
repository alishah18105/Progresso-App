import 'package:flutter/material.dart';
abstract class ThemeBase {
  Color get text1;
  Color get text2;
  Color get text3;
  Color get statustext;

  Color get tileColor1;
  Color get tileColor2;

  Color get gradient1;
  Color get gradient2;
  Color get gradient3;

  Color get iconColor;
  Color get iconButtonColor;
}

class LightTheme implements ThemeBase {
  @override
  Color text1 = Color(0xFF1A2C6D);
  @override
  Color text2 = Color(0xFF2C3E56);
  @override
  Color text3 = Color(0xFF5A5A5A);
  @override
  Color statustext = Color(0xFF1A2C6D);

  @override
  Color tileColor1 = const Color(0xFFFFEDD5);
  @override
  Color tileColor2 = const Color(0xFFDC9B9B);

  @override
  Color gradient1 = Color(0xFFFFEDD5);
  @override
  Color gradient2 = Color(0xFFFAD4D4);
  @override
  Color gradient3 = Color(0xFFFFFFFF);

  @override
  Color iconColor = Color(0xFFE91E63);
  @override
  Color iconButtonColor = Colors.white;
}

class DarkTheme implements ThemeBase {
  @override
  Color text1 = Colors.white;
  @override
  Color text2 = const Color(0xFF4A90E2);
  @override
  Color text3 = Colors.white60;
  @override
  Color statustext = const Color(0xFFB22222);

  @override
  Color tileColor1 = const Color(0xFF2F353D);
  @override
  Color tileColor2 = const Color(0xFF5E5A78);

  @override
  Color gradient1 = const Color(0xFF1C1F26);
  @override
  Color gradient2 = const Color(0xFF1A202E);
  @override
  Color gradient3 = const Color(0xFF232A3A);

  @override
  Color iconColor = const Color(0xFF40E0D0);
  @override
  Color iconButtonColor = Colors.black;
}


//static Color gradient1 =   Color(0xFFFFEDD5);//Color(0xFFFFEDD5);
// static Color gradient2 =  Color(0xFFFAD4D4); //Color(0xFFDC9B9B);
 // static Color  gradient3 = Color(0xFFFFFFFF); //Color(0xFF2C3E56);
