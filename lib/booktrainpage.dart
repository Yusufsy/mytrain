import 'package:flutter/material.dart';
import 'package:mytrain/components/train-card.dart';
import 'package:mytrain/helpers/db-helper.dart';
import 'package:mytrain/models/train.dart';

class BookTrain extends StatefulWidget {
  const BookTrain({super.key});

  @override
  State<BookTrain> createState() => _BookTrainState();
}

class _BookTrainState extends State<BookTrain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                // use FutureBuilder to fetch trains from dbhelper.getalltrains
                FutureBuilder<List<Train>>(
                  future: DBHelper().getAllTrains(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No trains available');
                    } else {
                      final trains = snapshot.data!;
                      return Column(
                        children: trains.map((train) => TrainCard(train: train)).toList(),
                      );
                    }
                  },
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}