import 'package:flutter/material.dart';

import '../widgets/newLoad.dart';
import '../widgets/newOrder.dart';

void startAddNewLoads(BuildContext ctx, int stock, Function addNewLoads) {
  showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (bCtx) {
        return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewLoad(stock: stock, addLoad: addNewLoads));
      });
}

void startAddNewOrder(BuildContext ctx, int stock, Function addNewOrder) {
  showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (bCtx) {
        return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewOrder(stock: stock, addOrder: addNewOrder));
      });
}

void orderBy(int by, List list) {
  list.sort((a, b) => a.date.compareTo(b.date));
}

void orderByDate(List list) {
  list.sort((a, b) => a.date.compareTo(b.date));
}
