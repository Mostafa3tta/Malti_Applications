import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/modules/basic_app/counter/cubit/states.dart';


class CounterCubit extends Cubit<CounterStates>
{

  CounterCubit(CounterStates initialState) : super(initialState);

static CounterCubit get(context)=>BlocProvider.of(context);
int counter=1;
void minus(){
  counter--;
  emit(CounterMinusStates());
}
void plus(){
  counter++;
  emit(CounterPlusStates());
}
}