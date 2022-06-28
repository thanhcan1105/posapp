import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pos_app/config/palette.dart';

class PosActionRow extends StatefulWidget {
  const PosActionRow({
    Key? key,
  }) : super(key: key);

  @override
  _PosActionRowState createState() => _PosActionRowState();
}

class _PosActionRowState extends State<PosActionRow> {
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return !isSearch
        ? Row(
            children: [
              Icon(
                Icons.search,
                size: 30,
                color: Palette.iconActionColor,
              ),
              Spacer(),
              Icon(
                FontAwesome.barcode,
                size: 30,
                color: Palette.iconActionColor,
              ),
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.view_agenda_outlined,
                size: 30,
                color: Palette.iconActionColor,
              )
            ],
          )
        : Row(children: [
            Icon(
              Icons.search,
              size: 30,
              color: Palette.iconActionColor,
            ),
          ]);
  }
}
