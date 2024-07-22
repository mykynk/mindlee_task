import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindlee_task/constants/size.dart';
import 'package:mindlee_task/core/extensions/l10n_extensions.dart';
import 'package:mindlee_task/models/daily_message_model.dart';

import '../providers/daily_message_provider.dart';
import '../widgets/app_bar_widget.dart';

class DailyMessagePage extends ConsumerWidget {
  const DailyMessagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(messageProvider);
    final notifier = ref.read(messageProvider.notifier);

    var boxDecoration = BoxDecoration(
      color: Colors.blueAccent,
      image: DecorationImage(
        image: state.messages.isEmpty ||
                state.messages[0].backgroundImage?.isEmpty == true
            ? const AssetImage('assets/images/background.png')
            : AssetImage(
                'assets/images/${state.messages[state.currentIndex].backgroundImage}'),
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.multiply),
      ),
    );

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: boxDecoration,
        child: SafeArea(
          child: Column(
            children: [
              AppBarWidget(title: context.localize.daily_message),
              MessageList(state: state, notifier: notifier),
              BottomButtons(notifier: notifier, state: state)
            ],
          ),
        ),
      ),
    );
  }
}

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    super.key,
    required this.notifier,
    required this.state,
  });

  final DailyMessageNotifier notifier;
  final DailyMessageState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: deviceWidthSize(context, 24),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
                onPressed: () {}, child: Text(context.localize.daily_number)),
          ),
          Padding(
            padding: EdgeInsets.only(left: deviceWidthSize(context, 12)),
            child: IconButton(
              icon: Image.asset(
                'assets/icons/edit.png',
                width: deviceWidthSize(context, 20),
                height: deviceHeightSize(context, 20),
              ),
              style: ButtonStyle(
                fixedSize: WidgetStateProperty.all(
                  Size(
                    deviceWidthSize(context, 48),
                    deviceHeightSize(context, 48),
                  ),
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  const MessageList({
    super.key,
    required this.state,
    required this.notifier,
  });

  final DailyMessageState state;
  final DailyMessageNotifier notifier;

  @override
  Widget build(BuildContext context) {
    if (state.loadingStatus == LoadingStatus.loading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }
    return Expanded(
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: state.messages.length,
        onPageChanged: (index) {
          notifier.setCurrentlySelectedMessageIndex(index);
        },
        itemBuilder: (context, index) {
          final message = state.messages[index];
          return MessageCard(message: message, notifier: notifier);
        },
      ),
    );
  }
}

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.message,
    required this.notifier,
  });

  final DailyMessageModel message;
  final DailyMessageNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(
          deviceHeightSize(context, 24),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: deviceWidthSize(context, 16),
                vertical: deviceHeightSize(context, 24),
              ),
              color: Colors.white.withOpacity(0.12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.title != null)
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            message.title ?? "",
                            style: TextStyle(
                              fontSize: deviceFontSize(context, 20),
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if (message.date != null)
                          Padding(
                            padding: EdgeInsets.only(
                                left: deviceWidthSize(context, 8)),
                            child: Text(
                              "${message.date!.day.toString().padLeft(2, '0')}.${message.date!.month.toString().padLeft(2, '0')}.${message.date!.year}",
                              style: TextStyle(
                                fontSize: deviceFontSize(context, 14),
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: deviceHeightSize(context, 12),
                    ),
                    child: Text(
                      message.message ?? "",
                      style: TextStyle(
                        fontSize: deviceFontSize(context, 16),
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: deviceHeightSize(context, 10),
                      ),
                      child: Icon(
                        (message.liked ?? false)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: (message.liked ?? false)
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                    onTap: () => notifier.toggleLike(message.id!),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      child: Image.asset(
                        'assets/icons/share.png',
                        width: deviceWidthSize(context, 24),
                        height: deviceHeightSize(context, 24),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
