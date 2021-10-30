import 'package:flutter/material.dart';
import 'package:cardholderapp/logic/bloc/authentification/authentification_events.dart';
import 'package:cardholderapp/logic/bloc/authentification/authentification_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cardholderapp/logic/bloc/authentification/authentification_bloc.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            child: BlocBuilder<AuthentificationBloc, AuthentificationState>(
              builder: (context, state) {
                if (state is AuthentificationLoadingState) {
                  return CircularProgressIndicator();
                } else if (state is Authentification_LogedIn_Via_Google) {
                  return Text(state.loggedUser.email);
                } else
                  return Text("Пока ничего не произошло");
              },
            ),
          ),
          SizedBox(height: 40,),
          ElevatedButton(onPressed: () => context.read<AuthentificationBloc>().add(Authentification_SignIn_Via_Google()), child: Text("Вход")),
          ElevatedButton(onPressed: () => context.read<AuthentificationBloc>().add(Authentification_LogOut_Via_Google()), child: Text("Выход"))

        ],
      ),
    );
  }
}