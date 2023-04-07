import 'package:bloc_intro/configs/routes.dart';
import 'package:bloc_intro/logic/cubits/counter_cubit.dart';
import 'package:bloc_intro/views/bloc_consumer.dart';
import 'package:bloc_intro/views/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
       return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Home"),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}