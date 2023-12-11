import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit()
      : super(
          CounterState(
            counter: 0,
          ),
        );

  void increment() {
    var value = state.counter + 1;
    print(value);
    emit(
      CounterState(
        counter: value,
      ),
    );
  }

  void decrement() {
    var value = state.counter - 1;
    emit(
      CounterState(
        counter: value,
      ),
    );
  }
}
