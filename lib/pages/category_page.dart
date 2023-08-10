import 'package:flutter/material.dart';
import 'package:jars_news_app/pages/source_page.dart';

class CategoryPage extends StatelessWidget {
  static const nameRoute = "/CategoryPage";

  final Map<String, String> categories = {
    'General':
        'https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGdlbmVyYWx8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
    'Technology':
        'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80',
    'Health':
        'https://images.unsplash.com/photo-1532938911079-1b06ac7ceec7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1032&q=80',
    'Sports':
        'https://images.unsplash.com/photo-1556817411-31ae72fa3ea0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80',
    'Entertainment':
        'https://images.unsplash.com/photo-1598899134739-24c46f58b8c0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8RW50ZXJ0YWlubWVudHxlbnwwfDB8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
    'Science':
        'https://images.unsplash.com/photo-1617791160536-598cf32026fb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fFNjaWVuY2V8ZW58MHwwfDB8fHww&auto=format&fit=crop&w=500&q=60',
    'Business':
        'https://images.unsplash.com/photo-1612550761236-e813928f7271?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YnVzc2luZXNzfGVufDB8MHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category News"),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories.keys.elementAt(index);
          final imageUrl = categories.values.elementAt(index);
          return CategoryCard(
            category: category,
            imgUrl: imageUrl,
          );
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;
  final String imgUrl;  

  CategoryCard({required this.category, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {        
        Navigator.of(context).pushNamed(SourceNewsPage.nameRoute,
            arguments: this.category.toString());
      },
      child: Card(
        margin: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: GridTile(
            child: GestureDetector(
              child: Image.network(
                imgUrl,
                fit: BoxFit.cover,
              ),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black87,
              title: Text(
                category,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
