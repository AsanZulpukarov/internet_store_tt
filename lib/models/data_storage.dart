import 'product_model.dart';

class DataStorage {
  static final DataStorage _instance = DataStorage._internal();

  List<Product> products = [
    Product(
      name: 'Xiaomi Redmi 12 8+128Gb',
      description: 'Мощный смартфон с отличной камерой.',
      price: 15000,
      urlImage: 'https://www.myphone.kg/files/media/20/20883.webp',
    ),
    Product(
        name: 'Ноутбук Dell XPS 13',
        description:
            'Легкий и производительный ноутбук для работы и развлечений.',
        price: 120000,
        urlImage:
            'https://avatars.mds.yandex.net/get-mpic/4362548/img_id1555423894575553672.jpeg/orig'),
    Product(
      name: 'Наушники Sony WH-1000XM4',
      description: 'Отличные беспроводные наушники с активным шумоподавлением.',
      price: 24999,
      urlImage: 'https://gamestore.kg/wp-content/uploads/wh100xm4-1.jpg',
    ),
    Product(
      name: 'Xiaomi Redmi 12 8+128Gb',
      description: 'Мощный смартфон с отличной камерой.',
      price: 15000,
      urlImage: 'https://www.myphone.kg/files/media/20/20883.webp',
    ),
    Product(
        name: 'Ноутбук Dell XPS 13',
        description:
            'Легкий и производительный ноутбук для работы и развлечений.',
        price: 120000,
        urlImage:
            'https://avatars.mds.yandex.net/get-mpic/4362548/img_id1555423894575553672.jpeg/orig'),
    Product(
      name: 'Наушники Sony WH-1000XM4',
      description: 'Отличные беспроводные наушники с активным шумоподавлением.',
      price: 24999,
      urlImage: 'https://gamestore.kg/wp-content/uploads/wh100xm4-1.jpg',
    ),
    Product(
      name: 'Xiaomi Redmi 12 8+128Gb',
      description: 'Мощный смартфон с отличной камерой.',
      price: 15000,
      urlImage: 'https://www.myphone.kg/files/media/20/20883.webp',
    ),
    Product(
        name: 'Ноутбук Dell XPS 13',
        description:
            'Легкий и производительный ноутбук для работы и развлечений.',
        price: 120000,
        urlImage:
            'https://avatars.mds.yandex.net/get-mpic/4362548/img_id1555423894575553672.jpeg/orig'),
    Product(
      name: 'Наушники Sony WH-1000XM4',
      description: 'Отличные беспроводные наушники с активным шумоподавлением.',
      price: 24999,
      urlImage: 'https://gamestore.kg/wp-content/uploads/wh100xm4-1.jpg',
    ),
  ];

  List<int> buyProductsIndex = [];

  factory DataStorage() {
    return _instance;
  }

  DataStorage._internal();
}
