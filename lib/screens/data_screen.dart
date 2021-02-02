import 'package:bill_pro_v2/models/customer_data.dart';
import 'package:bill_pro_v2/screens/add_customer.dart';
import 'package:bill_pro_v2/screens/product_screen.dart';
import 'package:bill_pro_v2/widget/custom_button.dart';
import 'package:bill_pro_v2/widget/customer_builder.dart';
import 'package:bill_pro_v2/widget/product_builder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'add_product.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  bool toggle = false;

  Color col = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        toggle = false;
                        print(toggle);
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: toggle ? Colors.black87 : Colors.blueAccent,
                      ),
                      width: double.infinity,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people,
                            color: toggle ? Colors.blueAccent : Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Customer',
                            style: GoogleFonts.getFont('Montserrat',
                                fontWeight: FontWeight.w700,
                                color:
                                    toggle ? Colors.blueAccent : Colors.black,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        toggle = true;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: !toggle ? Colors.black87 : Colors.blueAccent,
                      ),
                      width: double.infinity,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            color: !toggle ? Colors.blueAccent : Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Product',
                            style: GoogleFonts.getFont('Montserrat',
                                fontWeight: FontWeight.w700,
                                color:
                                    !toggle ? Colors.blueAccent : Colors.black,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            toggle
                ? Expanded(
                    child: Container(
                      child: ProductBuilder(),
                    ),
                  )
                : Expanded(
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
          color: Colors.black,
        ),
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => toggle ? AddProduct() : AddCustomer(),
            ),
          );
        },
      ),
    );
  }
}
