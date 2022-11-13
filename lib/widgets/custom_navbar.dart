import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timescom/theme/app_theme.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      backgroundColor: Colors.black,
      unselectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      selectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.house, color: Colors.white,),
          label: 'Inicio',
        ),

        BottomNavigationBarItem(
          icon: CircleAvatar(
            backgroundColor: AppTheme.primary,
            radius: 20,
            child: FaIcon(FontAwesomeIcons.plus, color: Colors.white,),
          ),
          label: 'Nuevo',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.timer, color: Colors.white,),
          label: 'Pomodoro',
        )
      ],
      onTap: (value) {
        print(value);
      },
    );
  }
}

