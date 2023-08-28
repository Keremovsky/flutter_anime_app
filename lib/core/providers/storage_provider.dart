import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_anime_app/core/providers/firebase_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageProvider = Provider((ref) => Storage(
      storage: ref.read(firebaseStorageProvider),
    ));

class Storage {
  final FirebaseStorage _storage;

  Storage({required storage}) : _storage = storage;

  Future<String> getFileURL(String path, String fileName) async {
    final fileURL = await _storage.ref("$path$fileName").getDownloadURL();

    return fileURL;
  }
}
