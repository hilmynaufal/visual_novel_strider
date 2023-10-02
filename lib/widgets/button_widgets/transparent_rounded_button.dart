import 'package:flutter/material.dart';

class TransparentRoundedButton extends StatelessWidget {
  const TransparentRoundedButton(
      {Key? key,
      required this.headerTitle,
      required this.description,
      required this.icon,
      this.onTap})
      : super(key: key);

  final String headerTitle, description;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            padding: const EdgeInsets.all(16),
            backgroundColor: theme.primaryColorLight,
            elevation: 0,
            splashFactory: NoSplash.splashFactory,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: Colors.grey[800]!, width: 1))),
        child: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            Icon(
              icon,
              size: 28,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headerTitle,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
