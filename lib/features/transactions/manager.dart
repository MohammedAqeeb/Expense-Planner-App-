import 'package:rxdart/subjects.dart';

class TransactionSortedManager {
  final BehaviorSubject<DateTime> _dateController =
      BehaviorSubject<DateTime>.seeded(DateTime.now());

  void setAddedBefore(DateTime value) {
    _dateController.sink.add(value);
  }

  DateTime getAddedBefore() {
    return _dateController.value;
  }

  Stream<DateTime> get addedBefore$ => _dateController.stream;

  void dispose() {
    _dateController.close();
  }
}
