import 'package:flutter/material.dart';

import '../methods.dart';
import '../models/data_storage.dart';

class EditProductScreen extends StatefulWidget {
  final int index;
  const EditProductScreen({super.key, required this.index});

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
    _nameController =
        TextEditingController(text: DataStorage().products[widget.index].name);
    _descriptionController = TextEditingController(
        text: DataStorage().products[widget.index].description);
    _priceController = TextEditingController(
        text: DataStorage().products[widget.index].price.toString());
    _urlController = TextEditingController(
        text: DataStorage().products[widget.index].urlImage);
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
                onSaved: (value) {
                  _descriptionController.text = value!;
                },
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
                    DataStorage().products[widget.index].name =
                        _nameController.value.text;
                    DataStorage().products[widget.index].description =
                        _descriptionController.value.text;
                    DataStorage().products[widget.index].price =
                        int.parse(_priceController.value.text);
                    DataStorage().products[widget.index].urlImage =
                        _urlController.value.text;
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
