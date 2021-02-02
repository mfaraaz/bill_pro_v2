import 'dart:io';
import 'dart:math';
import 'package:bill_pro_v2/models/user_data.dart';
import 'package:bill_pro_v2/widget/item_list_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:printing/printing.dart';

import '../constants.dart';
import '../models/customer.dart';
import '../models/customer_data.dart';
import '../models/item_list_data.dart';
import '../models/items_list.dart';
import '../models/others.dart';
import '../models/others_data.dart';
import '../screens/preview_pdf.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class BillScreen extends StatelessWidget {
  final pdf = pw.Document();
  String company = ' ',
      address = ' ',
      email = ' ',
      gst = ' ',
      pan = ' ',
      ifsc = ' ',
      bank = ' ',
      accountNumber = '';
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<UserData>(context).current;
    company = data.company;
    address = data.address;
    pan = data.pan;
    gst = data.gst;
    email = data.email;
    bank = data.bank;
    ifsc = data.ifsc;
    accountNumber = data.accountNumber;
    final itemListProvide = Provider.of<ItemListData>(context);
    List<ItemsList> itemList = itemListProvide.items;

    int length = itemList.length;
    double total = itemListProvide.getTotal();
    double tax = total * 0.05;
    double grossTotal = total + tax;

    Others currentData = Provider.of<OthersData>(context).current;
    Customer currentCustomer =
        Provider.of<CustomerData>(context).items[int.parse(currentData.index)];

    writeOnPdf() {
      pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.symmetric(horizontal: 32, vertical: 60),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Table(children: [
              pw.TableRow(children: [
                pw.Paragraph(
                  margin: pw.EdgeInsets.zero,
                  text: company.toUpperCase(),
                  style: pw.TextStyle(
                      fontSize: 37, fontWeight: pw.FontWeight.bold),
                ),
              ]),
              pw.TableRow(children: [
                pw.Paragraph(margin: pw.EdgeInsets.zero, text: address),
              ]),
              pw.TableRow(children: [
                pw.Paragraph(
                    margin: pw.EdgeInsets.zero, text: 'e mail. $email'),
              ]),
              pw.TableRow(children: [
                pw.Paragraph(margin: pw.EdgeInsets.zero, text: 'GSTIN: $gst'),
              ])
            ]),
            pw.Row(children: [
              pw.Expanded(flex: 7, child: pw.Divider(height: 1)),
              pw.Paragraph(
                  padding: pw.EdgeInsets.only(top: 5),
                  text: '    we believe in perfection.    ',
                  style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                      fontStyle: pw.FontStyle.italic)),
              pw.Expanded(flex: 2, child: pw.Divider(height: 1)),
            ]),
            pw.Table(
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.top,
                border: pw.TableBorder(),
                children: [
                  pw.TableRow(children: [
                    pw.Expanded(
                      flex: 5,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: 'Customer',
                              style:
                                  pw.TextStyle(fontStyle: pw.FontStyle.italic),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '${currentCustomer.name}',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '${currentCustomer.address}',
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '${currentCustomer.city}',
                              margin: pw.EdgeInsets.zero),
                        ],
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: 'Date',
                              style:
                                  pw.TextStyle(fontStyle: pw.FontStyle.italic),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '${currentData.date}',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Divider(height: 1),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: 'Bill Number',
                              style:
                                  pw.TextStyle(fontStyle: pw.FontStyle.italic),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '${currentData.billNo}',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                        ],
                      ),
                    ),
                  ]),
                ]),
            pw.Table(
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.top,
                border: pw.TableBorder(),
                children: [
                  pw.TableRow(children: [
                    pw.Expanded(
                      flex: 5,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: 'Customer PAN',
                              style:
                                  pw.TextStyle(fontStyle: pw.FontStyle.italic),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '${currentCustomer.pan}',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                        ],
                      ),
                    ),
                    pw.Expanded(
                      flex: 5,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: 'Customer GSTIN',
                              style:
                                  pw.TextStyle(fontStyle: pw.FontStyle.italic),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '${currentCustomer.gst}',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                        ],
                      ),
                    ),
                    pw.Expanded(
                      flex: 4,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: 'Order Date',
                              style:
                                  pw.TextStyle(fontStyle: pw.FontStyle.italic),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                        ],
                      ),
                    ),
                  ]),
                ]),
            pw.SizedBox(height: 10),
            pw.Table(
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.top,
                border: pw.TableBorder(),
                children: [
                  pw.TableRow(children: [
                    pw.Expanded(
                      flex: 2,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: 'Qty',
                              style:
                                  pw.TextStyle(fontStyle: pw.FontStyle.italic),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 1
                                  ? '${itemList[0].qty.toStringAsFixed(2)}'
                                  : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 2
                                  ? '${itemList[1].qty.toStringAsFixed(2)}'
                                  : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 3
                                  ? '${itemList[2].qty.toStringAsFixed(2)}'
                                  : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 4
                                  ? '${itemList[3].qty.toStringAsFixed(2)}'
                                  : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 5
                                  ? '${itemList[4].qty.toStringAsFixed(2)}'
                                  : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                        ],
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: 'HSN/SAC',
                              style:
                                  pw.TextStyle(fontStyle: pw.FontStyle.italic),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 1 ? '${itemList[0].hsn}' : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 2 ? '${itemList[1].hsn}' : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 3 ? '${itemList[2].hsn}' : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 4 ? '${itemList[3].hsn}' : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 5 ? '${itemList[4].hsn}' : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                        ],
                      ),
                    ),
                    pw.Expanded(
                      flex: 7,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: 'Description of Good',
                              style:
                                  pw.TextStyle(fontStyle: pw.FontStyle.italic),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 1 ? '${itemList[0].name}' : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text:
                                  (length >= 1 && itemList[0].note.length != 0)
                                      ? '${itemList[0].note}'
                                      : '_',
                              style: pw.TextStyle(
                                  fontStyle: pw.FontStyle.italic,
                                  color: (length >= 1 &&
                                          itemList[0].note == 'sample')
                                      ? PdfColor(1, 1, 1, 1)
                                      : PdfColor(0, 0, 0)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 2 ? '${itemList[1].name}' : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: (length >= 2 &&
                                      itemList[1].note.length != null)
                                  ? '${itemList[1].note}'
                                  : '_',
                              style: pw.TextStyle(
                                  fontStyle: pw.FontStyle.italic,
                                  color: (length >= 2 &&
                                          itemList[1].note == 'sample')
                                      ? PdfColor(1, 1, 1, 1)
                                      : PdfColor(0, 0, 0)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 3 ? '${itemList[2].name}' : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text:
                                  (length >= 3 && itemList[2].note.length != 0)
                                      ? '${itemList[2].note}'
                                      : '_',
                              style: pw.TextStyle(
                                  fontStyle: pw.FontStyle.italic,
                                  color: (length >= 3 &&
                                          itemList[2].note == 'sample')
                                      ? PdfColor(1, 1, 1, 1)
                                      : PdfColor(0, 0, 0)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 4 ? '${itemList[3].name}' : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text:
                                  (length >= 4 && itemList[3].note.length != 0)
                                      ? '${itemList[3].note}'
                                      : '_',
                              style: pw.TextStyle(
                                  fontStyle: pw.FontStyle.italic,
                                  color: (length >= 4 &&
                                          itemList[3].note == 'sample')
                                      ? PdfColor(1, 1, 1, 1)
                                      : PdfColor(0, 0, 0)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 5 ? '${itemList[4].name}' : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                        ],
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: 'Rate',
                              style:
                                  pw.TextStyle(fontStyle: pw.FontStyle.italic),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 1
                                  ? '${itemList[0].price.toInt()}'
                                  : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 2
                                  ? '${itemList[1].price.toInt()}'
                                  : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 3
                                  ? '${itemList[2].price.toInt()}'
                                  : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 4
                                  ? '${itemList[3].price.toInt()}'
                                  : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 5
                                  ? '${itemList[4].price.toInt()}'
                                  : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                        ],
                      ),
                    ),
                    pw.Expanded(
                      flex: 1,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: 'Per',
                              style:
                                  pw.TextStyle(fontStyle: pw.FontStyle.italic),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '44',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 1 ? '${itemList[0].unit}' : '44',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: length >= 1
                                      ? PdfColor(0, 0, 0)
                                      : PdfColor(1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '44',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 2 ? '${itemList[1].unit}' : '44',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: length >= 2
                                      ? PdfColor(0, 0, 0)
                                      : PdfColor(1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '44',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 3 ? '${itemList[2].unit}' : '44',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: length >= 3
                                      ? PdfColor(0, 0, 0)
                                      : PdfColor(1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '44',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 4 ? '${itemList[3].unit}' : '44',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: length >= 4
                                      ? PdfColor(0, 0, 0)
                                      : PdfColor(1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '44',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: length >= 5 ? '${itemList[4].unit}' : '44',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: length >= 5
                                      ? PdfColor(0, 0, 0)
                                      : PdfColor(1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                        ],
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(right: 5),
                              text: 'Total',
                              style:
                                  pw.TextStyle(fontStyle: pw.FontStyle.italic),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(right: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(right: 5),
                              text: length >= 1
                                  ? '${itemList[0].total.toStringAsFixed(2)}'
                                  : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(right: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(right: 5),
                              text: length >= 2
                                  ? '${itemList[1].total.toStringAsFixed(2)}'
                                  : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(right: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(right: 5),
                              text: length >= 3
                                  ? '${itemList[2].total.toStringAsFixed(2)}'
                                  : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(right: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(right: 5),
                              text: length >= 4
                                  ? '${itemList[3].total.toStringAsFixed(2)}'
                                  : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(right: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor(1, 1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(right: 5),
                              text: length >= 5
                                  ? '${itemList[4].total.toStringAsFixed(2)}'
                                  : ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.SizedBox(height: (5 - length) * 20.toDouble()),
                        ],
                      ),
                    ),
                  ]),
                ]),
            pw.Table(
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.top,
                border: pw.TableBorder(),
                children: [
                  pw.TableRow(children: [
                    pw.Expanded(
                      flex: 2,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: ' ',
                              style:
                                  pw.TextStyle(fontStyle: pw.FontStyle.italic),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                        ],
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: ' ',
                              style:
                                  pw.TextStyle(fontStyle: pw.FontStyle.italic),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: ' ',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                        ],
                      ),
                    ),
                    pw.Expanded(
                      flex: 7,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(right: 5),
                              text: 'Integrated Goods & Service Tax',
                              style: pw.TextStyle(
                                  fontStyle: pw.FontStyle.italic,
                                  fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(right: 5),
                              text: 'Total',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                        ],
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '5%',
                              style:
                                  pw.TextStyle(fontStyle: pw.FontStyle.italic),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                        ],
                      ),
                    ),
                    pw.Expanded(
                      flex: 1,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: '_',
                              style: pw.TextStyle(
                                  fontStyle: pw.FontStyle.italic,
                                  color: PdfColor(1, 1, 1)),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(left: 5),
                              text: 'INR',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                        ],
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(right: 5),
                              text: length == 0 ? 0 : tax.toStringAsFixed(2),
                              style:
                                  pw.TextStyle(fontStyle: pw.FontStyle.italic),
                              margin: pw.EdgeInsets.zero),
                          pw.Paragraph(
                              padding: pw.EdgeInsets.only(right: 5),
                              text: length == 0
                                  ? 0
                                  : grossTotal.toStringAsFixed(2),
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              margin: pw.EdgeInsets.zero),
                        ],
                      ),
                    ),
                  ]),
                ]),
            pw.Table(
              defaultVerticalAlignment: pw.TableCellVerticalAlignment.top,
              border: pw.TableBorder(),
              children: [
                pw.TableRow(children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Paragraph(
                            padding: pw.EdgeInsets.only(left: 5),
                            text: 'Amount in words',
                            style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
                            margin: pw.EdgeInsets.zero),
                        pw.Paragraph(
                            padding: pw.EdgeInsets.only(left: 5),
                            text:
                                'INR ${NumberToWord().convert('en-in', grossTotal.floor()).toUpperCase()} Only',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            margin: pw.EdgeInsets.zero),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
            pw.Table(
              defaultVerticalAlignment: pw.TableCellVerticalAlignment.top,
              border: pw.TableBorder(),
              children: [
                pw.TableRow(children: [
                  pw.Expanded(
                    flex: 11,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Paragraph(
                            padding: pw.EdgeInsets.only(left: 5),
                            text: 'Taxable Amount',
                            style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
                            margin: pw.EdgeInsets.zero),
                        pw.Paragraph(
                            padding: pw.EdgeInsets.only(left: 5),
                            text: '$total',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            margin: pw.EdgeInsets.zero),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Paragraph(
                            padding: pw.EdgeInsets.only(left: 5),
                            text: 'Rate',
                            style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
                            margin: pw.EdgeInsets.zero),
                        pw.Paragraph(
                            padding: pw.EdgeInsets.only(left: 5),
                            text: '5%',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            margin: pw.EdgeInsets.zero),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Paragraph(
                            padding: pw.EdgeInsets.only(left: 5),
                            text: 'Amount ',
                            style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
                            margin: pw.EdgeInsets.zero),
                        pw.Paragraph(
                            padding: pw.EdgeInsets.only(left: 5),
                            text: '${tax.toStringAsFixed(2)}',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            margin: pw.EdgeInsets.zero),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
            pw.Table(
              defaultVerticalAlignment: pw.TableCellVerticalAlignment.top,
              border: pw.TableBorder(),
              children: [
                pw.TableRow(children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Paragraph(
                            padding: pw.EdgeInsets.only(left: 5),
                            text: 'Tax Amount in words',
                            style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
                            margin: pw.EdgeInsets.zero),
                        pw.Paragraph(
                            padding: pw.EdgeInsets.only(left: 5),
                            text:
                                'INR ${NumberToWord().convert('en-in', tax.floor()).toUpperCase()} Only',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            margin: pw.EdgeInsets.zero),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
            pw.SizedBox(height: 2),
            pw.Table(children: [
              pw.TableRow(children: [
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text('GOODS FOR EVERYBODY',
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    ]),
              ])
            ]),
            pw.SizedBox(height: 2),
            pw.Table(
              defaultVerticalAlignment: pw.TableCellVerticalAlignment.top,
              border: pw.TableBorder(),
              children: [
                pw.TableRow(children: [
                  pw.Expanded(
                    flex: 11,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Paragraph(
                            padding: pw.EdgeInsets.only(left: 5),
                            text: 'Payment Details',
                            style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
                            margin: pw.EdgeInsets.zero),
                        pw.Paragraph(
                            padding: pw.EdgeInsets.only(left: 5),
                            text: 'Cash   A/C Payee Cheque(Y)   NEFT/RTGS ',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            margin: pw.EdgeInsets.zero),
                        pw.Divider(height: 1),
                        pw.Paragraph(
                            padding: pw.EdgeInsets.only(left: 5),
                            text: 'Bank Details',
                            style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
                            margin: pw.EdgeInsets.zero),
                        pw.Paragraph(
                            padding: pw.EdgeInsets.only(left: 5),
                            text: bank != null ? bank : 'Sample Bank',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            margin: pw.EdgeInsets.zero),
                        pw.Divider(height: 1),
                        pw.Table(border: pw.TableBorder(), children: [
                          pw.TableRow(children: [
                            pw.Expanded(
                              flex: 5,
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Paragraph(
                                      padding: pw.EdgeInsets.only(left: 5),
                                      text: 'Account Number',
                                      style: pw.TextStyle(
                                          fontStyle: pw.FontStyle.italic),
                                      margin: pw.EdgeInsets.zero),
                                  pw.Paragraph(
                                      padding: pw.EdgeInsets.only(left: 5),
                                      text: accountNumber != null
                                          ? accountNumber
                                          : 'Sample Account',
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold),
                                      margin: pw.EdgeInsets.zero),
                                ],
                              ),
                            ),
                            pw.Expanded(
                              flex: 5,
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Paragraph(
                                      padding: pw.EdgeInsets.only(left: 5),
                                      text: 'IFSC Code',
                                      style: pw.TextStyle(
                                          fontStyle: pw.FontStyle.italic),
                                      margin: pw.EdgeInsets.zero),
                                  pw.Paragraph(
                                      padding: pw.EdgeInsets.only(left: 5),
                                      text: ifsc != null ? ifsc : 'IFSC',
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold),
                                      margin: pw.EdgeInsets.zero),
                                ],
                              ),
                            ),
                          ])
                        ])
                      ],
                    ),
                  ),
                  pw.Expanded(
                    flex: 5,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Paragraph(
                            padding: pw.EdgeInsets.only(top: 60),
                            text: 'FOR ${company.toUpperCase()}',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            margin: pw.EdgeInsets.zero),
                        pw.Paragraph(
                            padding: pw.EdgeInsets.only(left: 5),
                            text: '',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            margin: pw.EdgeInsets.zero),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Divider(thickness: 2),
            pw.Paragraph(
                margin: pw.EdgeInsets.zero,
                text: 'Note',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Paragraph(
                margin: pw.EdgeInsets.zero,
                text:
                    '# All disputes to be subjected to Varanasi Jurisdiction.'),
            pw.Paragraph(
                margin: pw.EdgeInsets.zero,
                text: '# Goods once sold will not be taken back.'),
            pw.Paragraph(
                margin: pw.EdgeInsets.zero,
                text: '# Errors & Omissions Expected.'),
          ];
        },
      ));
    }

    Future savePdf() async {
      Directory documentDirectory = await getApplicationDocumentsDirectory();

      String documentPath = documentDirectory.path;

      File file = File("$documentPath/billNo${currentData.billNo}.pdf");

      file.writeAsBytesSync(pdf.save());
    }

    Future sharePdf() async {
      Directory documentDirectory = await getApplicationDocumentsDirectory();

      String documentPath = documentDirectory.path;

      File file = File("$documentPath/billNo${currentData.billNo}.pdf");

      await Printing.sharePdf(
          bytes: pdf.save(), filename: "billNo${currentData.billNo}.pdf");
    }

    // double total = _total * 1.05, tax = _total * .05;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          shadowColor: Color(0xff),
          title: Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'FINAL BILL',
              style: GoogleFonts.getFont('Montserrat',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.black,
            padding: EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: FlatButton(
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Preview PDF',
                          style: GoogleFonts.getFont('Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        onPressed: () async {
                          print(currentCustomer.name);
                          print(itemList.length);
                          writeOnPdf();
                          await savePdf();

                          Directory documentDirectory =
                              await getApplicationDocumentsDirectory();

                          String documentPath = documentDirectory.path;

                          String fullPath =
                              "$documentPath/billNo${currentData.billNo}.pdf";
                          print(fullPath);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PreviewPDF(
                                        path: fullPath,
                                      )));
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Icon(Icons.print, color: Colors.black),
                        onPressed: () async {
                          await Printing.layoutPdf(
                              onLayout: (PdfPageFormat format) async =>
                                  pdf.save());
                          // await sharePdf();
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Icon(
                          Icons.save,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          final uid = FirebaseAuth.instance.currentUser.uid;
                          FirebaseFirestore.instance
                              .collection('users/$uid/bills')
                              .doc('${currentData.billNo}${currentData.date}')
                              .set({
                            'date': currentData.date,
                            'billNo': currentData.billNo,
                            'name': currentCustomer.name,
                            'gst': currentCustomer.gst,
                            'pan': currentCustomer.pan,
                            'city': currentCustomer.city,
                            'address': currentCustomer.address,
                            'total': grossTotal,
                            'noItem': itemList.length,
                          });
                          for (int i = 0; i < itemList.length; i++) {
                            FirebaseFirestore.instance
                                .collection(
                                    'users/$uid/bills/${currentData.billNo}${currentData.date}/items')
                                .doc('$i')
                                .set({
                              'name': itemList[i].name,
                              'unit': itemList[i].unit,
                              'hsn': itemList[i].hsn,
                              'qty': itemList[i].qty,
                              'price': itemList[i].price,
                              'total': itemList[i].total,
                              'note': itemList[i].note
                            });
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    'YOUR DETAILS',
                    style: GoogleFonts.getFont('Montserrat',
                        color: kFontColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: kContainerColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            company,
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontSize: 18,
                              color: kFontColor,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'GSTIN',
                                style: GoogleFonts.getFont(
                                  'Montserrat',
                                  fontSize: 12,
                                  color: kFontColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                gst,
                                style: GoogleFonts.getFont(
                                  'Montserrat',
                                  fontSize: 12,
                                  color: kFontColor,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.white38,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              address,
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontSize: 12,
                                color: kFontColor,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            pan,
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontSize: 12,
                              color: kFontColor,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: kContainerColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Bill Number',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontSize: 12,
                                    color: kFontColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  'Date',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontSize: 12,
                                    color: kFontColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 25,
                                  width: 150,
                                  child: Text(
                                    currentData.billNo,
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontSize: 14,
                                      color: kFontColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Text(
                                  currentData.date,
                                  style: GoogleFonts.getFont('Montserrat',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          'CUSTOMER',
                          style: GoogleFonts.getFont('Montserrat',
                              color: kFontColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: kContainerColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  currentCustomer.name,
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontSize: 18,
                                    color: kFontColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'GSTIN',
                                      style: GoogleFonts.getFont(
                                        'Montserrat',
                                        fontSize: 12,
                                        color: kFontColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    Text(
                                      currentCustomer.gst,
                                      style: GoogleFonts.getFont(
                                        'Montserrat',
                                        fontSize: 12,
                                        color: kFontColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.white38,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    currentCustomer.address,
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontSize: 12,
                                      color: kFontColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Text(
                                  currentCustomer.pan,
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontSize: 12,
                                    color: kFontColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          'ITEMS',
                          style: GoogleFonts.getFont('Montserrat',
                              color: kFontColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: kContainerColor,
                          ),
                          child: ItemListBuilder()),
                      SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          'TOTAL',
                          style: GoogleFonts.getFont('Montserrat',
                              color: kFontColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                          padding: EdgeInsets.all(18),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: kContainerColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Gross Total',
                                    style: GoogleFonts.getFont('Montserrat',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: kFontColor),
                                  ),
                                  Text(
                                    total.toStringAsFixed(1),
                                    style: GoogleFonts.getFont('Montserrat',
                                        fontSize: 12, color: kFontColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'GST (5%) ',
                                    style: GoogleFonts.getFont('Montserrat',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: kFontColor),
                                  ),
                                  Text(
                                    tax.toStringAsFixed(1),
                                    style: GoogleFonts.getFont('Montserrat',
                                        fontSize: 12, color: kFontColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Grand Total',
                                    style: GoogleFonts.getFont('Montserrat',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: kFontColor),
                                  ),
                                  Text(
                                    grossTotal.toStringAsFixed(2),
                                    style: GoogleFonts.getFont('Montserrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: kFontColor),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }
}
