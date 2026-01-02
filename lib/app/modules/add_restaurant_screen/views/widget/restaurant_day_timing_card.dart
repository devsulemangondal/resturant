import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

class RestaurantDayTimingCard extends StatelessWidget {
  final String shortDay;
  final String fullDay;
  final bool isEnabled;
  final VoidCallback onToggle;
  final VoidCallback onOpenTap;
  final VoidCallback onCloseTap;
  final TextEditingController openController;
  final TextEditingController closeController;

  const RestaurantDayTimingCard({
    super.key,
    required this.shortDay,
    required this.fullDay,
    required this.isEnabled,
    required this.onToggle,
    required this.onOpenTap,
    required this.onCloseTap,
    required this.openController,
    required this.closeController,
  });

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFC6D2FF)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF615FFF).withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          /// 🔹 HEADER ROW
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: isEnabled
                      ? const Color(0xFFDBEAFE)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  shortDay,
                  style: TextStyle(
                    fontSize: isEnabled ? 13 : 12,
                    fontWeight: FontWeight.normal,
                    color: isEnabled
                        ? const Color(0xFF432DD7)
                        : const Color(0xFF62748E),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                fullDay,
                style: TextStyle(
                  fontSize: isEnabled ? 14 : 12,
                  fontWeight: isEnabled ? FontWeight.w400 : FontWeight.normal,
                  color: isEnabled
                      ? const Color(0xFF1D293D)
                      : const Color(0xFF62748E),
                ),
              ),
              const Spacer(),
              CupertinoSwitch(
                value: isEnabled,
                activeTrackColor: AppThemeData.primary300,
                onChanged: (_) => onToggle(),
              ),
            ],
          ),

          /// 🔹 TIME FIELDS
          if (isEnabled) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                _TimeBox(
                  label: "Opens",
                  controller: openController,
                  onTap: onOpenTap,
                ),
                const SizedBox(width: 12),
                _TimeBox(
                  label: "Closes",
                  controller: closeController,
                  onTap: onCloseTap,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _TimeBox extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onTap;

  const _TimeBox({
    required this.label,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFDDE3F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 16,
                    color: Color(0xFF94A3B8),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF62748E),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller,
                builder: (context, value, _) {
                  return Text(
                    value.text.isEmpty ? "09:00" : value.text,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF1D293D),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
