import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Content extends StatefulWidget {
  @override
  ContentState createState() {
    return ContentState();
  }
}

class ContentState extends State<Content> {
  String _result = "---";

  Future<void> _getMessage() async {
    final endPoint = Uri.parse("http://localhost:9081/api/v1/hello");

    try {
      final response = await http.get(endPoint);
      setState(() {
        _result = jsonDecode(response.body)['data'];
      });
    } catch (e) {
      setState(() {
        _result = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_result),
          ElevatedButton(
            onPressed: _getMessage,
            child: const Text("get greeting"),
          ),
        ],
      ),
    );
  }
}
