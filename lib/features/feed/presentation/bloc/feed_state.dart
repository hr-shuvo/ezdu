import 'package:equatable/equatable.dart';
import 'package:ezdu/features/feed/domain/entities/feed.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object?> get props => [];
}


class FeedInitial extends FeedState {
  const FeedInitial();
}

class FeedLoading extends FeedState {
  const FeedLoading();
}

class FeedLoaded extends FeedState {
  final List<FeedEntry> feedItems;

  const FeedLoaded(this.feedItems);

  @override
  List<Object?> get props => [feedItems];
}

class FeedError extends FeedState {
  final String message;

  const FeedError({required this.message});

  @override
  List<Object?> get props => [message];
}