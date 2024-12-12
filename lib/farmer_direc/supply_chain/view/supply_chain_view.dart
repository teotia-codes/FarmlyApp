import 'package:app/utils/appcolors.dart';
import 'package:app/utils/texttheme.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart'; // For HTTP requests
import 'package:flutter/services.dart'; // To load ABI from assets
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class SupplyChainPage extends StatefulWidget {
  final String orderId;

  const SupplyChainPage({Key? key, required this.orderId}) : super(key: key);
  @override
  _SupplyChainPageState createState() => _SupplyChainPageState();
}

enum NodeType { Farmer, LocalAggregator, Transporter, Retailer, Consumer }

class SupplyChainBlock {
  final String id;
  final NodeType nodeType;
  Map<String, dynamic> nodeData;
  String? validationTimestamp;
  final String qrData;
  bool isPopulated;
  bool isQRValidated;

  SupplyChainBlock({
    required this.nodeType,
    this.nodeData = const {},
    this.isPopulated = false,
    this.isQRValidated = false,
  })  : id = Uuid().v4(),
        qrData = Uuid().v4();

  String get nodeTypeString => nodeType.toString().split('.').last;
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Draw a curved arrow
    path.moveTo(size.width / 2, 0);
    path.cubicTo(size.width / 2, size.height * 0.3, size.width / 2,
        size.height * 0.7, size.width / 2, size.height);

