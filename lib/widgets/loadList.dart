import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/loads.dart';

class LoadsList extends StatelessWidget {
  final List<Loads> userLoads;
  final Function deleteLoad;

  const LoadsList({Key? key, required this.userLoads, required this.deleteLoad})
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
                    title: Text(userLoads[index].bags.toString()),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy').format(userLoads[index].date),
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
