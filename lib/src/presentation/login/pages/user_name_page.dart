import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';
import '../../../service_locator.dart';

enum Education {
  primary,
  secondary,
  higherSecondary,
  graduate,
  postGraduate;

  String get name {
    switch (this) {
      case Education.primary:
        return 'Primary';
      case Education.secondary:
        return 'Secondary';
      case Education.higherSecondary:
        return 'Higher Secondary';
      case Education.graduate:
        return 'Graduate';
      case Education.postGraduate:
        return 'Post Graduate';
    }
  }
}

class UserNamePage extends StatefulWidget {
  const UserNamePage({Key? key}) : super(key: key);

  @override
  State<UserNamePage> createState() => _UserNamePageState();
}

class _UserNamePageState extends State<UserNamePage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _capGainController = TextEditingController();
  final _capLossController = TextEditingController();
  final _incomeController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  bool _matrialStatus = false;
  bool _gender = true;
  Education _education = Education.graduate;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _capGainController.dispose();
    _capLossController.dispose();
    _incomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      key: const Key('user_name_page_view'),
      valueListenable: locator
          .get<Box<dynamic>>(instanceName: BoxType.settings.name)
          .listenable(
        keys: [userNameKey],
      ),
      builder: (context, value, _) {
        return Scaffold(
          key: const Key('user_name_scaffold'),
          resizeToAvoidBottomInset: true,
          body: Align(
            alignment: Alignment.center,
            child: SafeArea(
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                      child: const Icon(
                        Icons.wallet,
                        size: 72,
                      ),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                              letterSpacing: 0.8,
                            ),
                        text: context.loc.welcomeLabel,
                        children: [
                          TextSpan(
                            text: ' ${context.loc.appTitle}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      context.loc.welcomeDescLabel,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.75),
                            letterSpacing: 0.6,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Form(
                      key: _formState,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: context.loc.enterNameLabel,
                              label: Text(context.loc.nameLabel),
                            ),
                            keyboardType: TextInputType.name,
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                return null;
                              } else {
                                return context.loc.enterNameLabel;
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          const Text("Matrial Status"),
                          _matrialStatusWidget(),
                          const SizedBox(height: 16),
                          const Text("Gender"),
                          _genderWidget(),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _ageController,
                            decoration: const InputDecoration(
                              hintText: "Enter your age",
                              label: Text("Age"),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Enter your age";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          _educationWidget(),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _capGainController,
                            decoration: const InputDecoration(
                              hintText: "Enter Capital Gains",
                              suffixText: "₹",
                              label: Text("Capital Gains"),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                return null;
                              }
                              return "Enter capital gains";
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _capLossController,
                            decoration: const InputDecoration(
                              hintText: "Enter Capital Loss",
                              suffixText: "₹",
                              label: Text("Capital Loss"),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                return null;
                              }
                              return "Enter Capital Loss";
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _incomeController,
                            decoration: const InputDecoration(
                              hintText: "Enter Income per year",
                              suffixText: "₹",
                              label: Text("Income per year"),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                return null;
                              }
                              return "Enter Income per year";
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (_formState.currentState!.validate()) {
                value.putAll({
                  userNameKey: _nameController.text,
                  userAgeKey: int.parse(_ageController.text),
                  userMatrialStatusKey: _matrialStatus,
                  userEducationKey: _education,
                  userCapitalGainKey: int.parse(_capGainController.text),
                  userCapitalLossKey: int.parse(_capLossController.text),
                  userIncomeKey: int.parse(_incomeController.text),
                  userGenderKey: _gender,
                }).then((value) => context.go(userImagePath));
              }
            },
            extendedPadding: const EdgeInsets.symmetric(horizontal: 24),
            label: const Icon(MdiIcons.arrowRight),
            icon: Text(
              context.loc.nextLabel,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
            ),
          ),
        );
      },
    );
  }

  InputDecorator _educationWidget() {
    return InputDecorator(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Education>(
          value: _education,
          hint: const Text("Education"),
          items: Education.values
              .map(
                (e) => DropdownMenuItem<Education>(
                  value: e,
                  child: Text(e.name),
                ),
              )
              .toList(),
          onChanged: (val) {
            if (val == null) return;
            setState(() {
              _education = val;
            });
          },
        ),
      ),
    );
  }

  Widget _matrialStatusWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: _matrialStatus,
              onChanged: (val) {
                if (val == null) return;
                setState(() {
                  _matrialStatus = val;
                });
              },
            ),
            Text("Married", style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        Row(
          children: [
            Radio<bool>(
              value: false,
              groupValue: _matrialStatus,
              onChanged: (val) {
                if (val == null) return;
                setState(() {
                  _matrialStatus = val;
                });
              },
            ),
            Text("Unmarried", style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ],
    );
  }

  Widget _genderWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Radio<bool>(
              value: false,
              groupValue: _gender,
              onChanged: (val) {
                if (val == null) return;
                setState(() {
                  _gender = val;
                });
              },
            ),
            Text("Male", style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: _gender,
              onChanged: (val) {
                if (val == null) return;
                setState(() {
                  _gender = val;
                });
              },
            ),
            Text("Female", style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ],
    );
  }
}
