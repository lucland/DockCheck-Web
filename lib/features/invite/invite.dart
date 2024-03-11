import 'package:dockcheck_web/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/colors.dart';
import '../../widgets/text_input_widget.dart';
import 'bloc/invite_cubit.dart';
import 'bloc/invite_state.dart';

class InviteWidget extends StatelessWidget {
  InviteWidget({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final companyNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InviteCubit, InviteState>(
      builder: (context, state) {
        final isSendButtonEnabled = emailController.text.isNotEmpty &&
            companyNameController.text.isNotEmpty &&
            state.isEmailValid;
        return Container(
          height: 1000,
          child: Column(
            children: [
              TextInputWidget(
                title: 'Nome da empresa',
                isRequired: true,
                controller: companyNameController,
                isEnabled: state.isInputEnabled,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextInputWidget(
                      title: 'Email',
                      isRequired: true,
                      isEnabled: state.isInputEnabled,
                      isError: !state.isEmailValid,
                      errorMessage: 'Por favor, insira um email válido',
                      controller: emailController,
                      onChanged: (text) {
                        context.read<InviteCubit>().validateEmail(text);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 26.0),
                    child: InkWell(
                      onTap: isSendButtonEnabled
                          ? () {
                              context.read<InviteCubit>().sendInvite(
                                  emailController.text,
                                  companyNameController.text);
                              emailController.clear();
                              companyNameController.clear();
                            }
                          : null,
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 2,
                            color: isSendButtonEnabled
                                ? DockColors.iron100
                                : Colors.grey,
                          ),
                          color: isSendButtonEnabled
                              ? DockColors.iron100
                              : Colors.grey,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (state.isLoading) const CircularProgressIndicator(),
              if (state.error != null)
                Text(state.error!,
                    style: const TextStyle(color: DockColors.danger110)),
              Expanded(
                child: ListView.builder(
                  itemCount: state.invites.length,
                  itemBuilder: (context, index) {
                    final invite = state.invites[index];

                    String statusEmail = '';

                    if (invite.sent && !invite.viewed && !invite.accepted) {
                      statusEmail = 'Enviado';
                    } else if (!invite.sent) {
                      statusEmail = 'Pendente';
                    } else if (invite.sent &&
                        invite.viewed &&
                        !invite.accepted) {
                      statusEmail = 'Visualizado';
                    } else if (invite.sent && invite.accepted) {
                      statusEmail = 'Aceito';
                    }

                    return ListTile(
                      title: Text(invite.email, style: DockTheme.body),
                      subtitle: Text(statusEmail,
                          style: DockTheme.body2.copyWith(
                            color: statusEmail == 'Aceito'
                                ? DockColors.success100
                                : DockColors.iron100,
                          )),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              context
                                  .read<InviteCubit>()
                                  .cancelInvite(invite.id);
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: DockColors.danger110,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.close,
                                        color: DockColors.danger110,
                                        size: 16,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Cancelar convite',
                                        overflow: TextOverflow.ellipsis,
                                        style: DockTheme.body.copyWith(
                                            color: DockColors.danger110,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              context
                                  .read<InviteCubit>()
                                  .cancelInvite(invite.id);
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: DockColors.iron100,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.send_rounded,
                                        color: DockColors.iron100,
                                        size: 16,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Reenviar',
                                        overflow: TextOverflow.ellipsis,
                                        style: DockTheme.body.copyWith(
                                            color: DockColors.iron100,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
