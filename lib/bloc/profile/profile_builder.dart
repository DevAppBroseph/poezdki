import 'package:app_poezdka/bloc/profile/profile_bloc.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/src/profile/personal_data.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';

class PersonalDataBuilder extends StatelessWidget {
  const PersonalDataBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context)
      ..add(LoadProfile());
    return BlocBuilder(
        bloc: profileBloc,
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const KScaffoldScreen(
              title: "Личные данные",
              isLeading: true,
              body:  Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is ProfileError) {
            return const KScaffoldScreen(
              title: "Личные данные",
              isLeading: true,
              body:   Center(
                child: Text("Ooops! Возникла ошибка.\nУже исправляем =)"),
              ),
            );
          }
          if (state is ProfileLoaded) {
            return PersonalData(
              user: state.user,
            );
          }
          return const KScaffoldScreen(
              title: "Личные данные",
              isLeading: true,
              body:  Center(
                child: CircularProgressIndicator(),
              ),
            );
        });
  }
}
