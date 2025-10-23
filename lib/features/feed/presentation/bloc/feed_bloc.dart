import 'dart:async';

import 'package:ezdu/core/usecases/usecase.dart';
import 'package:ezdu/features/feed/domain/entities/feed.dart';
import 'package:ezdu/features/feed/domain/usecases/get_feed.dart';
import 'package:ezdu/features/feed/domain/usecases/get_suggested_friends.dart';
import 'package:ezdu/features/feed/presentation/bloc/feed_event.dart';
import 'package:ezdu/features/feed/presentation/bloc/feed_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeedItems getFeedItems;
  final GetSuggestedFriends suggestedFriends;

  final List<FeedEntry> _feedItems = [];

  FeedBloc({required this.getFeedItems, required this.suggestedFriends})
    : super(const FeedInitial()) {
    on<LoadFeed>(_onLoadFeed);
    on<LoadSuggestedFriend>(_onLoadSuggestedFriend);
    on<ToggleLikeEvent>(_onToggleLike);
    on<RemoveFeedItemEvent>(_onRemoveFeedItem);
  }

  Future<void> _onLoadFeed(
    LoadFeed event,
    Emitter<FeedState> emit,
  ) async {
    emit(const FeedLoading());

    final result = await getFeedItems(NoParams());

    result.fold(
      (failure) => emit(FeedError(message: failure.message)),
      (data) => emit(FeedLoaded(data)),
    );
  }

  FutureOr<void> _onLoadSuggestedFriend(
    LoadSuggestedFriend event,
    Emitter<FeedState> emit,
  ) {}

  Future<void> _onToggleLike(
    ToggleLikeEvent event,
    Emitter<FeedState> emit,
  ) async {
    final itemIndex = _feedItems.indexWhere(
      (item) => item.id == event.feedItemId,
    );
    if (itemIndex != -1) {
      final item = _feedItems[itemIndex];
      _feedItems[itemIndex] = item.copyWith(
        isLiked: !item.isLiked,
        likeCount: item.isLiked ? item.likeCount - 1 : item.likeCount + 1,
      );
      emit(FeedLoaded(List.from(_feedItems)));
    }
  }

  Future<void> _onRemoveFeedItem(
    RemoveFeedItemEvent event,
    Emitter<FeedState> emit,
  ) async {
    _feedItems.removeWhere((item) => item.id == event.feedItemId);
    emit(FeedLoaded(List.from(_feedItems)));
  }
}
