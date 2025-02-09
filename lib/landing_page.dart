import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'main.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  final List<Map<String, dynamic>> items = [
    {
      'id': 1,
      'name': 'Girls Und Panzer',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMWRkODhjMGMtMTI3OS00Yzc3LTk2OTYtZGNmNzkxMmQxM2NhXkEyXkFqcGc@._V1_.jpg',
      'rating': 4.5,
      'isFavorite': false,
      'sinopsis': 'Sinopsis Girls Und Panzer...',
      'genre': 'Action, Military, School',
      'tanggalRilis': '2012-10-09',
      'jumlahEpisode': 12,
      'durasiEpisode': '24 min per ep',
      'studioProduksi': 'Actas',
    },
    {
      'id': 2,
      'name': 'Blue Archive The Animation',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2dP9FV_kEoLEX4eKJAVIYw3lp_Qjynzo4Ow&s',
      'rating': 4.6,
      'isFavorite': false,
      'sinopsis': '''Kivotos is a federal megalopolis comprising thousands of schools and is led by the General Student Council (GSC), which acts as its governing body. Ironically, despite being an academy city, Kivotos is rife with gun violence, and all students wield firearms as part of their everyday lives.
As if the crisis in Kivotos was not enough, the GSC president is nowhere to be found. Fortunately, before her sudden disappearance, the GSC president enlisted the help of Sensei—a teacher who is most likely the only one in Kivotos—to support students in their time of need. Sensei's first course of action is to assist Abydos High School, a once prestigious academy now with merely five students in attendance. These remaining students are doing everything they can to pay their academy's crippling debt of almost one billion yen.''',
      'genre': 'Action, School, Sci-Fi',
      'tanggalRilis': '2021-11-09',
      'jumlahEpisode': 13,
      'durasiEpisode': '23 min per ep',
      'studioProduksi': 'Yostar Pictures',
    },
    {
      'id': 3,
      'name': 'Haikyu The Dumpster Battle',
      'image':
          'https://m.media-amazon.com/images/M/MV5BZWFiNmRkY2MtN2ViZC00MzhhLWI0YWYtNzVlZWFmZDI3ZjE3XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'rating': 4.9,
      'isFavorite': false,
      'sinopsis': 'Sinopsis Haikyu...',
      'genre': 'Sports, Drama, School',
      'tanggalRilis': '2020-10-02',
      'jumlahEpisode': 25,
      'durasiEpisode': '24 min per ep',
      'studioProduksi': 'Production I.G',
    },
  ];

  Future<void> _logout() async {
    var box = Hive.box('userBox');
    await box.delete('loggedInUser'); // Hanya menghapus data login

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()),
      (Route<dynamic> route) => false,
    );
  }

  void _showAnimeDetails(int id) {
    final anime = items.firstWhere((item) => item['id'] == id);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(anime['name']),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.network(anime['image']),
                const SizedBox(height: 8),
                Text('Sinopsis: ${anime['sinopsis']}'),
                const SizedBox(height: 8),
                Text('Genre: ${anime['genre']}'),
                const SizedBox(height: 8),
                Text('Tanggal Rilis: ${anime['tanggalRilis']}'),
                const SizedBox(height: 8),
                Text('Jumlah Episode: ${anime['jumlahEpisode']}'),
                const SizedBox(height: 8),
                Text('Durasi Episode: ${anime['durasiEpisode']}'),
                const SizedBox(height: 8),
                Text('Studio Produksi: ${anime['studioProduksi']}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showAddAnimeForm() {
    final formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController imageController = TextEditingController();
    final TextEditingController ratingController = TextEditingController();
    final TextEditingController sinopsisController = TextEditingController();
    final TextEditingController genreController = TextEditingController();
    final TextEditingController tanggalRilisController = TextEditingController();
    final TextEditingController jumlahEpisodeController = TextEditingController();
    final TextEditingController durasiEpisodeController = TextEditingController();
    final TextEditingController studioProduksiController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambah Anime'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Nama'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: imageController,
                    decoration: const InputDecoration(labelText: 'URL Gambar'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'URL Gambar tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: ratingController,
                    decoration: const InputDecoration(labelText: 'Rating'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Rating tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: sinopsisController,
                    decoration: const InputDecoration(labelText: 'Sinopsis'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sinopsis tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: genreController,
                    decoration: const InputDecoration(labelText: 'Genre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Genre tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: tanggalRilisController,
                    decoration: const InputDecoration(labelText: 'Tanggal Rilis'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tanggal Rilis tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: jumlahEpisodeController,
                    decoration: const InputDecoration(labelText: 'Jumlah Episode'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Jumlah Episode tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: durasiEpisodeController,
                    decoration: const InputDecoration(labelText: 'Durasi Episode'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Durasi Episode tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: studioProduksiController,
                    decoration: const InputDecoration(labelText: 'Studio Produksi'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Studio Produksi tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Simpan'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    items.add({
                      'id': items.length + 1,
                      'name': nameController.text,
                      'image': imageController.text,
                      'rating': double.parse(ratingController.text),
                      'isFavorite': false,
                      'sinopsis': sinopsisController.text,
                      'genre': genreController.text,
                      'tanggalRilis': tanggalRilisController.text,
                      'jumlahEpisode': int.parse(jumlahEpisodeController.text),
                      'durasiEpisode': durasiEpisodeController.text,
                      'studioProduksi': studioProduksiController.text,
                    });
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Landing Page'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: showAddAnimeForm,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Favorit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ...items.where((item) => item['isFavorite']).map((item) {
              return ListTile(
                leading: Image.network(
                  item['image'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    );
                  },
                ),
                title: Text(item['name']),
                subtitle: Text('Rating: ${item['rating']}'),
                onTap: () {
                  Navigator.pop(context);
                  _showAnimeDetails(item['id']);
                },
              );
            }).toList(),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _showAnimeDetails(items[index]['id']),
            child: SizedBox(
              height: 120,
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(4), // Mengurangi padding
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      items[index]['image'],
                      width: 64,
                      height: 120,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image,
                          size: 60,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                  title: Text(
                    items[index]['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        items[index]['rating'].toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      items[index]['isFavorite']
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        items[index]['isFavorite'] =
                            !items[index]['isFavorite'];
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            items[index]['isFavorite']
                                ? '${items[index]['name']} ditambahkan ke favorit'
                                : '${items[index]['name']} dihapus dari favorit',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}