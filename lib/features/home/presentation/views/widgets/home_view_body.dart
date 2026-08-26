import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fruites_hub_app/features/home/presentation/views/widgets/build_permissions_status.dart';
import 'package:fruites_hub_app/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:fruites_hub_app/features/permissions/presentation/cubits/permissions_cubit.dart';

import '../../../../../core/widgets/search_text_field.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context
          .read<PermissionsCubit>()
          .checkAndRequestPermissions();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (!mounted) return;

      context
          .read<PermissionsCubit>()
          .checkAndRequestPermissions();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PermissionsCubit, PermissionsState>(
      listener: (context, state) {
        if (state is PermissionsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 32),
              const CustomHomeAppBar(),
              const SizedBox(height: 16),
              const SearchTextField(),
              const SizedBox(height: 12),

              if (state is PermissionsLoading)
                const CircularProgressIndicator(),

              if (state is PermissionsSuccess)
                buildPermissionsStatus(
                  state.permissionEntity,
                ),
            ],
          ),
        );
      },
    );
  }
}