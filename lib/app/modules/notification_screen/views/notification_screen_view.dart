// ignore_for_file: deprecated_member_use
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/models/notification_model.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';
import '../controllers/notification_screen_controller.dart';
import 'widget/notification_widget.dart';

class NotificationScreenView extends StatelessWidget {
  const NotificationScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetBuilder<NotificationScreenController>(
        autoRemove: false,
        init: NotificationScreenController(),
        builder: (controller) {
          return Container(
            child: Scaffold(
              backgroundColor: AppThemeData.grey50,
              body: Column(
                children: [
                  /// 🔹 HEADER
                  Obx(() => NotificationHeader(
                        unreadCount: controller.unreadNotifications.length,
                      )),

                  /// 🔹 LIST
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return Constant.loader();
                      }

                      if (controller.notificationList.isEmpty) {
                        return const Center(
                          child: Text(
                            "No notifications available",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: ListView.builder(
                          itemCount: controller.notificationList.length,
                          itemBuilder: (context, index) {
                            final notification =
                                controller.notificationList[index];

                            return ModernNotificationTile(
                              notification: notification,
                              isUnread: !controller.readNotificationIds
                                  .contains(notification.id),
                              onDelete: () {
                                controller.deleteNotification(notification);
                              },
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ModernNotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final bool isUnread;
  final VoidCallback onDelete;

  const ModernNotificationTile({
    super.key,
    required this.notification,
    required this.isUnread,
    required this.onDelete,
  });

  Color getBg() {
    switch (notification.type) {
      case "payment":
        return const Color(0xFFD1FAE5);
      case "offer":
        return const Color(0xFFEDE9FE);
      case "stock":
        return const Color(0xFFFFEDD5);
      default:
        return const Color(0xFFEFF6FF);
    }
  }

  IconData getIcon() {
    switch (notification.type) {
      case "payment":
        return Icons.attach_money;
      case "offer":
        return Icons.card_giftcard;
      case "stock":
        return Icons.warning_amber_rounded;
      default:
        return Icons.shopping_bag;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(notification.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.20,
        children: [
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: AppThemeData.danger300,
            icon: Icons.delete,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFC6D2FF)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF615FFF).withOpacity(0.12),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ICON
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: getBg(),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(getIcon(), color: AppThemeData.primary300),
            ),
            const SizedBox(width: 14),

            /// TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title ?? "",
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1D293D)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.description ?? "",
                    style:
                        const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "5 min ago",
                    style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                  ),
                ],
              ),
            ),

            /// UNREAD DOT
            if (isUnread)
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Color(0xFF4F39F6),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class NotificationHeader extends StatelessWidget {
  final int unreadCount;
  const NotificationHeader({super.key, required this.unreadCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppThemeData.accent300,
            AppThemeData.primary300,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TOP ROW
              Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xff5952f8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustom(
                        title: "Notifications",
                        fontSize: 20,
                        fontFamily: FontFamily.regular,
                        color: AppThemeData.primaryWhite,
                      ),
                      TextCustom(
                        title: "$unreadCount unread",
                        fontSize: 14,
                        fontFamily: FontFamily.regular,
                        color: AppThemeData.primaryWhite,
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    // onTap: () => controller.markAllAsRead(),

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Mark all read",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<NotificationModel> debugNotifications = [
  NotificationModel(
    id: "1",
    type: "order",
    title: "New Order Received",
    description: "Order #ORD-1245 from Sarah Johnson has been placed",
  ),
  NotificationModel(
    id: "2",
    type: "payment",
    title: "Payment Received",
    description: "You received \$45.50 for order #ORD-1244",
  ),
  NotificationModel(
    id: "3",
    type: "offer",
    title: "Special Offer",
    description: "Boost your sales with our premium listing package",
  ),
  NotificationModel(
    id: "4",
    type: "order",
    title: "Order Cancelled",
    description: "Order #ORD-1243 was cancelled by the customer",
  ),
  NotificationModel(
    id: "5",
    type: "stock",
    title: "Low Stock Alert",
    description: "Classic Burger is running low on inventory",
  ),
];
