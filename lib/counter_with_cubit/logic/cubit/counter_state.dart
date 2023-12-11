// ignore_for_file: must_be_immutable

part of 'counter_cubit.dart';

@immutable
class CounterState {
  int counter;
  CounterState({
    required this.counter,
  });
}
