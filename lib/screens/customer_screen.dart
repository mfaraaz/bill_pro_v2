import '../screens/add_customer.dart';
import '../widget/customer_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Customers',
                style: GoogleFonts.getFont('Montserrat',
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
            ),
            Expanded(
              child: Container(
                child: CustomerBuilder(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.black87,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCustomer(),
            ),
          );
        },
      ),
      // FloatingActionButton.extended(
      //   label: Text(
      //     'Add Customer',
      //     style: TextStyle(
      //         fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
      //   ),
      //   backgroundColor: Colors.lightBlueAccent,
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => AddCustomer(),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
