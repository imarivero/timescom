import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timescom/providers/alumno_provider.dart';
import 'package:timescom/providers/auth_provider.dart';
import 'package:timescom/theme/app_theme.dart';

class CustomDrawer extends StatelessWidget {

  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _HeaderPicInfo(),
          _DrawerMenuItems(),
        ],
      ),
    );
  }
}

class _HeaderPicInfo extends StatelessWidget {
  const _HeaderPicInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final alumnoProvider = Provider.of<AlumnoProvider>(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: 24
      ),
      color: AppTheme.primary,
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://images.unsplash.com/flagged/photo-1566127992631-137a642a90f4'),
          ),

          const SizedBox(height: 12,),
          
          Text('${alumnoProvider.alumno!.nombre} ${alumnoProvider.alumno!.apellidoPaterno}',
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          
          Text(alumnoProvider.alumno!.correo,
            style: GoogleFonts.inter(fontSize: 18),
          ),


        ],
      ),
    );
  }
}

class _DrawerMenuItems extends StatelessWidget {

  const _DrawerMenuItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        // Vertical spacing
        runSpacing: 16,
        children: [

          ListTile(
            leading: const Icon(Icons.person),
            title: Text('Perfil',
              style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold,)),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: Text('Desempeño',
              style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold,)),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.lightbulb),
            title: Text('Sugerencias',
              style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold,)),
            onTap: () {},
          ),
          
          ListTile(
            leading: const Icon(Icons.lock),
            title: Text('Cerrar Sesión',
              style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold,)),
            onTap: () {
              // FirebaseAuth.instance.signOut();
              authProvider.signOut();
              Navigator.pushNamedAndRemoveUntil(context, 'wrapper', (route) => false);
            },
          ),

        ],
      ),
    );
  }
}