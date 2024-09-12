// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class PostProductsScreen extends StatefulWidget {
//   const PostProductsScreen({super.key});

//   @override
//   _ProductFormState createState() => _ProductFormState();
// }

// class _ProductFormState extends State<PostProductsScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _productIdController = TextEditingController();
//   final _categoryIdController = TextEditingController();
//   final _productNameController = TextEditingController();
//   final _categoryNameController = TextEditingController();
//   final _salePriceController = TextEditingController();
//   final _fullPriceController = TextEditingController();
//   final _deliveryTimeController = TextEditingController();
//   final _productDescriptionController = TextEditingController();
//   final _productImagesController = TextEditingController();
//   bool _isSale = false;

//   Future<void> _uploadData() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         await FirebaseFirestore.instance.collection('products').add({
//           'productId': _productIdController.text,
//           'categoryId': _categoryIdController.text,
//           'productName': _productNameController.text,
//           'categoryName': _categoryNameController.text,
//           'salePrice': _salePriceController.text,
//           'fullPrice': _fullPriceController.text,
//           'productImages': _productImagesController.text
//               .split(',')
//               .map((e) => e.trim())
//               .toList(),
//           'deliveryTime': _deliveryTimeController.text,
//           'isSale': _isSale,
//           'productDescription': _productDescriptionController.text,
//           'createdAt': FieldValue.serverTimestamp(),
//           'updatedAt': FieldValue.serverTimestamp(),
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Product uploaded successfully!')),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to upload product: $e')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Product'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _productIdController,
//                 decoration: InputDecoration(labelText: 'Product ID'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a product ID';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _categoryIdController,
//                 decoration: InputDecoration(labelText: 'Category ID'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a category ID';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _productNameController,
//                 decoration: InputDecoration(labelText: 'Product Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a product name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _categoryNameController,
//                 decoration: InputDecoration(labelText: 'Category Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a category name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _salePriceController,
//                 decoration: InputDecoration(labelText: 'Sale Price'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a sale price';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _fullPriceController,
//                 decoration: InputDecoration(labelText: 'Full Price'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a full price';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _productImagesController,
//                 decoration: InputDecoration(
//                     labelText: 'Product Images (comma separated URLs)'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter product image URLs';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _deliveryTimeController,
//                 decoration: InputDecoration(labelText: 'Delivery Time'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter delivery time';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _productDescriptionController,
//                 decoration: InputDecoration(labelText: 'Product Description'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a product description';
//                   }
//                   return null;
//                 },
//               ),
//               SwitchListTile(
//                 title: Text('Is Sale'),
//                 value: _isSale,
//                 onChanged: (bool value) {
//                   setState(() {
//                     _isSale = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _uploadData,
//                 child: Text('Upload Product'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class PostProductsScreen extends StatefulWidget {
  const PostProductsScreen({super.key});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<PostProductsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productIdController = TextEditingController();
  final _categoryIdController = TextEditingController();
  final _productNameController = TextEditingController();
  final _categoryNameController = TextEditingController();
  final _salePriceController = TextEditingController();
  final _fullPriceController = TextEditingController();
  final _deliveryTimeController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productImagesController = TextEditingController();
  bool _isSale = false;
  final ImagePicker _picker = ImagePicker();
  List<File> _productImages = [];

  Future<void> _uploadData() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Convert file paths to URLs or use Firebase Storage to upload and get URLs
        // Placeholder implementation for Firebase Storage upload:
        List<String> imageUrls =
            _productImages.map((file) => file.path).toList();

        await FirebaseFirestore.instance.collection('products').add({
          'productId': _productIdController.text,
          'categoryId': _categoryIdController.text,
          'productName': _productNameController.text,
          'categoryName': _categoryNameController.text,
          'salePrice': _salePriceController.text,
          'fullPrice': _fullPriceController.text,
          // 'productImages': imageUrls,
          'deliveryTime': _deliveryTimeController.text,
          'isSale': _isSale,
          'productDescription': _productDescriptionController.text,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'productImages': _productImagesController.text
              .split(',')
              .map((e) => e.trim())
              .toList(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product uploaded successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload product: $e')),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _productImages.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                key: const ValueKey("product_id"),
                controller: _productIdController,
                decoration: const InputDecoration(
                  labelText: 'Product ID',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey("category_id"),
                controller: _categoryIdController,
                decoration: const InputDecoration(labelText: 'Category ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey("product_name"),
                controller: _productNameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey("country_name"),
                controller: _categoryNameController,
                decoration: const InputDecoration(labelText: 'Category Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category name';
                  }
                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey("sale_price"),
                controller: _salePriceController,
                decoration: const InputDecoration(labelText: 'Sale Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a sale price';
                  }
                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey("full_price"),
                controller: _fullPriceController,
                decoration: const InputDecoration(labelText: 'Full Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a full price';
                  }
                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey("delivery_time"),
                controller: _deliveryTimeController,
                decoration: const InputDecoration(labelText: 'Delivery Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter delivery time';
                  }
                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey("product_description"),
                controller: _productDescriptionController,
                decoration:
                    const InputDecoration(labelText: 'Product Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product description';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: const Text('Is Sale'),
                value: _isSale,
                onChanged: (bool value) {
                  setState(() {
                    _isSale = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image from Gallery'),
              ),
              const SizedBox(height: 10),
              _productImages.isNotEmpty
                  ? Wrap(
                      spacing: 10,
                      children: _productImages
                          .map((image) => Image.file(
                                image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ))
                          .toList(),
                    )
                  : const Text('No images selected'),
              const SizedBox(height: 20),
              TextFormField(
                key: const ValueKey("product_image"),
                controller: _productImagesController,
                decoration: const InputDecoration(
                    labelText: 'Product Images (comma separated URLs)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product image URLs';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _uploadData,
                child: const Text('Upload Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
