import '../models/event.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../utils/simple_logger.dart';

class EventRepository {
  final ApiService apiService;
  final LocalStorageService localStorageService;

  EventRepository(this.apiService, this.localStorageService);

  Future<Event> createEvent(Event event) async {
    try {
      final data = await apiService.post('events/create', event.toJson());
      return Event.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to create event: ${e.toString()}');
      return event;
    }
  }

  Future<Event> getEvent(String id) async {
    final data = await apiService.get('events/$id');
    return Event.fromJson(data);
  }

  Future<List<Event>> getAllEvents({int limit = 10, int offset = 0}) async {
    try {
      final data = await apiService.get('events?limit=$limit&offset=$offset');
      return (data as List).map((item) => Event.fromJson(item)).toList();
    } catch (e) {
      SimpleLogger.severe('Failed to get all events: ${e.toString()}');
      return [];
    }
  }

  Future<Event> updateEvent(String id, Event event) async {
    try {
      final data = await apiService.put('events/$id', event.toJson());
      return Event.fromJson(data);
    } catch (e) {
      SimpleLogger.severe('Failed to update event: ${e.toString()}');
      event.status = 'pending_update';
      return event;
    }
  }

  Future<void> deleteEvent(String id) async {
    await apiService.delete('events/$id');
  }

  Future<List<Event>> getEventsByUser(String userId) async {
    final data = await apiService.get('events/user/$userId');
    return (data as List).map((item) => Event.fromJson(item)).toList();
  }

  Future<List<String>> getEventsIdsFromServer() async {
    final data = await apiService.get('events/ids');
    return (data as List).map((item) => item.toString()).toList();
  }
}
