import 'package:riverpod_instagram/state/comments/models/comment.dart';
import 'package:riverpod_instagram/state/comments/models/post_comments_request.dart';
import 'package:riverpod_instagram/state/enums/date_sorting.dart';

extension Sorting on Iterable<Comment> {
  Iterable<Comment> applySortingFrom(RequestForPostAndComments request) {
    if (request.sortByCreatedAt) {
      final sortedComments = toList()
        ..sort((a, b) {
          switch (request.dateSorting) {
            case DateSorting.newestOnTop:
              return b.createdAt.compareTo(a.createdAt);
            case DateSorting.oldestOnTop:
              return a.createdAt.compareTo(b.createdAt);
          }
        });
      return sortedComments;
    } else {
      return this;
    }
  }
}
