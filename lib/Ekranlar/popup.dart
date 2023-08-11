import 'package:flutter/material.dart';

void showContextMenu(BuildContext context) async {
  final RenderObject? overlay = Overlay.of(context).context.findRenderObject();

  await showMenu(
      context: context,

      // Show the context menu at the tap location
      position: RelativeRect.fromRect(
          const Rect.fromLTWH(30, 30, 30, 30),
          Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
              overlay.paintBounds.size.height)),

      // set a list of choices for the context menu
      items: [
        PopupMenuItem(
          value: 'Duzenle',
          child: const Text('Düzenle'),
          onTap: () {},
        ),
        PopupMenuItem(
          value: 'Sil',
          child: const Text('Sil'),
          onTap: () {},
        ),
      ]);
}
