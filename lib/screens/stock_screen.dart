// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'stock.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final _stockBox = Hive.box<Stock>('stocks');
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _cmpController = TextEditingController();
  final _yearHighController = TextEditingController();
  final _yearLowController = TextEditingController();
  final _diiController = TextEditingController();
  final _fiiController = TextEditingController();
  final _notesController = TextEditingController();
  final _searchController = TextEditingController();

  // Create FocusNodes for each TextField
  final _nameFocusNode = FocusNode();
  final _cmpFocusNode = FocusNode();
  final _yearHighFocusNode = FocusNode();
  final _yearLowFocusNode = FocusNode();
  final _diiFocusNode = FocusNode();
  final _fiiFocusNode = FocusNode();
  final _notesFocusNode = FocusNode();

  List<Stock> _filteredStocks = [];
  Stock? _selectedStock;

  @override
  void initState() {
    super.initState();
    _filteredStocks = _stockBox.values.toList();
    _searchController.addListener(_searchStocks);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cmpController.dispose();
    _yearHighController.dispose();
    _yearLowController.dispose();
    _diiController.dispose();
    _fiiController.dispose();
    _notesController.dispose();
    _searchController.dispose();

    // Dispose FocusNodes
    _nameFocusNode.dispose();
    _cmpFocusNode.dispose();
    _yearHighFocusNode.dispose();
    _yearLowFocusNode.dispose();
    _diiFocusNode.dispose();
    _fiiFocusNode.dispose();
    _notesFocusNode.dispose();

    super.dispose();
  }

  // Function to filter stocks based on search input
  void _searchStocks() {
    setState(() {
      _filteredStocks = _stockBox.values
          .where((stock) => stock.name
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  // Save stock data to Hive
  void _saveStock() {
    if (_formKey.currentState!.validate()) {
      final stock = Stock(
        name: _nameController.text,
        cmp: double.parse(_cmpController.text),
        yearHigh: double.parse(_yearHighController.text),
        yearLow: double.parse(_yearLowController.text),
        diiParticipation: double.parse(_diiController.text),
        fiiParticipation: double.parse(_fiiController.text),
        notes: _notesController.text,
        dateTime: DateTime.now(),
      );
      if (_selectedStock == null) {
        _stockBox.add(stock); // Add new stock
      } else {
        _selectedStock!.name = stock.name;
        _selectedStock!.cmp = stock.cmp;
        _selectedStock!.yearHigh = stock.yearHigh;
        _selectedStock!.yearLow = stock.yearLow;
        _selectedStock!.diiParticipation = stock.diiParticipation;
        _selectedStock!.fiiParticipation = stock.fiiParticipation;
        _selectedStock!.notes = stock.notes;
        _selectedStock!.dateTime = DateTime.now();
        _selectedStock!.save(); // Update existing stock
      }
      _clearFields();
      _searchStocks(); // Update search results after saving
    }
  }

  // Clear input fields
  void _clearFields() {
    _nameController.clear();
    _cmpController.clear();
    _yearHighController.clear();
    _yearLowController.clear();
    _diiController.clear();
    _fiiController.clear();
    _notesController.clear();
    _selectedStock = null; // Clear selected stock
  }

  // Format date and time for display
  String _formatDate(DateTime date) {
    return DateFormat('dd-MM-yy, hh:mm:ss a').format(date);
  }

  // Focus to the next field after the current one is submitted
  void _nextFocus(FocusNode currentFocusNode, FocusNode nextFocusNode) {
    currentFocusNode.unfocus(); // Remove focus from current field
    FocusScope.of(context)
        .requestFocus(nextFocusNode); // Move focus to the next field
  }

  // Delete stock from Hive
  void _deleteStock(Stock stock) {
    _stockBox.delete(stock.key); // Delete the stock by its key
    _searchStocks(); // Update search results after deleting
  }

  // Edit stock, populate fields
  void _editStock(Stock stock) {
    _nameController.text = stock.name;
    _cmpController.text = stock.cmp.toString();
    _yearHighController.text = stock.yearHigh.toString();
    _yearLowController.text = stock.yearLow.toString();
    _diiController.text = stock.diiParticipation.toString();
    _fiiController.text = stock.fiiParticipation.toString();
    _notesController.text = stock.notes;
    _selectedStock = stock; // Set the selected stock for updating
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Stock Tracker by Vipin",
          style: TextStyle(fontSize: 18, color: Colors.brown[200]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                _nameController,
                'Stock Name',
                focusNode: _nameFocusNode,
                nextFocusNode: _cmpFocusNode,
              ),
              _buildTextField(
                _cmpController,
                'CMP',
                isNumber: true,
                focusNode: _cmpFocusNode,
                nextFocusNode: _yearHighFocusNode,
              ),
              _buildTextField(
                _yearHighController,
                'Year High',
                isNumber: true,
                focusNode: _yearHighFocusNode,
                nextFocusNode: _yearLowFocusNode,
              ),
              _buildTextField(
                _yearLowController,
                'Year Low',
                isNumber: true,
                focusNode: _yearLowFocusNode,
                nextFocusNode: _diiFocusNode,
              ),
              _buildTextField(
                _diiController,
                '% DII Participation',
                isNumber: true,
                focusNode: _diiFocusNode,
                nextFocusNode: _fiiFocusNode,
              ),
              _buildTextField(
                _fiiController,
                '% FII Participation',
                isNumber: true,
                focusNode: _fiiFocusNode,
                nextFocusNode: _notesFocusNode,
              ),
              _buildTextField(
                _notesController,
                'Notes on Demand/Supply Zone',
                maxLines: 3,
                focusNode: _notesFocusNode,
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MaterialButton(
                  height: 48,
                  color: Colors.brown,
                  onPressed: _saveStock,
                  child: const Text('Save Stock'),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        _searchController.clear();
                      },
                      icon: const Icon(Icons.clear)),
                  hintText: 'Search Stock by Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.brown)),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text("Saved Stocks : ${_filteredStocks.length}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[200])),
                  ),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: _stockBox.listenable(),
                builder: (context, Box<Stock> box, _) {
                  if (_filteredStocks.isEmpty) {
                    return const Text("No stocks match your search.");
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: _filteredStocks.map((stock) {
                        return Card(
                          color: Theme.of(context).cardColor,
                          child: ListTile(
                            title: Text(
                              stock.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "CMP: ${stock.cmp}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                                Text(
                                    "Year High/Low: ${stock.yearHigh} / ${stock.yearLow}"),
                                Text(
                                    "DII/FII: ${stock.diiParticipation}% ${stock.fiiParticipation}"),
                                Text("Notes: ${stock.notes}"),
                                Text("Added: ${_formatDate(stock.dateTime)}"),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () =>
                                      _editStock(stock), // Edit stock
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () =>
                                      _deleteStock(stock), // Delete stock
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isNumber = false,
    int maxLines = 1,
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: label,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.brown.shade400),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.brown.shade700),
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear(); // Clears the text field content
                    setState(() {}); // Rebuild to hide the clear button
                  },
                )
              : null, // Show clear icon only if text is not empty
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $label';
          }
          if (isNumber && double.tryParse(value) == null) {
            return '$label must be a valid number';
          }
          return null;
        },
        onFieldSubmitted: (_) {
          if (nextFocusNode != null) {
            _nextFocus(focusNode!, nextFocusNode);
          } else {
            FocusScope.of(context)
                .unfocus(); // Remove focus when last field is submitted
          }
        },
        onChanged: (value) {
          // Trigger rebuild when text changes so suffix icon shows/hides
          setState(() {});
        },
      ),
    );
  }
}
