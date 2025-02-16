import 'package:flutter/material.dart';

enum LifeState { alive, dead, unknown }

class CharacterStatus extends StatelessWidget {
  final LifeState lifeState;

  const CharacterStatus({super.key, required this.lifeState});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.circle,
          size: 12,
          color: switch (lifeState) {
            LifeState.alive => Colors.green,
            LifeState.dead => Colors.red,
            LifeState.unknown => Colors.white,
          },
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          switch (lifeState) {
            LifeState.alive => 'Alive',
            LifeState.dead => 'Dead',
            LifeState.unknown => 'Unknown',
          },
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

}