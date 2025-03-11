import 'package:dash_survey/dash_survey.dart';
import 'package:flutter/material.dart';

class FurnitureItem {
  FurnitureItem({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageAsset,
    required this.category,
  });

  final String id;
  final String name;
  final double price;
  final String description;
  final String imageAsset;
  final String category;
}

final sampleFurniture = [
  FurnitureItem(
    id: '1',
    name: 'Modern Lounge Chair',
    price: 599.99,
    description:
        'Elegant and comfortable lounge chair perfect for any living room.',
    imageAsset: 'assets/1.jpg',
    category: 'Chairs',
  ),
  FurnitureItem(
    id: '2',
    name: 'Minimalist Coffee Table',
    price: 299.99,
    description:
        'Sleek coffee table with clean lines and durable construction.',
    imageAsset: 'assets/2.jpg',
    category: 'Tables',
  ),
  FurnitureItem(
    id: '3',
    name: 'Luxurious Sofa',
    price: 1299.99,
    description:
        'Premium three-seater sofa with plush cushions and premium fabric.',
    imageAsset: 'assets/3.jpg',
    category: 'Sofas',
  ),
  FurnitureItem(
    id: '4',
    name: 'Designer Dining Set',
    price: 899.99,
    description: 'Modern dining set including table and four matching chairs.',
    imageAsset: 'assets/4.jpg',
    category: 'Dining',
  ),
  FurnitureItem(
    id: '5',
    name: 'Accent Cabinet',
    price: 449.99,
    description: 'Stylish storage solution with contemporary design.',
    imageAsset: 'assets/5.jpg',
    category: 'Storage',
  ),
];

class FurnitureStoreHome extends StatelessWidget {
  const FurnitureStoreHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Luxury Furniture'),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DashSurvey.showDemo(
            context: context,
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: SearchBar(),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: sampleFurniture.length + 1,
              itemBuilder: (context, index) {
                if (index == sampleFurniture.length) {
                  return const SurveyCard();
                }
                final item = sampleFurniture[index];
                return FurnitureCard(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          icon: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.search),
          ),
          hintText: 'Search furniture...',
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class FurnitureCard extends StatelessWidget {
  final FurnitureItem item;

  const FurnitureCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FurnitureDetailScreen(item: item),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  item.imageAsset,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      // color: Colors.green[700],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SurveyCard extends StatelessWidget {
  const SurveyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashSurveyBuilder(
      builder: (context, surveyWidget, surveyState) {
        final surveyAvailable = surveyState != SurveyState.loading &&
            surveyState != SurveyState.noSurveyAvailable;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: surveyAvailable
              ? Card(
                  key: const Key('survey-available'),
                  elevation: 4,
                  child: surveyWidget,
                )
              : const SizedBox.shrink(key: Key('survey-not-available')),
        );
      },
    );
  }
}

class FurnitureDetailScreen extends StatelessWidget {
  final FurnitureItem item;

  const FurnitureDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                item.imageAsset,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Category: ${item.category}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Add to Cart',
            ),
          ),
        ),
      ),
    );
  }
}
