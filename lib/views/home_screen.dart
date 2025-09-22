import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/models/password_model.dart';
import 'package:password_manager/state/auth_bloc/auth_bloc.dart'
    hide AuthSuccessState;
import 'package:password_manager/state/firestore_bloc/firestore_bloc_dart_bloc.dart';
import 'package:password_manager/state/local_auth_bloc/local_auth_bloc.dart';
import 'package:password_manager/utils/app_color.dart';
import 'package:password_manager/utils/app_sizedbox.dart';
import 'package:password_manager/utils/app_sizes.dart';
import 'package:password_manager/utils/app_string.dart';
import 'package:password_manager/views/add_edit_item_screen.dart';
import 'package:password_manager/views/widgets/add_button.dart';
import 'package:password_manager/views/widgets/load_data_widget.dart';
import 'package:password_manager/views/widgets/search_filed_widget.dart';
import 'package:password_manager/views/widgets/text_feild.dart';
import 'package:password_manager/views/widgets/toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<FirestoreBlocDartBloc>().add(FetchDatasEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocalAuthBloc, LocalAuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          context.push(
            "/viewItem",
            extra: PasswordModel(name: "Instagram", password: "123@dffggg"),
          );
        } else {
          flutterToast(msg: "Authentication field!");
        }
      },
      child: Scaffold(
        backgroundColor: bgcolor,
        body: Padding(
          padding: screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizedBox.h120,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Const text vault------------
                  TextWidget(
                    text: AppStrings.vault,
                    fontWeight: FontWeight.bold,
                    size: 44,
                  ),
                  //AddButton---------------
                  AddButton(
                    onTap: () => context.push(
                      "/addedit",
                      extra: {'type': ItemAddEdit.add, 'model': null},
                    ),
                  ),
                ],
              ),
              //Data display bloc------------------
              BlocBuilder<FirestoreBlocDartBloc, FirestoreBlocDartState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return LoadDataWidget();
                  } else if (state is EmptyState) {
                    return Center(child: TextWidget(text: "No data"));
                  } else if (state is LoadedState) {
                    
                    return Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //search field---------
                          SearchFiledWidget(
                            readOnly: true,
                            hintText: "Search vault",
                            borderColor: Color(0xFF0D0D0D),
                          ),
                          AppSizedBox.h20,

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 5,
                            children: [
                              Icon(Icons.lock, color: kGrey),
                              TextWidget(text: "Passwords(${state.models.length+1})", size: 16),
                            ],
                          ),

                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                final model = state.models[index];
                                return Card(
                                  color: bgcard,
                                  child: SizedBox(
                                    height: 90,
                                    child: Center(
                                      child: ListTile(
                                        onTap: () {
                                          context.read<LocalAuthBloc>().add(
                                            LocalAuthenticationEvent(),
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
                                        subtitle: (model.url!=null)? TextWidget(
                                                text: model.url!,
                                                size: 14,
                                                textAlign: TextAlign.start,
                                              )
                                            : null,
                                        trailing: IconButton(
                                          onPressed: () {
                                            Clipboard.setData(
                                              ClipboardData(text: model.password),
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
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: state.models.length,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Text("Something wrong!");
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<AuthBloc>().add(SignOutEvent());
          },
          child: Icon(Icons.logout),
        ),
      ),
    );
  }
}
