import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/kos_service.dart';

class KosListPage extends StatefulWidget {
  const KosListPage({super.key});

  @override
  State<KosListPage> createState() => _KosListPageState();
}

class _KosListPageState extends State<KosListPage> {
  final _kosService = KosService();
  late Future<List<Map<String, dynamic>>> _kosFuture;

  @override
  void initState() {
    super.initState();
    _kosFuture = _kosService.fetchAll();
  }

  void _refresh() {
    setState(() {
      _kosFuture = _kosService.fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final myId = Supabase.instance.client.auth.currentUser!.id;

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Kos')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _kosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text('Belum ada data kos.'));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) {
              final kos = items[i];
              // ─── LOGIKA PEMILIK KOS ───
              final isMine = kos['owner_id'] == myId;

              return ListTile(
                title: Text(kos['name'] ?? '-'),
                subtitle: Text('${kos['address'] ?? '-'} • Rp ${kos['price'] ?? 0}'),
                // ─── TOMBOL EDIT & HAPUS HANYA MUNCUL JIKA INI KOS MILIKNYA ───
                trailing: isMine
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              // TODO: Buka halaman Form Edit Kos
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Fitur Edit belum dibuat')),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              // Panggil fungsi delete dari KosService
                              final success = await _kosService.delete(kos['id']);
                              
                              if (success && mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Kos berhasil dihapus')),
                                );
                                _refresh(); // Refresh list setelah dihapus
                              } else if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Gagal menghapus. Ditolak RLS.')),
                                );
                              }
                            },
                          ),
                        ],
                      )
                    : null, // Jika bukan kos miliknya, tombol tidak muncul (null)
              );
            },
          );
        },
      ),
      // Tombol untuk menambah data (Opsional, untuk uji coba)
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Simulasi tambah data (sebagai user yang login)
          await _kosService.add(
            name: 'Kos Baru ${DateTime.now().second}',
            address: 'Jl. Test',
            price: 1000000,
          );
          _refresh();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}