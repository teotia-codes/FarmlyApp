// Creating multiple FarmerModel examples

import 'package:app/farmer_direc/dashboard/model/farmer_model.dart';
import 'package:app/farmer_direc/dashboard/model/revenue_model.dart';
import 'package:app/farmer_direc/orders/model/exampleOrders.dart';
import 'package:app/farmer_direc/ratingandcredit/model/exampleRatings.dart';

FarmerModel exampleFarmer1 = FarmerModel(
  name: 'Farmer A',
  id: 'farmerA123',
  add: '101 Green Fields, Rural Area A',
  credit: exampleTrueCredit1,
  orders: [exampleOrder1, exampleOrder2],
  revenueModel: calculateRevenueAndProfit([exampleOrder1, exampleOrder2]),
);

FarmerModel exampleFarmer2 = FarmerModel(
  name: 'Farmer B',
  id: 'farmerB456',
  add: '202 Blue Meadows, Rural Area B',
  credit: exampleTrueCredit2,
  orders: [exampleOrder2, exampleOrder3],
  revenueModel: calculateRevenueAndProfit([exampleOrder2, exampleOrder3]),
);

FarmerModel exampleFarmer3 = FarmerModel(
  name: 'Farmer C',
  id: 'farmerC789',
  add: '303 Golden Hills, Rural Area C',
  credit: exampleTrueCredit3,
  orders: [exampleOrder1, exampleOrder3],
  revenueModel: calculateRevenueAndProfit([exampleOrder1, exampleOrder3]),
);

FarmerModel exampleFarmer4 = FarmerModel(
  name: 'Farmer D',
  id: 'farmerD101',
  add: '404 Red Valley, Rural Area D',
  credit: exampleTrueCredit4,
  orders: [exampleOrder1],
  revenueModel: calculateRevenueAndProfit([exampleOrder1]),
);

FarmerModel exampleFarmer5 = FarmerModel(
  name: 'Farmer E',
  id: 'farmerE202',
  add: '505 Silver Lake, Rural Area E',
  credit: exampleTrueCredit5,
  orders: [exampleOrder3],
  revenueModel: calculateRevenueAndProfit([exampleOrder3]),
);

FarmerModel exampleFarmer6 = FarmerModel(
  name: 'Farmer F',
  id: 'farmerF303',
  add: '606 Black River, Rural Area F',
  credit: exampleTrueCredit6,
  orders: [exampleOrder2],
  revenueModel: calculateRevenueAndProfit([exampleOrder2]),
);

FarmerModel exampleFarmer7 = FarmerModel(
  name: 'Farmer G',
  id: 'farmerG404',
  add: '707 White Plains, Rural Area G',
  credit: exampleTrueCredit7,
  orders: [exampleOrder3],
  revenueModel: calculateRevenueAndProfit([exampleOrder3]),
);

FarmerModel exampleFarmer8 = FarmerModel(
  name: 'Farmer H',
  id: 'farmerH505',
  add: '808 Orange Grove, Rural Area H',
  credit: exampleTrueCredit8,
  orders: [exampleOrder1],
  revenueModel: calculateRevenueAndProfit([exampleOrder1]),
);

FarmerModel exampleFarmer9 = FarmerModel(
  name: 'Farmer I',
  id: 'farmerI606',
  add: '909 Purple Orchard, Rural Area I',
  credit: exampleTrueCredit9,
  orders: [exampleOrder2],
  revenueModel: calculateRevenueAndProfit([exampleOrder2]),
);

FarmerModel exampleFarmer10 = FarmerModel(
  name: 'Farmer J',
  id: 'farmerJ707',
  add: '1010 Green Forest, Rural Area J',
  credit: exampleTrueCredit10,
  orders: [exampleOrder3],
  revenueModel: calculateRevenueAndProfit([exampleOrder3]),
);
