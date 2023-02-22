import 'package:flutter/material.dart';
import 'package:handover/data/model/parcel_model.dart';
import '../../../shared/app_constants/app_colors.dart';

class ParcelItem extends StatefulWidget {
  final ParcelModel item;

  const ParcelItem({super.key, required this.item});

  @override
  State<ParcelItem> createState() => _ParcelItemState();
}

class _ParcelItemState extends State<ParcelItem> with TickerProviderStateMixin {
  late ParcelModel item;

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      margin: const EdgeInsets.only(top: 6, bottom: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "id item name: ${item.id!} ",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
          Text(
            item.fileName!,
            maxLines: 2,
            style: const TextStyle(
                color: AppColors.textColor, fontWeight: FontWeight.w600),
          ),
          Text(
            'In transit',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 3,
          ),
        ],
      ),
    );
  }
}
