import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<DiscoveryScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('products').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: Get.height / 5,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No category found!"),
            );
          }

          if (snapshot.data != null) {
            return GroupedListView<dynamic, String>(
              elements: snapshot.data!.docs,
              groupBy: (element) => element['productId'],
              groupSeparatorBuilder: (String groupByValue) =>
                  const Divider(indent: 20, endIndent: 20),
              itemBuilder: (context, dynamic element) {
                DateTime createdAt = element['createdAt'].toDate();
                Duration difference = DateTime.now().difference(createdAt);
                String timeDisplay;

                if (difference.inHours < 24) {
                  // Show hours if less than a day
                  timeDisplay = '${difference.inHours}h ago';
                } else {
                  // Show days if more than a day
                  timeDisplay = '${difference.inDays}d ago';
                }

                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Row(
                    children: [
                      Image.network(
                        element['productImages'][0].toString(),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              element['productName'],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Price: ${element['salePrice']}',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10), // Space between text and date
                      // Right: Created date
                      Column(
                        children: [
                          Text(
                            timeDisplay,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                          const Icon(
                            Icons.add_circle,
                            color: Colors.orange,
                            size: 35,
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
              useStickyGroupSeparators: true,
              floatingHeader: true,
              order: GroupedListOrder.ASC,
              // footer: const Text("Widget at the bottom of list"),
            );
          }
          return Container();
        },
      ),
    );
  }
}
