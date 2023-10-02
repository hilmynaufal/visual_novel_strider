import 'package:flutter/material.dart';

abstract class AbstractSimpleMonochromePage extends StatelessWidget {
  const AbstractSimpleMonochromePage(
      {Key? key,
      required this.subTitle,
      required this.title,
      this.scrollController})
      : super(key: key);

  final String title, subTitle;
  final ScrollController? scrollController;

  Widget buildWidget(BuildContext context, {required List<Widget> body}) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        toolbarHeight: 80,
        backgroundColor: theme.primaryColorLight,
      ),
      backgroundColor: theme.primaryColorLight,
      body: SingleChildScrollView(
        controller: scrollController,
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 32),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                subTitle,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              const SizedBox(
                height: 16,
              ),
              ...body
            ],
          ),
        ),
      ),
    );
  }
}
