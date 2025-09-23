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
import 'package:password_manager/views/widgets/item_card_widget.dart';
import 'package:password_manager/views/widgets/load_data_widget.dart';
import 'package:password_manager/views/widgets/search_filed_widget.dart';
import 'package:password_manager/views/widgets/show_diolog.dart';
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
    return MultiBlocListener(
      listeners: [
        BlocListener<LocalAuthBloc, LocalAuthState>(
          listener: (context, state) {
            if (state is AuthSuccessState) {
              context.push("/viewItem", extra: state.model);
            } 
            
            else {
              flutterToast(msg: "Authentication field!");
            }
          },
        ),
        BlocListener<FirestoreBlocDartBloc, FirestoreBlocDartState>(
          listener: (context, state) {
            if(state is DataDeletedState){
              flutterToast(msg: "Password deleted");
              if(context.canPop()){
                context.pop();
              }
              context.read<FirestoreBlocDartBloc>().add(FetchDatasEvent());
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is LogoutSuccessState){
              flutterToast(msg: AppStrings.logoutS);
              context.go("/login");
            }
          },
        ),
      ],
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
                    return Expanded(
                      child: LoadDataWidget());
                  } else if (state is EmptyState) {
                    return Expanded(
                      child: Center(child: TextWidget(text: "No data")));
                  } else if (state is LoadedState) {
                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //search field---------
                          SearchFiledWidget(
                            ontap: () => context.push("/search",extra: state.models),
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
                              TextWidget(
                                text: "Passwords(${state.models.length})",
                                size: 16,
                              ),
                            ],
                          ),

                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                final model = state.models[index];
                                //ItemCardWidgets
                                return ItemCardWidget(model: model);
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
            showDiolog(context:context, title: AppStrings.logout, content:  AppStrings.logoutContent,cancelTap: () => context.pop(),confirmTap: () {
              context.pop();
              context.read<AuthBloc>().add(SignOutEvent());
              
            },);
            
          },
          child: Icon(Icons.logout),
        ),
      ),
    );
  }
}

