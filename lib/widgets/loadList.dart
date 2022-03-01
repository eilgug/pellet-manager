import 'package:flutter/material.dart';

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
          ? Center(child: Text('LISTA VUOTA'))
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
                    subtitle: Text(userLoads[index].date.toString()),
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
