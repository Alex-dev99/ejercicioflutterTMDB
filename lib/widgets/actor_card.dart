import 'package:flutter/material.dart';
import 'package:flutter_tmdb/core/models/movie_credits_response.dart';

class ActorCard extends StatelessWidget {
  final Cast actor;

  const ActorCard({
    super.key,
    required this.actor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Card(
        elevation: 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                actor.profilePath != null
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w500${actor.profilePath}',
                        height: 130,
                        width: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 130,
                            width: 120,
                            color: Colors.grey[300],
                            child: const Icon(Icons.person),
                          );
                        },
                      )
                    : Container(
                        height: 130,
                        width: 120,
                        color: Colors.grey[300],
                        child: const Icon(Icons.person),
                      ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          actor.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          actor.character,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 9,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
