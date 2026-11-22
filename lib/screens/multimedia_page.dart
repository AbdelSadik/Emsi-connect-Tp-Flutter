import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class MultimediaPage extends StatefulWidget {
  const MultimediaPage({super.key});

  @override
  State<MultimediaPage> createState() => _MultimediaPageState();
}

class _MultimediaPageState extends State<MultimediaPage> {
  final ImagePicker _picker = ImagePicker();
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();

  XFile? _image;
  String? _audioPath;
  bool _recording = false;
  bool _busy = false;

  void _message(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  Future<void> _chooseImage(ImageSource source) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final XFile? selected = await _picker.pickImage(
        source: source,
        imageQuality: 75,
      );
      if (!mounted) return;
      if (selected == null) {
        _message('Sélection annulée.');
      } else {
        setState(() => _image = selected);
      }
    } catch (e) {
      _message('Impossible de récupérer l’image : $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _startRecording() async {
    if (_busy || _recording) return;
    setState(() => _busy = true);
    try {
      // Sur mobile, permission_handler permet de gérer le refus.
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        final status = await Permission.microphone.request();
        if (!status.isGranted) {
          _message('Microphone non autorisé.');
          return;
        }
      }
      if (!await _recorder.hasPermission()) {
        _message('Autorisation microphone indisponible.');
        return;
      }
      // Chemin de fichier pour Android/iOS.
      // Sur le Web, record utilise une autre gestion du média.
      if (kIsWeb) {
        _message('Enregistrement à tester sur Android/iOS.');
        return;
      }
      final path = '${Directory.systemTemp.path}/question_emsi.m4a';
      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: path,
      );
      if (mounted) setState(() => _recording = true);
    } catch (e) {
      _message('Enregistrement impossible : $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _stopRecording() async {
    if (!_recording) return;
    try {
      final path = await _recorder.stop();
      if (!mounted) return;
      setState(() {
        _recording = false;
        _audioPath = path;
      });
      _message(path == null
          ? 'Aucun fichier enregistré.'
          : 'Question vocale enregistrée.');
    } catch (e) {
      _message('Erreur lors de l’arrêt : $e');
      if (mounted) setState(() => _recording = false);
    }
  }

  Future<void> _playAudio() async {
    if (_audioPath == null) return;
    try {
      await _player.stop();
      await _player.play(DeviceFileSource(_audioPath!));
    } catch (e) {
      _message('Lecture impossible : $e');
    }
  }

  @override
  void dispose() {
    _recorder.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Espace multimédia')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Image', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 12),
          Wrap(spacing: 8, runSpacing: 8, children: [
            ElevatedButton.icon(
              onPressed: _busy ? null : () => _chooseImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Prendre une photo'),
            ),
            OutlinedButton.icon(
              onPressed: _busy ? null : () => _chooseImage(ImageSource.gallery),
              icon: const Icon(Icons.photo_library),
              label: const Text('Galerie'),
            ),
          ]),
          const SizedBox(height: 12),
          if (_image != null)
            kIsWeb
                ? Image.network(_image!.path, height: 190)
                : Image.file(File(_image!.path), height: 190),
          const Divider(height: 40),
          const Text('Question vocale', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed:
                _busy ? null : (_recording ? _stopRecording : _startRecording),
            icon: Icon(_recording ? Icons.stop : Icons.mic),
            label: Text(_recording ? 'Arrêter' : 'Enregistrer'),
          ),
          if (_audioPath != null)
            OutlinedButton.icon(
              onPressed: _playAudio,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Écouter l’enregistrement'),
            ),
          if (_busy) const LinearProgressIndicator(),
        ],
      ),
    );
  }
}
