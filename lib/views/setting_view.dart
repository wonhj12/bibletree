// import 'package:bibletree/models/setting_provider.dart';
import 'package:bibletree/widgets/custom_modal.dart';
import 'package:bibletree/widgets/custom_time_picker.dart';
import 'package:bibletree/widgets/modal_inkwell.dart';
import 'package:bibletree/widgets/setting_inkwell.dart';
import 'package:bibletree/viewModels/setting_view_model.dart';
import 'package:bibletree/widgets/setting_header.dart';
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
    SettingViewModel settingViewModel = context.watch<SettingViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        leading: IconButton(
          onPressed: () => settingViewModel.onPressedBackBtn(),
          // {
          //   Navigator.of(context).pop(
          //       Provider.of<SettingProvider>(context, listen: false).reset);
          // },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),

            /* 나무 설정 */
            // 헤더
            // if (settingViewModel.userModel.treeName != null)
            const SettingHeader(title: '나무 설정'),

            // 말씀 새로 받는 시간
            SettingInkwell(
              name: '말씀 묵상 시간',
              value: settingViewModel.updateTimeString(),
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return CustomTimePicker(
                    initialTime: settingViewModel.userModel.updateTime,
                    onSave: (time) => settingViewModel.onTapSaveTime(time),
                  );
                },
                backgroundColor: Colors.transparent,
              ),
            ),

            // 이름
            if (settingViewModel.userModel.treeName != null)
              // if (Provider.of<SettingProvider>(context).treeName != null)
              SettingInkwell(
                name: '이름',
                value: settingViewModel.userModel.treeName!,
                onTap: () {},
              ),

            // if (settingViewModel.userModel.treeName != null)
            const SizedBox(height: 32),

            /* 앱 시스템 설정 */
            // 헤더
            const SettingHeader(title: '앱 설정'),

            // 테마
            SettingInkwell(
              name: '테마',
              value: settingViewModel.getThemeName(),
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return CustomModal(
                    buttons: [
                      // Light mode
                      ModalInkwell(
                        title: '라이트 모드',
                        isTop: true,
                        onTap: () =>
                            settingViewModel.changeTheme(ThemeMode.light),
                      ),

                      // Dark mode
                      ModalInkwell(
                        title: '다크 모드',
                        onTap: () =>
                            settingViewModel.changeTheme(ThemeMode.dark),
                      ),

                      // System settings
                      ModalInkwell(
                        title: '시스템 설정',
                        isBottom: true,
                        onTap: () =>
                            settingViewModel.changeTheme(ThemeMode.system),
                      )
                    ],
                  );
                },
                backgroundColor: Colors.transparent,
              ),
            ),

            // 알림 설정
            SettingInkwell(
              name: '알림',
              value: settingViewModel.notification ? '켬' : '끔',
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return CustomModal(
                    buttons: [
                      ModalInkwell(
                        title: '알림 켜기',
                        isTop: true,
                        onTap: () => settingViewModel.changeNotification(true),
                      ),
                      ModalInkwell(
                        title: '알림 끄기',
                        isBottom: true,
                        onTap: () => settingViewModel.changeNotification(false),
                      ),
                    ],
                  );
                },
                backgroundColor: Colors.transparent,
              ),
            ),

            // Haptics
            SettingInkwell(
              name: '진동',
              value: settingViewModel.haptic ? '켬' : '끔',
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return CustomModal(
                    buttons: [
                      ModalInkwell(
                        title: '진동 켜기',
                        isTop: true,
                        onTap: () => settingViewModel.changeHaptic(true),
                      ),
                      ModalInkwell(
                        title: '진동 끄기',
                        isBottom: true,
                        onTap: () => settingViewModel.changeHaptic(false),
                      ),
                    ],
                  );
                },
                backgroundColor: Colors.transparent,
              ),
            ),

            const SizedBox(height: 32),

            /* 앱 설정 */
            // 헤더
            const SettingHeader(title: '이용 안내'),

            // 버전
            SettingInkwell(name: '앱 버젼', value: '1.0.0', onTap: () {}),

            // 개인정보 처리방침
            SettingInkwell(name: '개인정보 처리방침', value: '', onTap: () {}),

            const SizedBox(height: 32),

            /* 기타 설정 */
            // 헤더
            const SettingHeader(title: '기타'),

            // 데이터 재설정
            // TODO : popup
            SettingInkwell(
              name: '데이터 재설정',
              value: '',
              onTap: () async => settingViewModel.resetData(),
            ),
          ],
        ),
      ),
    );
  }
}
