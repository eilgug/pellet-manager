import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewLoad extends StatefulWidget {
  final int stock;
  final Function addLoad;

  const NewLoad({Key? key, required this.stock, required this.addLoad})
      : super(key: key);

  @override
  _NewLoadState createState() => _NewLoadState();
}

class _NewLoadState extends State<NewLoad> {
  final _bagsAmountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    if (_bagsAmountController.text.isEmpty) {
      return;
    }

    final enteredBagsAmount = int.parse(_bagsAmountController.text);

    if (enteredBagsAmount > widget.stock) {
      return;
    }

    widget.addLoad(enteredBagsAmount, _selectedDate);
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
                  const Text(
                    "Nuovo carico",
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
                label: Text("Numero di sacchi inseriti"),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                      'Data carico: ${DateFormat('dd/MM/yyy').format(_selectedDate)}'),
                ),
                TextButton(
                    child: const Text('Cambia data'),
                    onPressed: _presentDatePicker),
              ],
            ),
            const SizedBox(
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
