import 'package:app/farmer_direc/models/commodity_price.dart';
import 'package:app/farmer_direc/requests/commodity_request.dart';
import 'package:flutter/material.dart';

class MarketDataPage extends StatefulWidget {
  @override
  _MarketDataPageState createState() => _MarketDataPageState();
}

class _MarketDataPageState extends State<MarketDataPage> {
  List<CommodityPrice> marketData = [];
  bool isLoading = false;

  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _commodityController = TextEditingController();

  Future<void> loadMarketData(String district, String commodity) async {
    setState(() {
      isLoading = true;
    });

    final request = MarketDataRequest(
      apiKey: '579b464db66ec23bdd0000011926b59910234b2c418e8e88ec4c0c22',
      format: 'json',
      limit: 100,
      filters: {
        'District.keyword': district,
        'Commodity.keyword': commodity,
      },
    );

    try {
      final response = await fetchMarketData(request);
      setState(() {
        marketData = CommodityPrice.parseList(response['records']);
      });
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _submit() {
    String district = _districtController.text.trim();
    String commodity = _commodityController.text.trim();

    if (district.isNotEmpty && commodity.isNotEmpty) {
      loadMarketData(district, commodity);
    } else {
      print('Please enter both a district and a commodity');
    }
  }

  @override
  void dispose() {
    _districtController.dispose();
    _commodityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Market Data'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _districtController,
              decoration: InputDecoration(
                labelText: 'Enter District',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_city),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _commodityController,
              decoration: InputDecoration(
                labelText: 'Enter Commodity',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.fastfood),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _submit,
            child: Text('Fetch Market Data'),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : marketData.isEmpty
                    ? Center(child: Text('No data available'))
                    : ListView.builder(
                        itemCount: marketData.length,
                        itemBuilder: (context, index) {
                          final item = marketData[index];
                          return Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: ListTile(
                              title: Text(
                                item.commodity,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Market: ${item.market}'),
                                  Text('Variety: ${item.variety}'),
                                  Text('Min Price: ₹${item.minPrice}'),
                                  Text('Max Price: ₹${item.maxPrice}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
