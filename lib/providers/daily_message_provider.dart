import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindlee_task/models/daily_message_model.dart';
import 'package:mindlee_task/services/daily_message_service.dart';

enum LoadingStatus {
  loading,
  loaded,
  error,
}

class DailyMessageNotifier extends StateNotifier<DailyMessageState> {
  final DailyMessageService _service;

  DailyMessageNotifier(this._service) : super(DailyMessageState()) {
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      final messages = await _service.fetchDailyMessages();
      state = state.copyWith(
          messages: messages, loadingStatus: LoadingStatus.loaded);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to load messages: $e');
      }
    }
  }

  void toggleLike(String id) {
    final updatedMessages = state.messages.map((message) {
      if (message.id == id) {
        return message.copyWith(liked: !(message.liked ?? false));
      }
      return message;
    }).toList();

    state = state.copyWith(messages: updatedMessages);
  }

  void setCurrentlySelectedMessageIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }
}

class DailyMessageState {
  final List<DailyMessageModel> messages;
  final int currentIndex;
  final LoadingStatus loadingStatus;

  DailyMessageState({
    this.messages = const [],
    this.currentIndex = 0,
    this.loadingStatus = LoadingStatus.loading,
  });

  DailyMessageState copyWith({
    List<DailyMessageModel>? messages,
    int? currentIndex,
    LoadingStatus? loadingStatus,
  }) {
    return DailyMessageState(
      messages: messages ?? this.messages,
      currentIndex: currentIndex ?? this.currentIndex,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}

final dailyMessageServiceProvider = Provider<DailyMessageService>((ref) {
  return DailyMessageService();
});

final messageProvider =
    StateNotifierProvider<DailyMessageNotifier, DailyMessageState>((ref) {
  final service = ref.read(dailyMessageServiceProvider);
  return DailyMessageNotifier(service);
});
