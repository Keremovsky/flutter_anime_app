import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_anime_app/models/anime.dart';
import 'package:flutter_anime_app/themes/palette.dart';

class ExpandableAnimeDetails extends StatefulWidget {
  final Anime anime;
  final double normalHeight;
  final double expandedHeight;

  const ExpandableAnimeDetails({
    super.key,
    required this.anime,
    required this.normalHeight,
    required this.expandedHeight,
  });

  @override
  State<ExpandableAnimeDetails> createState() => _ExpandableAnimeDetailsState();
}

class _ExpandableAnimeDetailsState extends State<ExpandableAnimeDetails> {
  late double currentHeight;
  bool isExpanded = false;

  @override
  void initState() {
    currentHeight = widget.normalHeight;
    super.initState();
  }

  void expand() {
    setState(() {
      if (currentHeight == widget.expandedHeight) {
        currentHeight = widget.normalHeight;
        isExpanded = false;
      } else {
        currentHeight = widget.expandedHeight;
        isExpanded = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            expand();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: currentHeight,
            width: double.infinity,
            child: Stack(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Score: ${widget.anime.score}\n\n"),
                      TextSpan(
                        text: "Favorite count: ${widget.anime.favorites}\n\n",
                      ),
                      TextSpan(text: "Episodes: ${widget.anime.episodes}\n\n"),
                      TextSpan(
                          text: "Japanese name: ${widget.anime.japName}\n\n"),
                      TextSpan(text: "Type: ${widget.anime.type}\n\n"),
                      TextSpan(text: "Status: ${widget.anime.status}\n\n"),
                      TextSpan(text: "Year: ${widget.anime.year}\n\n"),
                      TextSpan(
                        text: "Broadcast Day: ${widget.anime.broadcastDay}\n\n",
                      ),
                    ],
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  decoration: BoxDecoration(
                    gradient: isExpanded
                        ? null
                        : LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Palette.background,
                              Palette.background.withOpacity(0),
                            ],
                          ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: isExpanded
                      ? const Icon(Icons.keyboard_arrow_up)
                      : const Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 30,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.anime.genres.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Material(
                  color: Palette.boxColor,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onLongPress: () async {
                      await Clipboard.setData(
                        ClipboardData(text: widget.anime.genres[index]),
                      );
                    },
                    borderRadius: BorderRadius.circular(5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Text(
                          widget.anime.genres[index],
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
