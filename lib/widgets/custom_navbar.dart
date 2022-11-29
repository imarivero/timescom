import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      backgroundColor: Colors.black,
      unselectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      selectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.house, color: Colors.white,),
          label: 'Inicio',
        ),

        // BottomNavigationBarItem(
        //   icon: CircleAvatar(
        //     backgroundColor: AppTheme.primary,
        //     radius: 20,
        //     child: FaIcon(FontAwesomeIcons.plus, color: Colors.white,),
        //   ),
        //   label: 'Nuevo',
        // ),

        // foo item para mantener la separacion en la barra
        BottomNavigationBarItem(
          icon: Icon(Icons.space_bar, color: Colors.black,),
          label: '',
        ),
        
        BottomNavigationBarItem(
          icon: Icon(Icons.timer, color: Colors.white,),
          label: 'Pomodoro',
        )
      ],
      onTap: (value) {
        // print(value);
        switch (value) {
          case 0:
            Navigator.pushNamed(context, 'mainMatrizScreen');
            break;
          case 1:
            Navigator.pushNamed(context, 'regisAlumnoScreen');
            break;
          case 2:
            Navigator.pushNamed(context, 'pomodoroPage');
            break;
          default:
            print('error');
            break;
        }
      },
    );
  }
}

