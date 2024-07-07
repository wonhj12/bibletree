import 'package:bibletree/models/setting_provider.dart';
import 'package:bibletree/views/widgets/custom_modal.dart';
import 'package:bibletree/views/widgets/modal_inkwell.dart';
import 'package:bibletree/views/widgets/setting_header.dart';
import 'package:bibletree/views/widgets/setting_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),

            // System settings
            const SettingHeader(title: '앱 설정'),

            // Theme
            SettingInkwell(
              name: '테마',
              value: Provider.of<SettingProvider>(context).getThemeName(),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomModal(
                      buttons: [
                        // Light mode
                        ModalInkwell(
                          title: '라이트 모드',
                          isTop: true,
                          onTap: () {
                            Provider.of<SettingProvider>(context, listen: false)
                                .changeTheme(ThemeMode.light);
                          },
                        ),

                        // Dark mode
                        ModalInkwell(
                          title: '다크 모드',
                          onTap: () {
                            Provider.of<SettingProvider>(context, listen: false)
                                .changeTheme(ThemeMode.dark);
                          },
                        ),

                        // System settings
                        ModalInkwell(
                          title: '시스템 설정',
                          isBottom: true,
                          onTap: () {
                            Provider.of<SettingProvider>(context, listen: false)
                                .changeTheme(ThemeMode.system);
                          },
                        )
                      ],
                    );
                  },
                  backgroundColor: Colors.transparent,
                );
              },
            ),

            // Notifications
            SettingInkwell(
              name: '알림',
              value: '켬',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomModal(
                      buttons: [
                        ModalInkwell(
                          title: '알림 켜기',
                          isTop: true,
                          onTap: () {},
                        ),
                        ModalInkwell(
                          title: '알림 끄기',
                          isBottom: true,
                          onTap: () {},
                        ),
                      ],
                    );
                  },
                  backgroundColor: Colors.transparent,
                );
              },
            ),

            // Haptics
            SettingInkwell(
              name: '진동',
              value: '켬',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomModal(
                      buttons: [
                        ModalInkwell(
                          title: '진동 켜기',
                          isTop: true,
                          onTap: () {},
                        ),
                        ModalInkwell(
                          title: '진동 끄기',
                          isBottom: true,
                          onTap: () {},
                        ),
                      ],
                    );
                  },
                  backgroundColor: Colors.transparent,
                );
              },
            ),

            const SizedBox(height: 32),

            // Usage
            const SettingHeader(title: '이용 안내'),

            // Version
            SettingInkwell(name: '앱 버젼', value: '1.0.0', onTap: () {}),

            // Personal Information
            SettingInkwell(name: '개인정보 처러방침', value: '', onTap: () {}),

            const SizedBox(height: 32),

            // Others
            const SettingHeader(title: '기타'),

            // Reset data
            SettingInkwell(name: '데이터 재설정', value: '', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
