import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:hemayaweb/screens/join_screen.dart';
import 'package:hemayaweb/widgets/after_call_card.dart';
import '../services/signalling.service.dart';
import 'package:url_launcher/url_launcher.dart';

class CallScreen extends StatefulWidget {
  final String callerId, calleeId;
  final double lat, long;
  final String name;
  final dynamic offer;
  const CallScreen({
    super.key,
    this.offer,
    required this.callerId,
    required this.calleeId,
    required this.lat,
    required this.long,
    required this.name,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  // socket instance
  final socket = SignallingService.instance.socket;

  // videoRenderer for localPeer

  // videoRenderer for remotePeer
  final _remoteRTCVideoRenderer = RTCVideoRenderer();

  // mediaStream for localPeer
  MediaStream? _localStream;

  // RTC peer connection
  RTCPeerConnection? _rtcPeerConnection;

  // list of rtcCandidates to be sent over signalling
  List<RTCIceCandidate> rtcIceCadidates = [];

  bool isCardVisible = false;

  @override
  void initState() {
    // initializing renderers
    print("${widget.offer} THIS IS THE OFFER");

    _remoteRTCVideoRenderer.initialize();

    // setup Peer Connection
    _setupPeerConnection();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> _openMaps() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${widget.lat},${widget.long}';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not open maps.';
    }
  }

  _setupPeerConnection() async {
    // create peer connection
    _rtcPeerConnection = await createPeerConnection({
      'iceServers': [
        {
          'urls': [
            'stun:stun1.l.google.com:19302',
            'stun:stun2.l.google.com:19302'
          ]
        }
      ]
    });
    print("sajkdnkjasdnkjasdnkjadsnjkadsnkjn");
    print(_rtcPeerConnection);

    // listen for remotePeer mediaTrack event
    _rtcPeerConnection!.onTrack = (event) {
      print(event);
      _remoteRTCVideoRenderer.srcObject = event.streams[0];
      setState(() {});
    };

    // for Incoming call
    if (widget.offer != null) {
      // listen for Remote IceCandidate
      socket!.on("IceCandidate", (data) {
        String candidate = data["iceCandidate"]["candidate"];
        String sdpMid = data["iceCandidate"]["id"];
        int sdpMLineIndex = data["iceCandidate"]["label"];

        // add iceCandidate
        _rtcPeerConnection!.addCandidate(RTCIceCandidate(
          candidate,
          sdpMid,
          sdpMLineIndex,
        ));
      });

      // set SDP offer as remoteDescription for peerConnection
      print(widget.offer);
      await _rtcPeerConnection!.setRemoteDescription(
        RTCSessionDescription(widget.offer["sdp"], widget.offer["type"]),
      );

      // create SDP answer
      RTCSessionDescription answer = await _rtcPeerConnection!.createAnswer();

      print(answer);

      // set SDP answer as localDescription for peerConnection
      _rtcPeerConnection!.setLocalDescription(answer);

      // send SDP answer to remote peer over signalling
      socket!.emit("answerCall", {
        "callerId": widget.callerId,
        "userId": widget.calleeId,
        "sdpAnswer": answer.toMap(),
      });
    }
    // for Outgoing Call
    else {
      // listen for local iceCandidate and add it to the list of IceCandidate
      _rtcPeerConnection!.onIceCandidate =
          (RTCIceCandidate candidate) => rtcIceCadidates.add(candidate);

      // when call is accepted by remote peer
      socket!.on("callAnswered", (data) async {
        // set SDP answer as remoteDescription for peerConnection
        await _rtcPeerConnection!.setRemoteDescription(
          RTCSessionDescription(
            data["sdpAnswer"]["sdp"],
            data["sdpAnswer"]["type"],
          ),
        );

        // send iceCandidate generated to remote peer over signalling
        for (RTCIceCandidate candidate in rtcIceCadidates) {
          socket!.emit("IceCandidate", {
            "calleeId": widget.calleeId,
            "iceCandidate": {
              "id": candidate.sdpMid,
              "label": candidate.sdpMLineIndex,
              "candidate": candidate.candidate
            }
          });
        }
      });

      // create SDP Offer
      RTCSessionDescription offer = await _rtcPeerConnection!.createOffer();

      // set SDP offer as localDescription for peerConnection
      await _rtcPeerConnection!.setLocalDescription(offer);

      // make a call to remote peer over signalling
      socket!.emit('makeCall', {
        "calleeId": widget.calleeId,
        "sdpOffer": offer.toMap(),
      });
    }
  }

  _leaveCall() {
    Navigator.pop(context);

    // Set the state to show the new card component
    Future.delayed(Duration.zero, () {
      setState(() {
        isCardVisible =
            true; // Assuming isCardVisible is a boolean variable in your state
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Hemaya Stream Viewer"),
      ),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.9,
              child: RTCVideoView(
                _remoteRTCVideoRenderer,
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Text("Name"), Text("${widget.name}")],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Text("Latitude"), Text("${widget.lat}")],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Text("Longitude"), Text("${widget.long}")],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _openMaps();
                      },
                      child: Text("View Location")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => JoinScreen(
                              selfCallerId: "1234",
                              isCardVisible: true,
                            ),
                          ),
                        );
                      },
                      child: Text("End call")),
                ],
              ),
            ),
            if (isCardVisible)
              AfterCallWidget(
                // customize as needed
                onButton1Pressed: () {
                  // handle button 1 press
                },
                onButton2Pressed: () {
                  // handle button 2 press
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _remoteRTCVideoRenderer.dispose();
    _localStream?.dispose();
    _rtcPeerConnection?.dispose();
    super.dispose();
  }
}
