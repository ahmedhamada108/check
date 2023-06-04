import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/blocs/switch_bloc.bloc/switch_event.dart';
import 'package:untitled1/blocs/switch_bloc.bloc/switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent,SwitchState> {
  SwitchBloc(): super (const SwitchInitial(switchValue:  false )){
    on<SwitchOnEvent>((event,emit)
    {
      emit(
        const SwitchState(switchValue: true),
      );
    }
    );
    on<SwitchOffEvent>((event,emit)
    {
      emit(
          const SwitchState(switchValue:  false),
      );
    }
    );
  }
}