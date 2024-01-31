import 'package:dockcheck_web/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.height,
            color: DockColors.iron100,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/logo_web.svg',
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            const Icon(
                              Icons.anchor,
                              color: DockColors.white,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Projetos',
                              style: DockTheme.h2.copyWith(
                                  color: DockColors.background,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person_outline_outlined,
                              color: DockColors.white,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Funcionários',
                              style: DockTheme.h2.copyWith(
                                  color: DockColors.background,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: DockColors.iron100,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                          color: DockColors.white,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              color: DockColors.white,
                              size: 16,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Logout',
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
          ),
          Container(
            color: DockColors.background,
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Funcionários',
                        style: DockTheme.h1.copyWith(
                          color: DockColors.iron100,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                            color: DockColors.success120,
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: DockColors.success120,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: DockColors.white,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Adicionar',
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
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
