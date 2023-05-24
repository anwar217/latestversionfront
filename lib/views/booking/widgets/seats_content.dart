import 'package:flutter/material.dart';

class SeatsContent extends StatefulWidget {
  const SeatsContent({
    super.key,
  });

  @override
  State<SeatsContent> createState() => _SeatsContentState();
}

class _SeatsContentState extends State<SeatsContent> {
  List<int> unavailableSeats = [0, 11, 18, 22, 29, 34, 35, 37, 12, 40, 41];
  List<int> selectedSeats = [];
  Color setSeatColor(int index) {
    if (unavailableSeats.contains(index)) return Colors.grey;
    if (selectedSeats.contains(index)) return Colors.yellow;

    return Colors.white;
  }

  void toggleSeat(int index) {
    if (unavailableSeats.contains(index)) return;

    setState(() {
      if (selectedSeats.contains(index)) {
        selectedSeats.remove(index);
      } else {
        selectedSeats.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ((MediaQuery.of(context).size.width - 50.0) / 2) - 30.0,
      height: 125.0,
      margin: const EdgeInsets.only(bottom: 30.0),
      child: Center(
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 24,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                toggleSeat(index + 24);
              },
              child: Icon(
                Icons.event_seat,
                color: setSeatColor(index + 24),
              ),
            );
          },
        ),
      ),
    );
  }
}
