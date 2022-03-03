import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewOrder extends StatefulWidget {
  final int stock;
  final Function addOrder;

  const NewOrder({Key? key, required this.stock, required this.addOrder})
      : super(key: key);

  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  final _bagsAmountController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    if (_bagsAmountController.text.isEmpty || _amountController.text.isEmpty) {
      return;
    }

    final enteredBagsAmount = int.parse(_bagsAmountController.text);
    final enteredAmount = int.parse(_amountController.text);

    widget.addOrder(enteredBagsAmount, _selectedDate, enteredAmount);
    Navigator.of(context).pop();
  }

  void _closeModal() {
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                    width: 60,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Nuovo ordine",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: _bagsAmountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                label: Text("Numero sacchi ordinati"),
              ),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                label: Text("Spesa totale"),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                      'Data ordine: ${DateFormat('dd/MM/yyy').format(_selectedDate)}'),
                ),
                TextButton(
                    child: const Text('Cambia data'),
                    onPressed: _presentDatePicker),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _closeModal,
                  child: const Text('CHIUDI'),
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: _submitData,
                  child: const Text('SALVA'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
