import 'package:bloc_intro/configs/routes.dart';
import 'package:bloc_intro/logic/cubits/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Secondscreen extends StatefulWidget {
  final String title;
  final Color color;
  const Secondscreen({super.key, required this.title, required this.color});

  @override
  State<Secondscreen> createState() => _SecondscreenState();
}

class _SecondscreenState extends State<Secondscreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: args?['color'] ?? widget.color,
        title: Text(args?['title'] ?? widget.title),
      ),
      body: BlocListener<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.wasIncremented == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Incremented"),
                duration: Duration(
                  seconds: 4,
                ),
              ),
            );
          } else if (state.wasDecremented == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Decreamented"),
                duration: Duration(
                  seconds: 4,
                ),
              ),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("You have pushed the button this many times."),
              BlocListener<CounterCubit, CounterState>(
                listener: (context, state) {},
                child: Builder(
                  builder: (context) {
                    final counterValue = context.select(
                        (CounterCubit cubit) => cubit.state.counterValue);
                    return Text(
                      counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: 'fab1',
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                    },
                    tooltip: "Decrement",
                    child: const Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    heroTag: 'fab2',
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
                    },
                    tooltip: "Increment",
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              MaterialButton(
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    RouteGenerator.secondScreen,
                    arguments: {
                      'title': 'Second Screen',
                      'color': Colors.green,
                    },
                  );
                },
                child: const Text(
                  "Go to second Screen",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              MaterialButton(
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RouteGenerator.homeScreen);
                },
                child: const Text(
                  "Back Home",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
