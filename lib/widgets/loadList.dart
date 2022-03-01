import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/loads.dart';

class LoadsList extends StatelessWidget {
  final List<Loads> userLoads;
  final Function deleteLoad;
  final double average;

  const LoadsList(
      {Key? key,
      required this.userLoads,
      required this.deleteLoad,
      required this.average})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: userLoads.isEmpty
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Icon(
                    Icons.fireplace_outlined,
                    size: 70,
                    color: Colors.amber.shade600,
                  ),
                ),
                Text(
                  'Aggiungi un carico per cominciare',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ))
          : ListView.builder(
              itemCount: userLoads.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.fireplace_outlined,
                          color: Theme.of(context).cardColor,
                        )),
                    title: Row(
                      children: [
                        Text('Sacchi: ${userLoads[index].bags.toString()}'),
                        userLoads[index].bags < average
                            ? Icon(
                                Icons.arrow_drop_down,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.arrow_drop_up,
                                color: Colors.red.shade900,
                              )
                      ],
                    ),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy').format(userLoads[index].date),
                      style: TextStyle(fontSize: 12),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_outline,
                          color: Theme.of(context).errorColor),
                      onPressed: () => deleteLoad(userLoads[index].id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
