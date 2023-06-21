import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class EventB {
  String obj;
  EventB(this.obj);
}
class EventA {
  String str;
  EventA(this.str);

}
