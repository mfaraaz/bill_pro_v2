class Customer {
  Customer({
    this.index = '',
    this.name = '',
    this.address = '',
    this.city = '',
    this.pan = '',
    this.gst = '',
  });

  String index;
  String name;
  String address;
  String city;
  String pan;
  String gst;

  Customer.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        address = json['address'],
        gst = json['gst'],
        pan = json['pan'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'gst': gst,
        'pan': pan,
      };
}
