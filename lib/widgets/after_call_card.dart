import 'package:flutter/material.dart';
import 'package:hemayaweb/screens/join_screen.dart';
import 'package:http/http.dart' as http;

typedef VoidCallback = void Function();

class AfterCallWidget extends StatelessWidget {
  final VoidCallback? switchToggle;
  AfterCallWidget({required this.switchToggle});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors
          .transparent, // Set to transparent to allow the gradient to show through
      child: Container(
        height: 150,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            colors: [Color(0xFF009F98), Color(0xFF1281AE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: Center(
                  child: Text(
                    'حدد نوع البلاغ',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white, // Set to your desired text color
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        // determineCallType(true).then((value) =>
                        //     {switchToggle!(), Navigator.pop(context)});
                        determineCallType(true).then((value) => {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => JoinScreen(
                                    selfCallerId: "1234",
                                    isCardVisible: false,
                                  ),
                                ),
                              )
                            });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .white, // Set to your desired background color
                      ),
                      child: Text(
                        'مغلق',
                        style: TextStyle(
                          color: Color(
                              0xFF1281AE), // Set to your desired text color
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        // determineCallType(false).then((value) =>
                        //     {switchToggle!(), Navigator.pop(context)});
                        determineCallType(false).then((value) => {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => JoinScreen(
                                    selfCallerId: "1234",
                                    isCardVisible: false,
                                  ),
                                ),
                              )
                            });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .white, // Set to your desired background color
                      ),
                      child: Text(
                        'معلق',
                        style: TextStyle(
                          color: Color(
                              0xFF1281AE), // Set to your desired text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> determineCallType(bool type) async {
  // Determine the endpoint based on the type
  String endpoint = type ? "closed" : "open";

  final url = Uri.parse("http://13.36.63.83:5956/session/$endpoint");
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // Request was successful
      print('Request successful');
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (error) {
    // Handle other errors, e.g., network issues
    print('Error: $error');
  }
}
