import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokeapi/pokeapi.dart';

class PokemonCard extends StatefulWidget {
  const PokemonCard({
    Key? key,
  }) : super(key: key);

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  late Future<Pokemon?> pokemon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pokemon = PokeAPI.getObject<Pokemon>(1);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: pokemon,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: IntrinsicHeight(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 15,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  PokeInfo(
                                    id: snapshot.data!.id,
                                    name: snapshot.data!.name,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const PokeButton(),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  bottom: 10,
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      TypeContainer(
                                        typeName:
                                            snapshot.data!.types.toString(),
                                        typeColor: Colors.yellow,
                                        typeIcon: Icons.electric_bolt,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const TypeContainer(
                                        typeName: 'GHOST',
                                        typeColor: Colors.deepPurple,
                                        typeIcon: Icons.cut_outlined,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const PokemonImageStack(),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Text("failed");
        }
      }),
    );
  }
}

class PokemonImageStack extends StatelessWidget {
  const PokemonImageStack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(100),
              bottomLeft: Radius.circular(100),
            ),
          ),
          child: Row(
            children: [
              Transform.translate(
                offset: const Offset(20, 0),
                child: const Icon(
                  Icons.catching_pokemon_outlined,
                  size: 80,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PokeButton extends StatelessWidget {
  const PokeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 15,
      ),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {},
            icon: const Icon(
              Icons.star_border_outlined,
            ),
            iconSize: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {},
            icon: const Icon(
              Icons.circle_outlined,
            ),
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}

class PokeInfo extends StatelessWidget {
  final int? id;
  final String? name;
  const PokeInfo({
    Key? key,
    required this.id,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(
          left: 15,
        ),
        child: Row(
          children: [
            Text(
              "#${id.toString().padLeft(4, '0')}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                name!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.8),
                ),
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TypeContainer extends StatelessWidget {
  final String? typeName;
  final IconData typeIcon;
  final Color typeColor;
  const TypeContainer({
    Key? key,
    required this.typeName,
    required this.typeIcon,
    required this.typeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: typeColor,
          ),
          color: typeColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              typeIcon,
              color: typeColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: Text(
                typeName!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
