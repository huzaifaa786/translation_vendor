class SaleModal {
  DateTime? date;
  int? price;
  String? currency;

  SaleModal(sale) {
    date = DateTime.parse(sale['date']);
    price = sale['amount'];
    currency = sale['currency'];
  }
}
