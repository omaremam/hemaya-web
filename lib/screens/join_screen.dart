import 'dart:html';

import 'package:flutter/material.dart';
import 'call_screen.dart';
import '../services/signalling.service.dart';

class JoinScreen extends StatefulWidget {
  final String selfCallerId;

  const JoinScreen({super.key, required this.selfCallerId});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  dynamic incomingSDPOffer;
  final remoteCallerIdTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    document.documentElement?.requestFullscreen();
    // listen for incoming video call
    SignallingService.instance.socket!.on("newCall", (data) {
      if (mounted) {
        // set SDP Offer of incoming call
        setState(() {
          incomingSDPOffer = data;
          if (incomingSDPOffer != null) {
            _joinCall(
              callerId: incomingSDPOffer["callerId"]!,
              offer: incomingSDPOffer["sdpOffer"],
            );
          }
        });
      }
    });
  }

  // join Call
  _joinCall({
    required String callerId,
    dynamic offer,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CallScreen(
          callerId: callerId,
          calleeId: "1234",
          offer: offer,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Hemaya Stream Viewer"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            if (incomingSDPOffer == null)
              Center(
                child: Text("No incoming streams"),
              )
          ],
        ),
      ),
    );
  }
}