    // Draw arrowhead
    path.moveTo(size.width / 2 - 5, size.height - 10);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width / 2 + 5, size.height - 10);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SupplyChainPageState extends State<SupplyChainPage> {
  Web3Client? ethClient;

  // Contract details
  final contractAddress =
      '0x32aBa3a5B61878268AA68fC166A63Aae9A318c52'; // Replace with your deployed contract address
  final contractAbiPath = 'assets/abi.json'; // ABI file stored in assets

  // Initialize Web3 client
  @override
  void initState() {
    super.initState();
    _initializeSupplyChain();
    ethClient = Web3Client(
        "https://sepolia.infura.io/v3/372b49c05d014b05aee72de81ed2e801",
        Client());
  }

  void _initializeSupplyChain() {
    supplyChain = NodeType.values
        .map((nodeType) => SupplyChainBlock(nodeType: nodeType))
        .toList();
  }

  // Function to load the contract ABI
  Future<DeployedContract> loadContract() async {
    final abiString = await rootBundle.loadString(contractAbiPath);
    final contract = DeployedContract(
      ContractAbi.fromJson(abiString, 'SimpleSupplyChain'),
      EthereumAddress.fromHex(contractAddress),
    );
    return contract;
  }

  // Function to create a new batch
  Future<void> createNewBatch() async {
    print("yes");
    try {
      // Load contract
      final contract = await loadContract();

      // Prepare credentials
      final credentials = EthPrivateKey.fromHex(
          'd4d514a218eac030a3a2443663bbe53b05523cd66ebd0330d57c20cc6abc03f0');

      // Get the sender's address
      final sender = credentials.address;

      // Check account balance
      final balance = await ethClient!.getBalance(sender);
      print('Sender Address: $sender');
      print('Current Balance: ${balance.getValueInUnit(EtherUnit.ether)} ETH');

      // Get current gas price
      final gasPrice = await ethClient!.getGasPrice();
      print(
          'Current Gas Price: ${gasPrice.getValueInUnit(EtherUnit.gwei)} Gwei');

      // Prepare transaction parameters
      final batchId = BigInt.from(5); // Example batch ID
      final farmerId = 'farmer11123';
      final cropType = 'wheat';
      final quantity = BigInt.from(100);
      final location = 'Farmer\'s Village';
      final harvestDate = BigInt.from(DateTime.now().millisecondsSinceEpoch);

      // Get the function
      final createBatchFunction = contract.function('createNewBatch');

      // Prepare transaction
      final transaction = Transaction.callContract(
        contract: contract,
        function: createBatchFunction,
        parameters: [
          batchId,
          farmerId,
          cropType,
          quantity,
          location,
          harvestDate
        ],
        maxGas: 300000, // Set an appropriate gas limit
        gasPrice: gasPrice,
      );

      // Send transaction
      final txHash = await ethClient!.sendTransaction(
        credentials,
        transaction,
        chainId: 11155111, // Sepolia chain ID
      );

      // Print transaction details
      print('Transaction Hash: $txHash');
      print('Etherscan Link: https://sepolia.etherscan.io/tx/$txHash');

      // Wait for transaction receipt
      final receipt = await ethClient!.getTransactionReceipt(txHash);
      print('Transaction Status: ${receipt?.status}');
      print('Block Number: ${receipt?.blockNumber}');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Batch Created Successfully. TX Hash: $txHash'),
        duration: Duration(seconds: 5),
      ));
    } catch (e) {
      print('Detailed Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ));
    }
  }

  List<SupplyChainBlock> supplyChain = [];
  NodeType? currentNodeType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        title: Text(
          'Supply Chain',
          textAlign: TextAlign.center,
          style: TextPref.opensans.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.kBackground,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
          "Order ID: ${widget.orderId}",
          textAlign: TextAlign.center,
          style: TextPref.opensans.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: supplyChain.length,
              itemBuilder: (context, index) {
                final block = supplyChain[index];
                return Column(
                  children: [
                    // Flow chart arrow between nodes (except for the first node)
                    if (index > 0)
                      CustomPaint(
                        painter: ArrowPainter(),
                        child: const SizedBox(
                          height: 30,
                          width: double.infinity,
                        ),
                      ),

                    // Node Card
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: block.isPopulated
                                ? (block.isQRValidated
                                    ? Colors.green.shade200
                                    : Colors.amber.shade200)
                                : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        color: block.isPopulated
                            ? (block.isQRValidated ? null : Colors.yellow[100])
                            : const Color.fromARGB(255, 230, 244, 232),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            '${block.nodeTypeString}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: block.isPopulated
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: block.nodeData.entries
                                      .map((entry) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2.0),
                                            child: Text(
                                              '${entry.key}: ${entry.value}',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ))
                                      .toList(),
                                )
                              : const Text(
                                  'Not yet populated',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                  ),
                                ),
                          onTap: _handleNodeTap(block, index),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _startTracking() {
    // If no nodes are populated, start from the beginning
    if (supplyChain.every((block) => !block.isPopulated)) {
      setState(() {
        currentNodeType = NodeType.Farmer;
      });
      _showNodeInputDialog(context);
    } else {
      // Find the first unpopulated node
      final nextUnpopulatedIndex =
          supplyChain.indexWhere((block) => !block.isPopulated);
      if (nextUnpopulatedIndex != -1) {
        setState(() {
          currentNodeType = supplyChain[nextUnpopulatedIndex].nodeType;
        });
        _showNodeInputDialog(context);
      }
    }
  }

  VoidCallback? _handleNodeTap(SupplyChainBlock block, int index) {
    if (block.isPopulated) {
      return () {
        // If the previous node is validated or this is the first node
        if (index == 0 || supplyChain[index - 1].isQRValidated) {
          _showQRDialog(block);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please validate previous node first')),
          );
        }
      };
    } else {
      return () {
        // If the previous node is validated or this is the first node
        if (index == 0 || supplyChain[index - 1].isQRValidated) {
          setState(() {
            currentNodeType = block.nodeType;
          });
          _showNodeInputDialog(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please validate previous node first')),
          );
        }
      };
    }
  }

  void _showQRDialog(SupplyChainBlock block) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('${block.nodeTypeString} QR Code Validation'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: QrImageView(
                      data: block.qrData,
                      version: QrVersions.auto,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: block.isQRValidated
                        ? null
                        : () {
                            // Update the block's validation status
                            setState(() {
                              final blockIndex = supplyChain.indexOf(block);
                              supplyChain[blockIndex].isQRValidated = true;
                            });

                            // Update the entire widget
                            this.setState(() {});
                          },
                    child: Text(block.isQRValidated ? 'Validated' : 'Validate'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => {
                      // createNewBatch(),
                      Navigator.of(context).pop(),
                    },
                    child: Text('Close'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _addSupplyChainBlock(Map<String, dynamic> nodeData) {
    // Find the first block of the current node type and update it
    final blockIndex = supplyChain.indexWhere(
        (block) => block.nodeType == currentNodeType && !block.isPopulated);

    if (blockIndex != -1) {
      setState(() {
        supplyChain[blockIndex].nodeData = nodeData;
        supplyChain[blockIndex].isPopulated = true;
        supplyChain[blockIndex].validationTimestamp =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      });
    }
  }

  void _showNodeInputDialog(BuildContext context) {
    if (currentNodeType == null) return;

    final formKey = GlobalKey<FormState>();
    Map<String, dynamic> nodeData = {};

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Add ${currentNodeType.toString().split('.').last} Block'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _buildNodeSpecificFields(currentNodeType!, nodeData),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            child: Text('Save'),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                createNewBatch();
                Navigator.of(context).pop(); // Close the current dialog
                _addSupplyChainBlock(nodeData);
              }
            },
          ),
        ],
      ),
    );
  }

  // Reuse the previous _buildNodeSpecificFields method here
  List<Widget> _buildNodeSpecificFields(
      NodeType nodeType, Map<String, dynamic> nodeData) {
    switch (nodeType) {
      case NodeType.Farmer:
        return [
          TextFormField(
            decoration: InputDecoration(labelText: 'Farmer ID/Name/Phone'),
            validator: (value) =>
                value!.isEmpty ? 'Please enter Farmer ID' : null,
            onSaved: (value) => nodeData['farmerId'] = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Crop Type'),
            validator: (value) =>
                value!.isEmpty ? 'Please enter Crop Type' : null,
            onSaved: (value) => nodeData['cropType'] = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Crop Quantity'),
            keyboardType: TextInputType.number,
            validator: (value) =>
                value!.isEmpty ? 'Please enter Quantity' : null,
            onSaved: (value) => nodeData['quantity'] = double.parse(value!),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Harvest Date'),
            keyboardType: TextInputType.datetime,
            validator: (value) =>
                value!.isEmpty ? 'Please enter Harvest Date' : null,
            onSaved: (value) => nodeData['harvestDate'] = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Location (Village/Town)'),
            validator: (value) =>
                value!.isEmpty ? 'Please enter Location' : null,
            onSaved: (value) => nodeData['location'] = value,
          ),
        ];

      case NodeType.LocalAggregator:
        return [
          TextFormField(
            decoration: InputDecoration(labelText: 'Aggregator ID/Name/Phone'),
            validator: (value) =>
                value!.isEmpty ? 'Please enter Aggregator ID' : null,
            onSaved: (value) => nodeData['aggregatorId'] = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Collection Date'),
            keyboardType: TextInputType.datetime,
            validator: (value) =>
                value!.isEmpty ? 'Please enter Collection Date' : null,
            onSaved: (value) => nodeData['collectionDate'] = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Collection Quantity'),
            keyboardType: TextInputType.number,
            validator: (value) =>
                value!.isEmpty ? 'Please enter Quantity' : null,
            onSaved: (value) =>
                nodeData['collectionQuantity'] = double.parse(value!),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Storage Notes'),
            onSaved: (value) => nodeData['storageNotes'] = value ?? '',
          ),
        ];

      case NodeType.Transporter:
        return [
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Transporter ID/Vehicle Registration'),
            validator: (value) =>
                value!.isEmpty ? 'Please enter Transporter ID' : null,
            onSaved: (value) => nodeData['transporterId'] = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Start Location'),
            validator: (value) =>
                value!.isEmpty ? 'Please enter Start Location' : null,
            onSaved: (value) => nodeData['startLocation'] = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'End Location'),
            validator: (value) =>
                value!.isEmpty ? 'Please enter End Location' : null,
            onSaved: (value) => nodeData['endLocation'] = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Delivery Date/Time'),
            keyboardType: TextInputType.datetime,
            validator: (value) =>
                value!.isEmpty ? 'Please enter Delivery Date/Time' : null,
            onSaved: (value) => nodeData['deliveryDateTime'] = value,
          ),
        ];

      case NodeType.Retailer:
        return [
          TextFormField(
            decoration: InputDecoration(labelText: 'Retailer ID'),
            validator: (value) =>
                value!.isEmpty ? 'Please enter Retailer ID' : null,
            onSaved: (value) => nodeData['retailerId'] = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Date Received'),
            keyboardType: TextInputType.datetime,
            validator: (value) =>
                value!.isEmpty ? 'Please enter Date Received' : null,
            onSaved: (value) => nodeData['dateReceived'] = value,
          ),
        ];

      case NodeType.Consumer:
        return [
          TextFormField(
            decoration: InputDecoration(labelText: 'Feedback (Optional)'),
            onSaved: (value) => nodeData['feedback'] = value ?? '',
          ),
        ];
    }
  }
}
