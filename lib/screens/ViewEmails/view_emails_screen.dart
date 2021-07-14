import 'package:admin/models/email.dart';
import 'package:admin/screens/ViewEmails/cubit/email_cubit.dart';
import 'package:admin/screens/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewEmailsScreen extends StatelessWidget {
  const ViewEmailsScreen() : super();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailCubit()..loadEmail(),
      child: SafeArea(child: Body()),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailCubit, List<Email>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return Center(
            child: Text('No hay correos disponibles'),
          );
        }
        return Column(children: [
          Header(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.email_rounded),
                      title: Text(state[index].correo),
                    ),
                    Divider(
                      height: 5,
                    )
                  ],
                ),
              ),
            ),
          )
        ]);
      },
    );
  }
}
