import 'package:flutter/material.dart';
import 'package:internet_store_tt/db/database.dart';

import '../methods.dart';
import '../models/product_model.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;
  late final TextEditingController _urlController;

  final TextStyle styleFormText = const TextStyle(color: Colors.white);

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.product.name);
    _descriptionController =
        TextEditingController(text: widget.product.description);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
    _urlController = TextEditingController(text: widget.product.urlImage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                style: styleFormText,
                decoration: const InputDecoration(
                  labelText: 'Название товара',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Пожалуйста, введите название товара';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nameController.text = value!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _descriptionController,
                style: styleFormText,
                decoration: const InputDecoration(
                  labelText: 'Описание товара',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Пожалуйста, введите описание товара';
                  }
                  return null;
                },
                maxLines: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _priceController,
                style: styleFormText,
                decoration: const InputDecoration(
                  labelText: 'Цена',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Пожалуйста, введите цену товара';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Пожалуйста, введите корректное число';
                  }
                  return null;
                },
                onSaved: (value) {
                  _priceController.text = value!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _urlController,
                style: styleFormText,
                decoration:
                    const InputDecoration(labelText: 'Ссылка на фото товара'),
                validator: (value) {
                  if (value!.isNotEmpty && !isValidPhotoUrl(value)) {
                    return 'Пожалуйста, введите корректный URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  _urlController.text = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.product.name = _nameController.value.text;
                    widget.product.description =
                        _descriptionController.value.text;
                    widget.product.price =
                        int.parse(_priceController.value.text);
                    widget.product.urlImage = _urlController.value.text;

                    DBProvider.db.updateProduct(widget.product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Данные изменены!"),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Изменить данные товара'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
