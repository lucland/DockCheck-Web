import 'package:dockcheck_web/features/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';
import '../utils/theme.dart';

class MenuSide extends StatelessWidget {
  const MenuSide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: MediaQuery.of(context).size.height,
      color: DockColors.iron100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  'assets/svg/logo_web.svg',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: DockColors.iron30,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Center(
                    child: Text(
                      'DOF',
                      style: DockTheme.h1.copyWith(
                        color: DockColors.iron100,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(
                        Icons.anchor,
                        color: DockColors.white,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Projetos',
                        overflow: TextOverflow.ellipsis,
                        style: DockTheme.h2.copyWith(
                            color: DockColors.background,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person_outline_outlined,
                        color: DockColors.white,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Funcionários',
                        overflow: TextOverflow.ellipsis,
                        style: DockTheme.h2.copyWith(
                            color: DockColors.background,
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          //text with version
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  color: DockColors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Versão 1.0.0',
                    style: DockTheme.h2.copyWith(
                      color: DockColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.9, 16.0),
                  child: Text(
                    '© 2024 DockCheck. Todos os direitos reservados.',
                    style: DockTheme.h2.copyWith(
                      color: DockColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: DockColors.iron100,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: DockColors.white,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.logout,
                            color: DockColors.white,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Sair',
                            overflow: TextOverflow.ellipsis,
                            style: DockTheme.h2.copyWith(
                                color: DockColors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
