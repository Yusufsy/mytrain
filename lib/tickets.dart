import 'package:flutter/material.dart';
import 'package:mytrain/components/titletext.dart';

class Tickets extends StatefulWidget {
  const Tickets({super.key});

  @override
  State<Tickets> createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 16),
            child: TitleText(text: 'My Tickets'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              // separatorBuilder: (context, index) => Divider(thickness: 5,),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Kaduna -> Abuja ${index + 1}'),
                  subtitle: Text('12/10/2026 8Pm'),
                  onTap: () {
                    // Handle ticket tap
                  }
                );
              },
            ),
          ),
          // Expanded(
          //   child: GridView.builder(
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       mainAxisSpacing: 4.0,
          //       crossAxisSpacing: 4.0,
          //       // childAspectRatio: 2.0,
          //     ),
          //     itemCount: 15,
          //     itemBuilder: (context, index) {
          //       return Card(
          //         child: Center(
          //           child: Image.asset(
          //             'assets/images/train-app-logo.png',
          //             width: 300,
          //             height: 300,
          //           ),
          //         ),
          //       );
          //     },
          //     // shrinkWrap: true,
          //     physics: ClampingScrollPhysics(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
