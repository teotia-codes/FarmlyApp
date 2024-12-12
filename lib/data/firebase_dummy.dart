final jsonFirebase = '''
{
  "communities": {
    "communityId1": {
      "name": "Community A",
      "memberCount": 100,
      "members": ["farmerId1", "farmerId2", "farmerId3"],
      "location": "New York",
      "tags": ["organic", "sustainable"],
      "crowdfunding": [
        {
          "name": "Funding for new seeds",
          "goal": 50000,
          "currentFunding": 25000,
          "deadline": "2024-06-30"
        }
      ],
      "monthly_deliverables": [
        {
          "buyer": "GreenMart",
          "products": ["Potatoes", "Tomatoes"],
          "quantity": "500 kg",
          "deliveryDate": "2024-06-30",
          "uuid": "uuid2"
        }
      ],
      "selling": [
        {"name": "Potatoes", "quantity": 50, "price": 20, "uuid": "uuid3"}
      ],
      "sharing": [
        {
          "toolName": "Plough",
          "availability": "Available",
          "owner": "Farmer A",
          "uuid": "uuid4"
        }
      ],
      "transport": [
        {
          "vehicle": "Tractor",
          "availability": "Available",
          "cost_per_trip": 500,
          "uuid": "uuid5"
        }
      ]
    },
    "communityId2": {
      "name": "Community B",
      "memberCount": 80,
      "members": ["farmerId4", "farmerId5", "farmerId6"],
      "location": "California",
      "tags": ["sustainable", "local"],
      "crowdfunding": [
        {
          "name": "Funding for new tractor",
          "goal": 30000,
          "currentFunding": 15000,
          "deadline": "2024-12-31"
        }
      ],
      "monthly_deliverables": [
        {
          "buyer": "Local Market",
          "products": ["Carrots", "Onions"],
          "quantity": "300 kg",
          "deliveryDate": "2024-08-15",
          "uuid": "uuid7"
        }
      ],
      "selling": [
        {"name": "Carrots", "quantity": 40, "price": 15, "uuid": "uuid8"}
      ],
      "sharing": [
        {
          "toolName": "Harvester",
          "availability": "Available",
          "owner": "Farmer B",
          "uuid": "uuid9"
        }
      ],
      "transport": [
        {
          "vehicle": "Truck",
          "availability": "Available",
          "cost_per_trip": 600,
          "uuid": "uuid10"
        }
      ]
    },
    "communityId3": {
      "name": "Community C",
      "memberCount": 75,
      "members": ["farmerId7", "farmerId8", "farmerId9"],
      "location": "Texas",
      "tags": ["organic", "local"],
      "crowdfunding": [
        {
          "name": "Funding for harvest storage",
          "goal": 20000,
          "currentFunding": 8000,
          "deadline": "2025-03-31"
        }
      ],
      "monthly_deliverables": [
        {
          "buyer": "Local Grocery",
          "products": ["Lettuce", "Spinach"],
          "quantity": "200 kg",
          "deliveryDate": "2024-10-15",
          "uuid": "uuid12"
        }
      ],
      "selling": [
        {"name": "Lettuce", "quantity": 30, "price": 10, "uuid": "uuid13"}
      ],
      "sharing": [
        {
          "toolName": "Water Pump",
          "availability": "Available",
          "owner": "Farmer C",
          "uuid": "uuid14"
        }
      ],
      "transport": [
        {
          "vehicle": "Small Truck",
          "availability": "Available",
          "cost_per_trip": 400,
          "uuid": "uuid15"
        }
      ]
    },
    "communityId4": {
      "name": "Community D",
      "memberCount": 90,
      "members": ["farmerId10", "farmerId11", "farmerId12"],
      "location": "Colorado",
      "tags": ["sustainable", "organic"],
      "crowdfunding": [
        {
          "name": "Funding for new plough",
          "goal": 40000,
          "currentFunding": 18000,
          "deadline": "2025-01-31"
        }
      ],
      "monthly_deliverables": [
        {
          "buyer": "Local Restaurant",
          "products": ["Herbs", "Spices"],
          "quantity": "100 kg",
          "deliveryDate": "2024-12-15",
          "uuid": "uuid17"
        }
      ],
      "selling": [
        {"name": "Herbs", "quantity": 20, "price": 15, "uuid": "uuid18"}
      ],
      "sharing": [
        {
          "toolName": "Tractor",
          "availability": "Available",
          "owner": "Farmer D",
          "uuid": "uuid19"
        }
      ],
      "transport": [
        {
          "vehicle": "Van",
          "availability": "Available",
          "cost_per_trip": 300,
          "uuid": "uuid20"
        }
      ]
    }
  }
}
''';
