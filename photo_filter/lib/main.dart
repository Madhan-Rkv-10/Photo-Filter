import 'package:flutter/material.dart';

import 'package:photo_filter/widgets/filter_selector.dart';

void main() {
  runApp(
    const MaterialApp(
      // showSemanticsDebugger: true,
      home: ExampleInstagramFilterSelection(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

@immutable
class ExampleInstagramFilterSelection extends StatefulWidget {
  const ExampleInstagramFilterSelection({super.key});

  @override
  State<ExampleInstagramFilterSelection> createState() =>
      _ExampleInstagramFilterSelectionState();
}

class _ExampleInstagramFilterSelectionState
    extends State<ExampleInstagramFilterSelection> {
  final _filters = [
    Colors.blue,
    ...List.generate(
      Colors.primaries.length,
      (index) => Colors.primaries[(index * 4) % Colors.primaries.length],
    )
  ];

  final _filterColor = ValueNotifier<Color>(Colors.white);

  void _onFilterChanged(Color value) {
    _filterColor.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // GridView.custom(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount), childrenDelegate: childrenDelegate)
        Positioned.fill(
          child: _buildPhotoWithFilter(),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: FilterSelector(
            onFilterChanged: _onFilterChanged,
            filters: _filters,
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoWithFilter() {
    return ValueListenableBuilder(
      valueListenable: _filterColor,
      builder: (context, color, child) {
        return Image.network(
          'https://docs.flutter.dev/assets/images/dash/Dashatars.png',
          color: color.withOpacity(0.5),
          colorBlendMode: BlendMode.color,
          fit: BoxFit.cover,
        );
      },
    );
  }
}

@immutable
class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.color,
    this.onFilterSelected,
  });

  final Color color;
  final VoidCallback? onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFilterSelected,
      child: AspectRatio(
        aspectRatio: 1.5,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipOval(
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              'https://docs.flutter.dev/cookbook/img-files/effects/instagram-buttons/millenial-texture.jpg',
              color: color.withOpacity(0.5),
              colorBlendMode: BlendMode.hardLight,
            ),
          ),
        ),
      ),
    );
  }
}
