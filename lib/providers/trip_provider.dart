import 'package:flutter/material.dart';
import '../models/trip_model.dart';
import '../services/trip_calculation_service.dart';

class TripProvider extends ChangeNotifier {
  TripModel? _currentTrip;
  bool _isLoading = false;
  String? _error;
  List<String> _recentSearches = [];

  TripModel? get currentTrip => _currentTrip;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<String> get recentSearches => _recentSearches;

  final TripCalculationService _tripService = TripCalculationService();

  Future<void> calculateTrip({
    required String fromLocation,
    required String toLocation,
    required double fromLat,
    required double fromLng,
    required double toLat,
    required double toLng,
    required CarModel car,
    required int numberOfPeople,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentTrip = await _tripService.calculateTrip(
        fromLocation: fromLocation,
        toLocation: toLocation,
        fromLat: fromLat,
        fromLng: fromLng,
        toLat: toLat,
        toLng: toLng,
        car: car,
        numberOfPeople: numberOfPeople,
      );

      // Add to recent searches
      final searchQuery = '$fromLocation to $toLocation';
      if (!_recentSearches.contains(searchQuery)) {
        _recentSearches.insert(0, searchQuery);
        if (_recentSearches.length > 5) {
          _recentSearches.removeLast();
        }
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearTrip() {
    _currentTrip = null;
    notifyListeners();
  }
}