import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EditActionPane extends StatelessWidget {
  const EditActionPane(
      {Key? key,
      required this.child,
      required this.onEdit,
      required this.onDelete,
      this.extentRatio = 0.5,
      required})
      : super(key: key);

  final Widget child;
  final Function onEdit;
  final Function onDelete;
  final double extentRatio;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: key,
      endActionPane: ActionPane(
        extentRatio: extentRatio,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
              onPressed: (context) {
                onEdit();
              },
              backgroundColor: Theme.of(context).toggleableActiveColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit'),
          SlidableAction(
            onPressed: (context) {
              onDelete();
            },
            backgroundColor: const Color(0xfffe604d),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: child,
    );
  }
}
