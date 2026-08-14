import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssessmentResultsHeader
    extends StatelessWidget {

  final String title;
  final TextEditingController searchController;
  final ValueChanged<String> onSearch;

  const AssessmentResultsHeader({
    super.key,
    required this.title,
    required this.searchController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        24,
        24,
        24,
        16,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: Get.back,
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            'Student Results',
            style: Theme.of(context)
                .textTheme
                .titleLarge,
          ),

          const SizedBox(height: 12),

          TextField(
            controller: searchController,
            onChanged: onSearch,
            decoration: InputDecoration(
              hintText:
                  'Search by student name or ID',
              prefixIcon:
                  const Icon(Icons.search),
              suffixIcon:
                  searchController.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            searchController.clear();
                            onSearch('');
                          },
                          icon: const Icon(
                            Icons.clear,
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}