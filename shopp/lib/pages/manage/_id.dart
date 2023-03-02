import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/product.provider.dart';
import 'package:shopp/providers/products.provider.dart';
import 'package:shopp/widgets/common/app_drawer.dart';

class PageEditProducts extends StatefulWidget {
  static const route = '/manage/product/_id';

  const PageEditProducts({super.key});

  @override
  State<PageEditProducts> createState() => _PageEditProductsState();
}

class EditProductFormData {
  String? id;
  String? _title;
  String? _description;
  double? _price;
  String? _image;
  bool? _isFavorite;

  String? get title {
    return _title;
  }

  EditProductFormData() {
    id = _title = _description = _image = '';
    _price = 0;
    _isFavorite = false;
  }

  EditProductFormData.fromProduct(Product product) {
    id = product.id;
    _title = product.title;
    _description = product.description;
    _price = product.price;
    _image = product.image;
    _isFavorite = product.isFavorite;
  }

  set title(String? title) {
    if (validateTitle(title) == null) {
      _title = title;
    }
  }

  String? get description {
    return _description;
  }

  set description(String? description) {
    if (validateDescription(description) == null) {
      _description = description;
    }
  }

  double? get price {
    return _price;
  }

  set price(double? price) {
    if (price != null && price > 0) {
      _price = price;
    }
  }

  String? get image {
    return _image;
  }

  set image(String? image) {
    if (validateImage(image) == null) {
      _image = image;
    }
  }

  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description';
    }
    if (value.length < 10) {
      return 'Minimum 10 characters';
    }
    return null;
  }

  String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    final parsedValue = double.tryParse(value);
    if (parsedValue == null) {
      return 'Please enter a valid number';
    }
    if (parsedValue <= 0) {
      return 'Please enter a number greater than zero';
    }
    return null;
  }

  String? validateImage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an image url';
    }
    if (!value.startsWith(RegExp('^https?://'))) {
      return 'Please enter a valid image url';
    }
    return null;
  }

  Product toProduct() {
    return Product(
      id: '',
      title: title ?? '',
      description: description ?? '',
      price: price ?? 0,
      image: image ?? '',
      isFavorite: _isFavorite ?? false,
    );
  }
}

class _PageEditProductsState extends State<PageEditProducts> {
  final _imageUrlEditController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  EditProductFormData _formData = EditProductFormData();
  bool _isInit = true;
  bool _isEditMode = false;

  String get imageUrl {
    return _imageUrlEditController.text;
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments;
      if (productId != null) {
        final product = Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId as String);
        _formData = EditProductFormData.fromProduct(product);
        _imageUrlEditController.text = _formData.image as String;
        _isEditMode = true;
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlEditController.dispose();
    _imageUrlEditController.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
              key: _form,
              child: ListView(
                children: [
                  TextFormField(
                    initialValue: _formData.title,
                    decoration: const InputDecoration(labelText: 'Title'),
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    validator: _formData.validateTitle,
                    onSaved: (newValue) {
                      _formData.title = newValue;
                    },
                  ),
                  TextFormField(
                    initialValue: _formData.price.toString(),
                    decoration: const InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: _formData.validatePrice,
                    onSaved: (newValue) {
                      if (newValue == null) {
                        return;
                      }
                      _formData.price = double.tryParse(newValue);
                    },
                  ),
                  TextFormField(
                    initialValue: _formData.description,
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    validator: _formData.validateDescription,
                    onSaved: (newValue) {
                      _formData.description = newValue;
                    },
                  ),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: imageUrl.isEmpty
                            ? const Text('Enter an URL')
                            : FittedBox(
                                // fit: BoxFit.cover,
                                child: Image.network(imageUrl),
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlEditController,
                          focusNode: _imageUrlFocusNode,
                          onFieldSubmitted: (_) => _submitForm(),
                          onEditingComplete: (() {
                            setState(() {
                              // Force update state
                            });
                          }),
                          validator: _formData.validateImage,
                          onSaved: (newValue) {
                            _formData.image = newValue;
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () {
                          _submitForm();
                        },
                      ))
                ],
              ))),
    );
  }

  void _submitForm() {
    final currentState = _form.currentState;
    final isValid = currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    _form.currentState?.save();
    if (_isEditMode) {
      Provider.of<ProductsProvider>(context, listen: false)
          .update(_formData.id as String, _formData.toProduct());
    } else {
      Provider.of<ProductsProvider>(context, listen: false)
          .add(_formData.toProduct());
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Saved')));
  }

  void _updateImageUrl() {
    final value = _imageUrlEditController.text;
    if (_formData.validateImage(value) != null) {
      return;
    }
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {
        // Force update state
      });
    }
  }
}
