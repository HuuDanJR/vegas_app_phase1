import 'package:flutter/material.dart';

Widget historyBooking() {
  return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return itemHistory();
      });
}

Widget itemHistory() {
  return Column(
    children: [
      SizedBox(
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 60,
              child: Icon(
                Icons.watch_later,
                color: Colors.grey,
              ),
            ),
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '171 Đồng khởi',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Text(
                    '171 Đồng Khởi, phường Bến Nghé, Q.1, Hồ Chí...',
                    style: TextStyle(color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                ],
              ),
            ),
            Container(
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      const Divider()
    ],
  );
}
