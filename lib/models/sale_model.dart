class SaleModal {
  DateTime? date;
  int? price;

  SaleModal(sale) {
    date = DateTime.parse(sale['date']);
    price = sale['amount'];
  }
}
