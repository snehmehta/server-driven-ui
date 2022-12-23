import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'lego.dart';

class LegoView extends StatefulWidget {
  const LegoView(
      {super.key, required this.firestorePath, this.showAppBar = true});

  final String firestorePath;
  final bool? showAppBar;

  @override
  State<LegoView> createState() => _LegoViewState();
}

class _LegoViewState extends State<LegoView> {
  late Stream<Lego?> _legoStream;

  @override
  void initState() {
    _legoStream = FirebaseFirestore.instance
        .doc(widget.firestorePath)
        .snapshots()
        .asyncMap((snapshot) {
      final data = snapshot.data();
      if (data == null) return null;
      return Lego.fromJson(data);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar ?? true ? AppBar() : null,
      body: StreamBuilder<Lego?>(
        stream: _legoStream,
        builder: (BuildContext context, AsyncSnapshot<Lego?> snapshot) {
          if (snapshot.hasError) {
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }

          return CustomScrollView(
            slivers: [
              snapshot.data?.widget() ??
                  const Center(
                    child: Text('Something Went Wrong'),
                  )
            ],
          );
        },
      ),
    );
  }
}
