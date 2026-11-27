import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final String? url;
  final VoidCallback? onPressed;

  const AppButton({
    super.key,
    required this.label,
    required this.icon,
    this.url,
    this.onPressed,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isLoading = false;

  Future<void> _handlePressed(BuildContext context) async {
    // Jika ada aksi internal, jalankan aksi tersebut dan selesai.
    if (widget.onPressed != null) {
      widget.onPressed!();
      return;
    }

    // Jika tidak ada aksi internal, buka URL (kalau ada).
    final url = widget.url;
    if (url == null) return;

    final messenger = ScaffoldMessenger.of(context);
    setState(() => _isLoading = true);

    try {
      final berhasil = await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
      if (!berhasil) {
        messenger.showSnackBar(
          SnackBar(content: Text('Tidak dapat membuka $url')),
        );
      }
    } catch (_) {
      messenger.showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan saat membuka $url')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _isLoading ? null : () => _handlePressed(context),
      icon: _isLoading
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(widget.icon),
      label: Text(widget.label),
    );
  }
}
