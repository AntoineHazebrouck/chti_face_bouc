import 'package:chti_face_bouc/pages/common/simple_future_builder.dart';
import 'package:chti_face_bouc/pages/page_accueil.dart';
import 'package:chti_face_bouc/pages/page_ecrire_post.dart';
import 'package:chti_face_bouc/pages/page_members.dart';
import 'package:chti_face_bouc/pages/page_profil.dart';
import 'package:chti_face_bouc/services/service_authentification.dart';
import 'package:chti_face_bouc/services/service_firestore.dart';
import 'package:flutter/material.dart';

class PageNavigation extends StatefulWidget {
  const PageNavigation({super.key});

  @override
  State<PageNavigation> createState() => _PageNavigationState();
}

class _PageNavigationState extends State<PageNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bodies = [
      PageAccueil(),
      PageMembers(),
      PageEcrirePost(),
      Text("ds"),
      SimpleFutureBuilder(
        future: ServiceFirestore.me(),
        child: (me) => PageProfil(memberId: me.id),
      ),
    ];

    return Scaffold(
      body: bodies[_selectedIndex],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Cht'i face bouc"),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await ServiceAuthentification.signOut();
            },
            child: Text("Sign out"),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Membres'),
          BottomNavigationBarItem(
            icon: Icon(Icons.border_color),
            label: 'Ecrire',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
