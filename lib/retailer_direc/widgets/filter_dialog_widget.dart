import 'package:flutter/material.dart';
// import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;
// import 'package:range_slider_flutter/range_slider_flutter.dart' as frs;
import 'package:syncfusion_flutter_sliders/sliders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filter Dialog Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return FilterDialog();
              },
            );
          },
          child: Text('Show Filters'),
        ),
      ),
    );
  }
}

class FilterDialog extends StatefulWidget {
  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  // String selectedCategory = 'Grains';
  // String selectedLocation = 'All';
  // double minPrice = 0.0;
  // double maxPrice = 1000.0;
  // bool inStock = true;
  // bool preOrder = false;
  // double selectedRating = 4.0;
  // String selectedSortOption = 'Price: Low to High';
  SfRangeValues _priceRange = SfRangeValues(0, 1000);
  String _selectedCategory = 'Grains';
  String _selectedLocation = 'State';
  String _availability = 'In stock';
  String _ratings = 'All';
  String _sortBy = 'Price Low to High';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Filter Options'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Dropdown
            DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: <String>['Grains', 'Vegetables', 'Fruits']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isExpanded: true,
            ),
            SizedBox(height: 10),
            
            // Location Dropdown
            DropdownButton<String>(
              value: _selectedLocation,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLocation = newValue!;
                });
              },
              items: <String>['State', 'Proximity']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isExpanded: true,
            ),
            SizedBox(height: 10),
            
            // Price Range Slider
            SfRangeSlider(
              min: 0.0,
              max: 1000.0,
              values: _priceRange,
              interval: 1000,
              showTicks: true,
              showLabels: true,
              onChanged: (values) {
                setState(() {
                  _priceRange = values;
                });
              },
            ),
            SizedBox(height: 10),
            
            // Availability Dropdown
            DropdownButton<String>(
              value: _availability,
              onChanged: (String? newValue) {
                setState(() {
                  _availability = newValue!;
                });
              },
              items: <String>['In stock', 'Pre-orders']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isExpanded: true,
            ),
            SizedBox(height: 10),
            
            // Ratings Dropdown
            DropdownButton<String>(
              value: _ratings,
              onChanged: (String? newValue) {
                setState(() {
                  _ratings = newValue!;
                });
              },
              items: <String>['All', '4 Stars & Above', '5 Stars']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isExpanded: true,
            ),
            SizedBox(height: 10),
            
            // Sort Options Dropdown
            DropdownButton<String>(
              value: _sortBy,
              onChanged: (String? newValue) {
                setState(() {
                  _sortBy = newValue!;
                });
              },
              items: <String>[
                'Price Low to High',
                'Price High to Low',
                'Best Rated',
                'Availability'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isExpanded: true,
            ),
          ],
        ),
      ),
    );}}

//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Category Filter
//             DropdownButtonFormField<String>(
//               value: selectedCategory,
//               decoration: InputDecoration(labelText: 'Category'),
//               items: ['Grains', 'Vegetables', 'Fruits', 'Dairy']
//                   .map((category) =>
//                       DropdownMenuItem(value: category, child: Text(category)))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedCategory = value!;
//                 });
//               },
//             ),

//             // Location Filter
//             DropdownButtonFormField<String>(
//               value: selectedLocation,
//               decoration: InputDecoration(labelText: 'Location'),
//               items: ['All', 'Nearby', 'State A', 'State B']
//                   .map((location) =>
//                       DropdownMenuItem(value: location, child: Text(location)))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedLocation = value!;
//                 });
//               },
//             ),

//             // Price Range Filter
//             Text('Price Range'),
//             RangeSlider(
//               min: 0.0,
//               max: 1000.0,
//               values: _priceRange,
//               interval: 100,
//               showTicks: true,
//               showLabels: true,
//               onChanged: (values) {
//                 setState(() {
//                   _priceRange = values;
//                 });
//               },
//             ),
//             Text(
//                 'Min: \$${minPrice.toStringAsFixed(2)}, Max: \$${maxPrice.toStringAsFixed(2)}'),

//             // Availability Filter
//             CheckboxListTile(
//               title: Text('In Stock'),
//               value: inStock,
//               onChanged: (value) {
//                 setState(() {
//                   inStock = value!;
//                 });
//               },
//             ),
//             CheckboxListTile(
//               title: Text('Pre-orders'),
//               value: preOrder,
//               onChanged: (value) {
//                 setState(() {
//                   preOrder = value!;
//                 });
//               },
//             ),

//             // Ratings Filter
//             Text('Minimum Rating: ${selectedRating.toStringAsFixed(1)}'),
//             Slider(
//               min: 0.0,
//               max: 5.0,
//               value: selectedRating,
//               divisions: 5,
//               label: selectedRating.toStringAsFixed(1),
//               onChanged: (value) {
//                 setState(() {
//                   selectedRating = value;
//                 });
//               },
//             ),

//             // Sort Options
//             DropdownButtonFormField<String>(
//               value: selectedSortOption,
//               decoration: InputDecoration(labelText: 'Sort By'),
//               items: [
//                 'Price: Low to High',
//                 'Price: High to Low',
//                 'Best Rated',
//                 'Availability'
//               ]
//                   .map((sortOption) => DropdownMenuItem(
//                       value: sortOption, child: Text(sortOption)))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedSortOption = value!;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () {
//             // Apply filter logic here
//             Navigator.of(context).pop();
//           },
//           child: Text('Apply'),
//         ),
//       ],
//     );
//   }
// }
