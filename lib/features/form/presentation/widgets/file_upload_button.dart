import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class FileUploadButton extends StatelessWidget {
  final String title;
  final String? fileName;
  final VoidCallback onTap;
  final IconData icon;

  const FileUploadButton({
    super.key,
    required this.title,
    this.fileName,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: fileName != null ? AppTheme.primaryBlue : Colors.grey.shade300,
            width: fileName != null ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: AppTheme.white,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: fileName != null ? AppTheme.primaryBlue : AppTheme.textLight,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppTheme.textDark,
                      fontWeight: fileName != null ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                  if (fileName != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        fileName!,
                        style: const TextStyle(
                          color: AppTheme.textLight,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
            if (fileName != null)
              const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }
}
