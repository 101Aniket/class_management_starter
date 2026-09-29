import 'package:flutter/material.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../components/common/empty_state.dart';
import '../../components/inputs/app_search_field.dart';
import '../../components/skeletons/skeleton_widgets.dart';
import '../../core/extensions/context_extensions.dart';

/// A functional-looking search interface.
///
/// No real backend search exists yet (per the project brief) — this
/// screen demonstrates the complete *interaction* surface a search
/// feature needs: an input with a clear affordance, a recent-searches
/// list, a brief loading state, an empty-results state, and a simple
/// result list rendered from local mock filtering. Wiring in a real
/// search API later means only the `_performSearch` method changes.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

enum _SearchState { idle, loading, results, empty }

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  _SearchState _state = _SearchState.idle;
  List<String> _results = [];

  // Sample data. A real app would persist recent searches (the way
  // SettingsStorage persists settings); the entries are content rather
  // than interface text, so they are not translated.
  final List<String> _recentSearches = [
    'Mathematics',
    'Attendance report',
    'Priya Sharma',
  ];

  static const List<String> _mockDataset = [
    'Mathematics - Class 8B',
    'Science - Class 7A',
    'Attendance report - September',
    'Homework - Algebra Basics',
    'Priya Sharma - Student',
    'Parent Teacher Meeting notes',
  ];

  @override
  void dispose() {
    // This controller IS owned by this screen (created here), so unlike
    // AppSearchField's internal listener, disposing it here is required
    // to release its resources.
    _controller.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _state = _SearchState.idle;
        _results = [];
      });
      return;
    }

    setState(() => _state = _SearchState.loading);

    // Artificial delay to demonstrate the loading skeleton — a real
    // implementation would await an actual query here instead.
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    final matches = _mockDataset
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _results = matches;
      _state = matches.isEmpty ? _SearchState.empty : _SearchState.results;
      if (matches.isNotEmpty && !_recentSearches.contains(query)) {
        _recentSearches.insert(0, query);
        if (_recentSearches.length > 5) _recentSearches.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(strings.search, style: AppTextStyles.headline),
            const SizedBox(height: AppSpacing.md),
            AppSearchField(
              controller: _controller,
              hintText: strings.searchHint,
              autofocus: false,
              onChanged: _performSearch,
              onClear: () => setState(() {
                _state = _SearchState.idle;
                _results = [];
              }),
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(child: _buildBody(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final strings = context.strings;

    switch (_state) {
      case _SearchState.idle:
        return _RecentSearches(
          recent: _recentSearches,
          onSelect: (query) {
            _controller.text = query;
            _performSearch(query);
          },
        );
      case _SearchState.loading:
        return ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) => const SkeletonListItem(),
        );
      case _SearchState.empty:
        return EmptyState(
          icon: Icons.search_off_rounded,
          title: strings.noResultsTitle,
          description: strings.noResultsMessage,
        );
      case _SearchState.results:
        return ListView.separated(
          itemCount: _results.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.description_outlined),
              title: Text(_results[index], style: AppTextStyles.body),
            );
          },
        );
    }
  }
}

class _RecentSearches extends StatelessWidget {
  const _RecentSearches({required this.recent, required this.onSelect});

  final List<String> recent;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    if (recent.isEmpty) {
      return EmptyState(
        icon: Icons.history_rounded,
        title: strings.noRecentSearchesTitle,
        description: strings.noRecentSearchesMessage,
      );
    }

    return ListView(
      children: [
        Text(strings.recentSearches, style: AppTextStyles.bodyStrong),
        const SizedBox(height: AppSpacing.sm),
        ...recent.map(
          (query) => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.history_rounded),
            title: Text(query, style: AppTextStyles.body),
            onTap: () => onSelect(query),
          ),
        ),
      ],
    );
  }
}
