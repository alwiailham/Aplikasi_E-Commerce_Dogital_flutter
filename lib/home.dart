import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> products = [
    {
      'image': 'assets/images/product1.png',
      'name': 'Produk 1',
      'price': 'Rp25.000',
      'discount': 10
    },
    {
      'image': 'assets/images/product2.png',
      'name': 'Produk 2',
      'price': 'Rp50.000',
      'discount': 0
    },
    {
      'image': 'assets/images/product3.png',
      'name': 'Produk 3',
      'price': 'Rp75.000',
      'discount': 5
    },
    {
      'image': 'assets/images/product4.png',
      'name': 'Produk 4',
      'price': 'Rp75.000',
      'discount': 5
    },
    {
      'image': 'assets/images/product5.png',
      'name': 'Produk 5',
      'price': 'Rp75.000',
      'discount': 5
    },
    {
      'image': 'assets/images/product6.png',
      'name': 'Produk 3',
      'price': 'Rp75.000',
      'discount': 5
    },
    {
      'image': 'assets/images/product6.png',
      'name': 'Produk 3',
      'price': 'Rp75.000',
      'discount': 5
    },
    {
      'image': 'assets/images/product4.png',
      'name': 'Produk 3',
      'price': 'Rp75.000',
      'discount': 5
    },
    {
      'image': 'assets/images/product5.png',
      'name': 'Produk 3',
      'price': 'Rp75.000',
      'discount': 5
    },
    {
      'image': 'assets/images/product2.png',
      'name': 'Produk 3',
      'price': 'Rp75.000',
      'discount': 5
    },
    {
      'image': 'assets/images/product6.png',
      'name': 'Produk 3',
      'price': 'Rp75.000',
      'discount': 5
    },
    {
      'image': 'assets/images/product1.png',
      'name': 'Produk 3',
      'price': 'Rp75.000',
      'discount': 5
    },
  ];

  void _addProduct() {
    setState(() {
      products.add({
        'image': 'assets/images/product_placeholder.png',
        'name': 'Produk Baru',
        'price': 'Rp100.000',
        'discount': 0,
      });
    });
  }

  void _editProduct(int index) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController nameController =
            TextEditingController(text: products[index]['name']);
        final TextEditingController priceController =
            TextEditingController(text: products[index]['price']);
        final TextEditingController discountController =
            TextEditingController(text: products[index]['discount'].toString());

        return AlertDialog(
          title: const Text('Edit Produk'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Harga Produk'),
              ),
              TextField(
                controller: discountController,
                decoration: const InputDecoration(labelText: 'Diskon (%)'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  products[index]['name'] = nameController.text;
                  products[index]['price'] = priceController.text;
                  products[index]['discount'] =
                      int.parse(discountController.text);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            hintText: 'Kesempatan terakhir: Diskon...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addProduct,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () => _editProduct(index),
                    child: _productCard(
                      products[index]['image'],
                      products[index]['name'],
                      products[index]['price'],
                      products[index]['discount'],
                      () => _deleteProduct(index),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Trending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifikasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
    );
  }

  Widget _productCard(String imagePath, String name, String price, int discount,
      VoidCallback onDelete) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.asset(
                  imagePath,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (discount > 0)
                      Text(
                        '-$discount%',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ),
        ],
      ),
    );
  }
}
