import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/welcome/presentation/bloc/welcome_bloc.dart';
import '../../../../constants.dart';

class WelcomeControls extends StatefulWidget {
  const WelcomeControls({
    Key key,
  }) : super(key: key);

  @override
  _WelcomeControlsState createState() => _WelcomeControlsState();
}

class _WelcomeControlsState extends State<WelcomeControls> {
  final fullNameTF = TextEditingController();
  String fullNameStr = '';

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      TextField(
        controller: fullNameTF,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFF1C2341),
          hintText: "Nombre Completo",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        onChanged: (value) {
          fullNameStr = value;
        },
        onSubmitted: (_) {
          dispatchQuiz();
        },
      ),
      SizedBox(height: 40),
      RaisedButton(
        child: Text("Empecemos"),
        color: Theme.of(context).accentColor,
        textTheme: ButtonTextTheme.primary,
        onPressed: dispatchQuiz,
      ),
      SizedBox(height: 40),
      InkWell(
          onTap: dispatchQuiz,
          child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                gradient: kPrimaryGradient,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Text(
                "Empecemos2",
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.black),
              )))
    ]));
  }

  void dispatchQuiz() {
    fullNameTF.clear();
    BlocProvider.of<WelcomeBloc>(context).add(GoToQuiz(fullNameStr));
    fullNameStr = '';
  }
}
