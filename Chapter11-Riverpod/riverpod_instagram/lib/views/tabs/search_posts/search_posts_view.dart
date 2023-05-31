import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_instagram/extensions/string/trimmed_string.dart';
import 'package:riverpod_instagram/views/components/search_posts/search_result_widget.dart';
import 'package:riverpod_instagram/views/constants/strings.dart';
import 'package:riverpod_instagram/views/extensions/dismiss_keyboard.dart';

class SearchPostsView extends HookConsumerWidget {
  const SearchPostsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final searchTerm = useState('');
    useEffect(
      () {
        controller.addListener(() {
          searchTerm.value = controller.text.trimmed;
        });
        return () {};
      },
      [controller],
    );

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: Strings.enterYourSearchTermHere,
                suffixIcon: searchTerm.value.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controller.clear();
                          dismissKeyboard();
                        },
                      )
                    : null,
                // border: const OutlineInputBorder(),
              ),
            ),
          ),
        ),
        SearchResultWidget(
          searchTerm: searchTerm.value,
        ),
      ],
    );
  }
}
