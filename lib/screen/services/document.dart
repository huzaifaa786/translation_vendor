import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:translation_vendor/static/page_p_day.dart';
import 'package:translation_vendor/values/colors.dart';

class DocumentRate extends StatefulWidget {
  const DocumentRate({super.key, this.page});
  final String? page;
  @override
  _DocumentRateState createState() => _DocumentRateState();
}

class _DocumentRateState extends State<DocumentRate> {
  final TextEditingController dayController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    
        PagePrice(
          number: widget.page,
          days: '',
        ),
      
      ],
    );
  }
}
