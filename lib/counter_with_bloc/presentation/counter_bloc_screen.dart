import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formation_lh_23/counter_with_bloc/logic/bloc/counter_bloc.dart';

class CounterBlocScreen extends StatelessWidget {
  const CounterBlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Counter With Bloc"),
      ),
      body: Center(
        child: BlocConsumer<CounterBloc, CounterState2>(
          listener: (context, state) {
            if (state.counter == 10) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Bravo le counter est a 10"),
                ),
              );
            }
          },
          builder: (context, counterState) {
            return Text(
              counterState.counter.toString(),
              style: const TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: "bloc_increment",
            onPressed: () {
              context.read<CounterBloc>().add(IncrementCounterEvent());
            },
            label: const Text("Increment"),
            icon: const Icon(Icons.add),
          ),
          const SizedBox(height: 20),
          FloatingActionButton.extended(
            heroTag: "bloc_decrement",
            onPressed: () {
              context.read<CounterBloc>().add(DecrementCounterEvent());
            },
            label: const Text("Decrement"),
            icon: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
