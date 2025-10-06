import 'package:flutter/material.dart';
import 'package:gestioncontenu/core/constants.dart';
import 'package:gestioncontenu/domains/entities/content.dart';

class ContentCard extends StatefulWidget {
  const ContentCard({super.key, required this.content, required this.edit});

  final Content content;
  final void Function() edit;

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Card(
        child: Stack(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/img/belair.jpg',
                      ),
                      fit: BoxFit.cover)),
            ),
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: const Color.fromARGB(144, 0, 0, 0),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        format.format(widget.content.createdAt!),
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: widget.edit,
                          icon: Icon(
                            Icons.edit,
                            color: const Color.fromARGB(179, 33, 149, 243),
                          )),
                      IconButton(
                          onPressed: _showConfirmationDialog,
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 5,
              left: 5,
              right: 5,
              child: Text(
                widget.content.title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _delete(int id) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Contenu Supprimer avec succes, {id: $id}",
        style: TextStyle(fontSize: 18),
      ),
      backgroundColor: Colors.green[800],
    ));
  }

  void _showConfirmationDialog() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("voulez vous supprimer ce contenu"),
            actions: [
              TextButton(
                  onPressed: () {
                    _delete(widget.content.id);
                  },
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.green[800]),
                  child: Text(
                    'OUI',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  child: Text(
                    'NON',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            ],
          );
        });
  }
}
