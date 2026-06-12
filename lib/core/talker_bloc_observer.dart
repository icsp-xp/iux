import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';

class TalkerBlocObserver extends BlocObserver {
  final Talker _talker;

  TalkerBlocObserver(this._talker);

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _talker.info('Created: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _talker.info('Event: ${bloc.runtimeType} → $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _talker.debug(
      'Transition: ${bloc.runtimeType}\n'
      'Event: ${transition.event}\n'
      'Current: ${transition.currentState}\n'
      'Next: ${transition.nextState}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _talker.error('Error in ${bloc.runtimeType}: $error', error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _talker.info('Closed: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _talker.verbose(
      'Change: ${bloc.runtimeType}\n'
      'Current: ${change.currentState}\n'
      'Next: ${change.nextState}',
    );
  }
}
