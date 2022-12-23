import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../lego/lego.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Stream<Lego?> _legoStream;

  @override
  void initState() {
    super.initState();
    _legoStream = FirebaseFirestore.instance
        .collection('lego')
        .doc('dev')
        .snapshots()
        .asyncMap((snapshot) {
      final data = snapshot.data();
      if (data == null) return null;
      return Lego.fromJson(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Lego?>(
      stream: _legoStream,
      builder: (BuildContext context, AsyncSnapshot<Lego?> snapshot) {
        if (snapshot.hasError) {
          return const CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return snapshot.data?.widget() ??
            const Center(
              child: CircularProgressIndicator(),
            );
      },
    );
  }
}
