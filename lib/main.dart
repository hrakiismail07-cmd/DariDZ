import 'package:flutter/material.dart';

void main() {
  runApp(const DariDZApp());
}

class DariDZApp extends StatelessWidget {
  const DariDZApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DariDZ',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DariDZ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ابحث عن منزلك في الجزائر',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                hintText: 'المدينة أو المنطقة',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'العقارات المتاحة',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView(
                children: const [
                  PropertyCard(
                    title: 'شقة جميلة',
                    location: 'قسنطينة',
                    price: '35,000 دج / شهر',
                    icon: Icons.home,
                  ),
                  PropertyCard(
                    title: 'شقة مفروشة',
                    location: 'الجزائر العاصمة',
                    price: '50,000 دج / شهر',
                    icon: Icons.apartment,
                  ),
                  PropertyCard(
                    title: 'منزل عائلي',
                    location: 'وهران',
                    price: '45,000 دج / شهر',
                    icon: Icons.house,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('إضافة عقار'),
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final String title;
  final String location;
  final String price;
  final IconData icon;

  const PropertyCard({
    super.key,
    required this.title,
    required this.location,
    required this.price,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          child: Icon(icon, size: 30),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('$location\n$price'),
        isThreeLine: true,
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PropertyDetailsPage(
                title: title,
                location: location,
                price: price,
                icon: icon,
              ),
            ),
          );
        },
      ),
    );
  }
}

class PropertyDetailsPage extends StatelessWidget {
  final String title;
  final String location;
  final String price;
  final IconData icon;

  const PropertyDetailsPage({
    super.key,
    required this.title,
    required this.location,
    required this.price,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل العقار'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 55,
                child: Icon(icon, size: 55),
              ),
              const SizedBox(height: 25),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '📍 $location',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 15),
              Text(
                '💰 $price',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'هذا العقار متاح للإيجار. يمكنك التواصل مع صاحب العقار للحصول على المزيد من المعلومات.',
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
