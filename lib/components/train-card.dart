import 'package:flutter/material.dart';
import 'package:mytrain/models/train.dart';

class TrainCard extends StatefulWidget {
  const TrainCard({super.key, required this.train});

  final Train train;

  @override
  State<TrainCard> createState() => _TrainCardState();
}

class _TrainCardState extends State<TrainCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle card tap here
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Train Number: ${widget.train.id}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Departure: ${widget.train.departure}', style: TextStyle(fontSize: 14)),
                SizedBox(height: 4),
                Text('Arrival: ${widget.train.arrival}', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}