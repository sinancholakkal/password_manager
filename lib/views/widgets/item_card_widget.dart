import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/models/password_model.dart';
import 'package:password_manager/state/firestore_bloc/firestore_bloc_dart_bloc.dart';
import 'package:password_manager/state/local_auth_bloc/local_auth_bloc.dart';
import 'package:password_manager/utils/app_color.dart';
import 'package:password_manager/utils/app_string.dart';
import 'package:password_manager/views/widgets/show_diolog.dart';
import 'package:password_manager/views/widgets/text_feild.dart';
import 'package:password_manager/views/widgets/toast.dart' show flutterToast;

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({
    super.key,
    required this.model,
  });

  final PasswordModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgcard,
      child: SizedBox(
        height: 90,
        child: Center(
          child: ListTile(
            onTap: () {
              context.read<LocalAuthBloc>().add(
                LocalAuthenticationEvent(
                  model: model,
                ),
              );
            },
            leading: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: Icon(Icons.lock),
            ),
            //Item name-------
            title: TextWidget(
              textAlign: TextAlign.start,
              text: model.name,
              fontWeight: FontWeight.bold,
              size: 14,
            ),
            //Url-----------
            subtitle: (model.url != "")
                ? TextWidget(
                    text: model.url!,
                    size: 16,
                    textAlign: TextAlign.start,
                  )
                : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(
                        text: model.password,
                      ),
                    );
                    flutterToast(
                      msg:
                          "Password was copied to the clipboard",
                    );
                  },
                  icon: Icon(
                    Icons.copy,
                    color: Color(0xFF1E6F9F),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDiolog(
                      context: context,
                      title: "Delete",
                      content: AppStrings.delete,
                      confirmTap: () {
                        context.pop();
                        context
                          .read<
                            FirestoreBlocDartBloc
                          >()
                          .add(
                            DeleteEvent(
                              id: model.id!,
                            ),
                          );
                      },
                          cancelTap: () => context.pop(),
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Color(0xFF1E6F9F),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
