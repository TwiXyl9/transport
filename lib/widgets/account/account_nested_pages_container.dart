import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/account_bloc.dart';

class AccountNestedPagesContainer extends StatelessWidget {
  Widget child;
  AccountNestedPagesContainer({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void goBack() async {
      context.read<AccountBloc>().add(RedirectToMainPageAccountEvent());
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: IconButton(
                  onPressed: goBack,
                  icon: const Icon(Icons.arrow_back)
              ),
            ),
          ],
        ),
        Expanded(child: child)
      ],
    );
  }
}
