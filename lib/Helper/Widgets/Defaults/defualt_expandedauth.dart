import 'package:flutter/cupertino.dart';

class DefaultExpandedAuth extends StatelessWidget {
  final Widget child;

  const DefaultExpandedAuth({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(flex: 1,),
        Expanded(
          flex: 12,
            child: child
        ),
        const Spacer(flex: 1,),
      ],
    );
  }
}
