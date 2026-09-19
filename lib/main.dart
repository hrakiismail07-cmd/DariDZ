import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
        fontFamily: 'Arial',
      ),
      home: const HomePage(),
    );
  }
}

class Property {
  final String title;
  final String location;
  final String price;
  final int rooms;
  final double area;
  final String description;
  final String phone;
  final IconData icon;
  final List<String> images;

  const Property({
    required this.title,
    required this.location,
    required this.price,
    required this.rooms,
    required this.area,
    required this.description,
    required this.phone,
    required this.icon,
    required this.images,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  int selectedRooms = 0;

  final List<Property> properties = const [
    Property(
      title: 'شقة جميلة',
      location: 'قسنطينة',
      price: '35,000 دج / شهر',
      rooms: 3,
      area: 95,
      description:
          'شقة جميلة ومريحة مناسبة للعائلات، تقع في منطقة هادئة وقريبة من الخدمات والمواصلات.',
      phone: '0550000000',
      icon: Icons.home,
      images: [
        'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267',
        'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85',
        'https://images.unsplash.com/photo-1560185008-b033106af5c3',
      ],
    ),
    Property(
      title: 'شقة مفروشة',
      location: 'الجزائر العاصمة',
      price: '50,000 دج / شهر',
      rooms: 2,
      area: 75,
      description:
          'شقة مفروشة وجاهزة للسكن، تحتوي على أثاث وتجهيزات أساسية.',
      phone: '0550000000',
      icon: Icons.apartment,
      images: [
        'https://images.unsplash.com/photo-1554995207-c18c203602cb',
        'https://images.unsplash.com/photo-1493809842364-78817add7ffb',
      ],
    ),
    Property(
      title: 'منزل عائلي',
      location: 'وهران',
      price: '45,000 دج / شهر',
      rooms: 4,
      area: 140,
      description:
          'منزل عائلي واسع يحتوي على عدة غرف ومساحة مناسبة للعائلة.',
      phone: '0550000000',
      icon: Icons.house,
      images: [
        'https://images.unsplash.com/photo-1564013799919-ab600027ffc6',
        'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c',
      ],
    ),
  ];

  List<Property> get filteredProperties {
    final search = searchController.text.trim().toLowerCase();

    return properties.where((property) {
      final matchesSearch =
          property.title.toLowerCase().contains(search) ||
          property.location.toLowerCase().contains(search);

      final matchesRooms =
          selectedRooms == 0 || property.rooms == selectedRooms;

      return matchesSearch && matchesRooms;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'ابحث عن منزلك في الجزائر 🏠',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                controller: searchController,
                onChanged: (_) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'المدينة أو المنطقة',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            setState(() {});
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  const Text(
                    'عدد الغرف:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: selectedRooms,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 0,
                          child: Text('الكل'),
                        ),
                        DropdownMenuItem(
                          value: 1,
                          child: Text('غرفة واحدة'),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text('غرفتان'),
                        ),
                        DropdownMenuItem(
                          value: 3,
                          child: Text('3 غرف'),
                        ),
                        DropdownMenuItem(
                          value: 4,
                          child: Text('4 غرف'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedRooms = value ?? 0;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              const Text(
                'العقارات المتاحة',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: filteredProperties.isEmpty
                    ? const Center(
                        child: Text(
                          'لم يتم العثور على عقارات',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredProperties.length,
                        itemBuilder: (context, index) {
                          final property = filteredProperties[index];

                          return PropertyCard(
                            property: property,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const AddPropertyDialog(),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('إضافة عقار'),
        ),
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final Property property;

  const PropertyCard({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // هذا هو Navigator.push الذي يعمل عندك.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PropertyDetailsPage(
                property: property,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  property.images.first,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 90,
                      height: 90,
                      color: Colors.grey.shade200,
                      child: Icon(
                        property.icon,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text('📍 ${property.location}'),

                    const SizedBox(height: 4),

                    Text(
                      '💰 ${property.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      '🛏️ ${property.rooms} غرف  •  📐 ${property.area.toInt()} م²',
                    ),
                  ],
                ),
              ),

              const Icon(Icons.arrow_forward_ios, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class PropertyDetailsPage extends StatelessWidget {
  final Property property;

  const PropertyDetailsPage({
    super.key,
    required this.property,
  });

  Future<void> callOwner(BuildContext context) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: property.phone,
    );

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تعذر فتح تطبيق الاتصال'),
          ),
        );
      }
    }
  }

  Future<void> openWhatsApp(BuildContext context) async {
    final phone = property.phone.replaceAll(RegExp(r'[^0-9]'), '');

    final Uri whatsappUri = Uri.parse(
      'https://wa.me/213${phone.startsWith('0') ? phone.substring(1) : phone}',
    );

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(
        whatsappUri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تعذر فتح WhatsApp'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل العقار'),
        centerTitle: true,
      ),

      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // معرض الصور
              SizedBox(
                height: 250,
                child: PageView.builder(
                  itemCount: property.images.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      property.images[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: Icon(
                            property.icon,
                            size: 90,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      property.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      '📍 ${property.location}',
                      style: const TextStyle(fontSize: 19),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      property.price,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: _InfoBox(
                            icon: Icons.bed,
                            title: 'الغرف',
                            value: '${property.rooms}',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _InfoBox(
                            icon: Icons.square_foot,
                            title: 'المساحة',
                            value: '${property.area.toInt()} م²',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      'الوصف',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      property.description,
                      style: const TextStyle(
                        fontSize: 17,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () => callOwner(context),
                        icon: const Icon(Icons.phone),
                        label: const Text(
                          'اتصال بصاحب العقار',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () => openWhatsApp(context),
                        icon: const Icon(Icons.chat),
                        label: const Text(
                          'التواصل عبر WhatsApp',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoBox({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Icon(icon, size: 30),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(value),
          ],
        ),
      ),
    );
  }
}

class AddPropertyDialog extends StatefulWidget {
  const AddPropertyDialog({super.key});

  @override
  State<AddPropertyDialog> createState() => _AddPropertyDialogState();
}

class _AddPropertyDialogState extends State<AddPropertyDialog> {
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    locationController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: const Text('إضافة عقار'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'اسم العقار',
                  prefixIcon: Icon(Icons.home),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: 'المدينة / المنطقة',
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'السعر',
                  prefixIcon: Icon(Icons.attach_money),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'تم استلام معلومات العقار. سنضيف الحفظ الفعلي في الخطوة القادمة.',
                  ),
                ),
              );
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }
}
