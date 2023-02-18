import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:perex/model/transaction.dart';

class TransactionWidget extends StatelessWidget {
  final Transaction tx;
  final Function(String) onDelete;
  const TransactionWidget({super.key, required this.tx, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      contentPadding: const EdgeInsets.all(5),
      leading: Container(
        width: 90,
        height: double.infinity,
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            '${tx.amount.toStringAsFixed(3)} đ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
        ),
      ),
      title: Text(
        tx.title,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text('${DateFormat('dd/MM/yyyy').format(tx.date)}\n${tx.id}',
          style: const TextStyle(color: Colors.grey)),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => onDelete(tx.id),
        color: Theme.of(context).errorColor,
      ),
    ));

    // Card(
    //     child: Container(
    //         padding: const EdgeInsets.all(10),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Container(
    //               width: 90,
    //               margin: const EdgeInsets.only(right: 15),
    //               padding: const EdgeInsets.all(10),
    //               decoration: BoxDecoration(
    //                   border: Border.all(
    //                     color: Theme.of(context).primaryColor,
    //                     width: 2,
    //                   ),
    //                   borderRadius:
    //                       const BorderRadius.all(Radius.circular(10))),
    //               child: FittedBox(
    //                 fit: BoxFit.contain,
    //                 child: Text(
    //                   '${tx.amount.toStringAsFixed(3)} đ',
    //                   style: TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                       color: Theme.of(context).primaryColor),
    //                 ),
    //               ),
    //             ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(tx.id),
    //                 Text(
    //                   tx.title,
    //                   style: Theme.of(context).textTheme.headline6,
    //                 ),
    //                 Text(DateFormat('dd/MM/yyyy').format(tx.date),
    //                     style: const TextStyle(color: Colors.grey)),
    //               ],
    //             ),
    //           ],
    //        )));
  }
}
