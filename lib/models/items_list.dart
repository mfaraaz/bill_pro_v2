class ItemsList {
  ItemsList(
      {this.name,
      this.unit,
      this.hsn,
      this.qty,
      this.price,
      this.total,
      this.note = ' '});
  String name;
  String hsn;
  String unit;
  String note;
  double price;
  double qty;
  double total;
}
