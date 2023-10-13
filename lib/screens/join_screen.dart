
import 'package:flutter/material.dart';
import 'package:hemayaweb/widgets/after_call_card.dart';
import 'call_screen.dart';
import '../services/signalling.service.dart';

class JoinScreen extends StatefulWidget {
  final String selfCallerId;

  final bool isCardVisible;

  const JoinScreen(
      {super.key, required this.selfCallerId, required this.isCardVisible});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  dynamic incomingSDPOffer;
  bool toggle = false;
  final emailController = TextEditingController();
  onToggleSwitch() {}
  @override
  void initState() {
    super.initState();
    toggle = widget.isCardVisible;
    print("Incoming sdp offer");
    print(incomingSDPOffer);

    // document.documentElement?.requestFullscreen();
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

  _callUsers() async{
    print("callscreen");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => CallScreen(
          callerId: "1234",
          calleeId: emailController.text,
          offer: null,
          lat: 0.0,
          long: 0.0,
          name: emailController.text,
          calling: true,
        ),
      ),
    );
  }

  _joinCall({
    required String callerId,
    required String name,
    required double latitude,
    required double longitude,
    dynamic offer,
  }) {
    print("look here ${callerId} ${offer} ${latitude} ${longitude}");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => CallScreen(
          callerId: callerId,
          calleeId: "1234",
          offer: offer,
          lat: latitude,
          long: longitude,
          name: name,
          calling: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          width: 100,
          height: 40,
          // decoration: const BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [Color(0xFF009F98), Color(0xFF1281AE)],
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //   ),
          // ),
        ),
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
                    const Text("Incoming Call"),
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
                          longitude: incomingSDPOffer["long"],
                        );
                      },
                    ),
                  ],
                ),
              ),
            if (incomingSDPOffer == null)
              Center(
                child: Text("No incoming calls"),
              ),
            if (toggle)
              Center(
                child: AfterCallWidget(switchToggle: onToggleSwitch),
              ),
            if (incomingSDPOffer == null)
              Positioned(
                bottom: 5,
                right: 5,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 400.0,
                    maxHeight: 100.0,
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "Enter email",
                              // Add styling as needed
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        ElevatedButton(
                          onPressed:() async{
                            await _callUsers();
                          },
                          child: Text("Call"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color(0xFF009F98), // Background color
                            foregroundColor: Colors.white, // Text color
                          ),
                          // Add styling as needed
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
