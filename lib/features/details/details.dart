import 'package:dockcheck_web/features/details/bloc/details_cubit.dart';
import 'package:dockcheck_web/models/employee.dart';
import 'package:dockcheck_web/utils/colors.dart';
import 'package:dockcheck_web/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/document.dart';
import '../../utils/formatter.dart';
import '../../utils/theme.dart';
import '../../widgets/title_value_widget.dart';

class DetailsView extends StatelessWidget {
  final Employee employee;

  DetailsView({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    context.read<DetailsCubit>().getEmployeeAndDocuments(employee.id);
    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
        if (state is DetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DetailsError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is DetailsLoaded) {
          final documents = state.documents;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: DockColors.iron100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(employee.name,
                            style: DockTheme.h1.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis),
                      ),
                      Text('|   N° ${employee.number.toString()}',
                          style: DockTheme.h1.copyWith(color: Colors.white),
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Your TitleValueWidgets here for cpf, bloodType, etc.
                    ],
                  ),
                ),
                // Additional Widgets for displaying user details
                _buildDocumentsCard(documents),
              ],
            ),
          );
        } else {
          return const Center(child: Text('Erro desconhecido'));
        }
      },
    );
  }

  Widget _buildDocumentsCard(List<Document> documents) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: DockColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Your documents related widgets here
            ],
          ),
        ),
      ),
    );
  }
}
