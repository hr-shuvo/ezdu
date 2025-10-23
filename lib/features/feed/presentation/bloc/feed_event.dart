import 'package:equatable/equatable.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object?> get props => [];
}

class LoadFeed extends FeedEvent {
  const LoadFeed();
}

class LoadSuggestedFriend extends FeedEvent {
  const LoadSuggestedFriend();
}

class ToggleLikeEvent extends FeedEvent {
  final String feedItemId;

  const ToggleLikeEvent(this.feedItemId);

  @override
  List<Object?> get props => [feedItemId];
}

class RemoveFeedItemEvent extends FeedEvent {
  final String feedItemId;

  const RemoveFeedItemEvent(this.feedItemId);

  @override
  List<Object?> get props => [feedItemId];
}