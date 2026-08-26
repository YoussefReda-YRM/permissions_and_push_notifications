import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fruites_hub_app/core/services/get_it_service.dart';
import 'package:fruites_hub_app/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:fruites_hub_app/features/permissions/presentation/cubits/permissions_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String routeName = 'home_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => getIt<PermissionsCubit>(),
        child: const HomeViewBody(),
      ),
    );
  }
}
