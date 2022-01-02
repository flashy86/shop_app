import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  } //Quand on travaille avec les FocusNode il faut absolument utiliser la méthode dispose car ils ne se suppriment pas tout seul quand on changera d'écran et cela peut emmener à une fuite de mémoire.

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          //le widget Form aide à gérer les formulaires sans avoir à gérer les editeurs comme dans l'application de transactions. Le Form en lui même est invisible, il ne rend rien à l'écran.
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  //avant on utilisait le TextField mais celui-ci fonctionne parfaitement avec les formuilaires. Ils sont automatiquement connectés au Form.
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction
                      .next, //permet de passer au TextFormField suivant sans avoir à soumettre tout le formulaire.
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(
                        _priceFocusNode); //Cela permet d'apporter le focus automatiquement sur la ligne de prix en tapant sur le bouton suivant du clavier
                  },
                ),
                TextFormField(
                    decoration: InputDecoration(labelText: 'Price'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    }),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onEditingComplete: () {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          /* child: ListView(
            children: [
              TextFormField(
                //avant on utilisait le TextField mais celui-ci fonctionne parfaitement avec les formuilaires. Ils sont automatiquement connectés au Form.
                decoration: InputDecoration(labelText: 'title'),
                textInputAction: TextInputAction
                    .next, //permet de passer au TextFormField suivant sans avoir à soumettre tout le formulaire.
              ),
              //TextFormField(),
            ],
          ), */
        ),
      ),
    );
  }
}
