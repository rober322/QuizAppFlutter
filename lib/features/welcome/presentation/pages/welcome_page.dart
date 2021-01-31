import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../../../core/widgets/fondo_svg.dart';
import '../../../../features/welcome/presentation/bloc/welcome_bloc.dart';
import '../../../../features/welcome/presentation/widgets/message_display.dart';
import '../../../../features/welcome/presentation/widgets/loading_widget.dart';
import '../../../../features/welcome/presentation/widgets/welcome_controls.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Stack(children: [
        FondoSvg(),
        buildBody(context),
      ]),
    );
  }

  BlocProvider<WelcomeBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WelcomeBloc>(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              Text("Juguemos Quiz,",
                  style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              Text("Ingrese su información a continuación"),
              BlocBuilder<WelcomeBloc, WelcomeState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state is Empty || state == null) {
                    return SizedBox(height: 40);
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Success) {
                    WidgetsBinding.instance.addPostFrameCallback((_){
                        Navigator.of(context).pushNamed('quiz', arguments: state.fullName);
                    });
                    return MessageDisplay(
                      message: '',
                    );
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }
                },
              ),
              WelcomeControls()
            ],
          ),
        ),
      ),
    );
  }
}
