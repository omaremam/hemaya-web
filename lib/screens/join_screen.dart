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
  void dispose() {
    super.dispose();
    incomingSDPOffer = null;
  }

  @override
  void initState() {
    super.initState();

    print("Incoming sdp offer");
    print(incomingSDPOffer);

    document.documentElement?.requestFullscreen();
    // listen for incoming video call
    SignallingService.instance.socket!.on("newCall", (data) {
      print(data);
      if (mounted) {
        // set SDP Offer of incoming call
        setState(() {
          incomingSDPOffer = data;
        });
      }
    });
  }

  // join Call
  _joinCall({
    required String callerId,
    required String name,
    required double latitude,
    required double longitude,
    dynamic offer,
  }) {
    print("look here ${callerId} ${offer} ${latitude} ${longitude}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CallScreen(
          callerId: callerId,
          calleeId: "1234",
          offer: offer,
          lat: latitude,
          long: longitude,
          name: name,
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
        title: const Text("Hemaya Server"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            if (incomingSDPOffer != null)
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Incoming Call",
                    ),
                    IconButton(
                      icon: const Icon(Icons.call_end),
                      color: Colors.redAccent,
                      onPressed: () {
                        setState(() => incomingSDPOffer = null);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.call),
                      color: Colors.greenAccent,
                      onPressed: () {
                        _joinCall(
                            callerId: incomingSDPOffer["callerId"]!,
                            offer: incomingSDPOffer["sdpOffer"],
                            name: incomingSDPOffer["name"],
                            latitude: incomingSDPOffer["lat"],
                            longitude: incomingSDPOffer["long"]);
                      },
                    )
                  ],
                ),
              ),
            if (incomingSDPOffer == null)
              Center(child: Text("No incoming calls"))
          ],
        ),
      ),
    );
  }
}
