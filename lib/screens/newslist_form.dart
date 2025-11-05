import 'package:flutter/material.dart';
import 'package:football_news/widgets/left_drawer.dart';

class NewsFormPage extends StatefulWidget {
    const NewsFormPage({super.key});

    @override
    State<NewsFormPage> createState() => _NewsFormPageState();
}

class _NewsFormPageState extends State<NewsFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _content = "";
  String _price = "";
  String _description = "";
  String _category = "update"; // default
  String _thumbnail = "";
  bool _isFeatured = false; // default

  final List<String> _categories = [
    'transfer',
    'update',
    'exclusive',
    'match',
    'rumor',
    'analysis',
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Tambah Berita',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Title ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Judul Berita",
                      labelText: "Judul Berita",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _title = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Judul tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Price ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Harga (contoh: 10000)",
                      labelText: "Harga",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String? value) {
                      setState(() {
                        _price = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Harga tidak boleh kosong!";
                      }
                      // simple numeric check
                      if (double.tryParse(value) == null) {
                        return "Masukkan angka yang valid untuk harga.";
                      }
                      return null;
                    },
                  ),
                ),

                // === Description ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Deskripsi singkat",
                      labelText: "Deskripsi",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _description = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Deskripsi tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Content ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Isi Berita",
                      labelText: "Isi Berita",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _content = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Isi berita tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Category ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Kategori",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    value: _category,
                    items: _categories
                        .map((cat) => DropdownMenuItem(
                              value: cat,
                              child: Text(cat[0].toUpperCase() + cat.substring(1)),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _category = newValue!;
                      });
                    },
                  ),
                ),

                // === Thumbnail URL ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "URL Thumbnail (opsional)",
                      labelText: "URL Thumbnail",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _thumbnail = value!;
                      });
                    },
                  ),
                ),

                // === Is Featured ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SwitchListTile(
                    title: const Text("Tandai sebagai Berita Unggulan"),
                    value: _isFeatured,
                    onChanged: (bool value) {
                      setState(() {
                        _isFeatured = value;
                      });
                    },
                  ),
                ),

                // === Tombol Simpan ===
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Wait until the dialog is dismissed before resetting the form
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Berita berhasil disimpan!'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Judul: $_title'),
                                      Text('Harga: $_price'),
                                      Text('Deskripsi: $_description'),
                                      Text('Isi: $_content'),
                                      Text('Kategori: $_category'),
                                      Text('Thumbnail: $_thumbnail'),
                                      Text('Unggulan: ${_isFeatured ? "Ya" : "Tidak"}'),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );

                          // Reset the form and local state after the dialog is closed
                          _formKey.currentState!.reset();
                          setState(() {
                            _title = "";
                            _price = "";
                            _description = "";
                            _content = "";
                            _category = "update";
                            _thumbnail = "";
                            _isFeatured = false;
                          });
                        }
                      },
                      child: const Text(
                        "Simpan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
