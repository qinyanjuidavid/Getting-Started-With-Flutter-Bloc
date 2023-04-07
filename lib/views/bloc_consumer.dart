import 'dart:ffi';

import 'package:bloc_intro/logic/cubits/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocConsumerPage extends StatefulWidget {
  final String title;
  final Color color;
  const MyBlocConsumerPage(
      {super.key, required this.title, required this.color});

  @override
  State<MyBlocConsumerPage> createState() => _MyBlocConsumerPageState();
}

class _MyBlocConsumerPageState extends State<MyBlocConsumerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(
          widget.title,
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<CounterCubit, CounterState>(
          builder: (context, state) {
            final counterValue = context.select(
              (CounterCubit cubit) => cubit.state.counterValue,
            );
            return Center(
              child: Column(
                children: [
                  Text(
                    counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          BlocProvider.of<CounterCubit>(context).decrement();
                        },
                        tooltip: "Decrement",
                        child: const Icon(Icons.remove),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          BlocProvider.of<CounterCubit>(context).increment();
                        },
                        tooltip: "Increment",
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
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
        ),
      ),
    );
  }
}
