import 'dart:math';
import 'dart:ui';

import 'package:application/assets/constants.dart';
import 'package:application/assets/grid/item_card.dart';
import 'package:application/assets/widgets/custom_text_button.dart';
import 'package:application/data/element/datasource/element_remote.dart';
import 'package:application/data/element/element_model.dart';
import 'package:application/data/element/element_repository.dart';
import 'package:application/data/token/token_secure_storage.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:preload_page_view/preload_page_view.dart';

class RegisterCardsController extends GetxController with StateMixin {
  late ElementRepository repository = ElementRemote();

  RxList<Widget> question_widgets = RxList<Widget>();
  RxList<Widget> answers_widgets = RxList<Widget>();
  List<Elements> questions = [];
  List<Elements> answers = [];

  Rx<Elements?> question = Rx<Elements?>(null);
  RxList<Elements> selected = RxList<Elements>();

  late BuildContext context;

  TextEditingController search = TextEditingController();

  late List<List<PreloadPageController>> controllers;
  late PreloadPageController pagecontroller;

  RxInt page = 0.obs;

  RegisterCardsController({required this.context}) {
    change(null, status: RxStatus.loading());
    _loadElements();
    _loadControllers();
  }

  void _loadControllers() {
    pagecontroller =
        PreloadPageController(viewportFraction: 0.85, initialPage: 0);
    controllers = [
      [
        PreloadPageController(viewportFraction: 0.6, initialPage: 0),
        PreloadPageController(viewportFraction: 0.6, initialPage: 0),
      ],
      [
        PreloadPageController(viewportFraction: 0.6, initialPage: 0),
        PreloadPageController(viewportFraction: 0.6, initialPage: 0),
      ]
    ];
  }

  animatePage(int type, int index, int page) {
    controllers[type][index].animateToPage(page,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _loadElements() async {
    change(null, status: RxStatus.loading());

    try {
      var elements = await repository.findAllElements();
      if (elements != null) {
        questions = elements.where((element) => !element.type).toList();
        answers = elements.where((element) => element.type).toList();
      }
    } catch (e) {}
    _loadWidgets();
  }

  Future<CloudinaryResponse?> selectFile(
      TextEditingController edit, RxBool sending) async {
    CloudinaryResponse? response;
    try {
      var result =
          await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      sending.value = true;
      if (result != null) {
        if (result.path != null) {
          response = await uploadFileOnCloudinary(
            filePath: result.path,
            resourceType: CloudinaryResourceType.Auto,
          );

          if (response != null) {
            if (response.url != null) {
              String? id = await TokenSecureStorage.getId();
              Elements posted = await ElementRemote().postElement(
                  element: Elements(
                      id: -1,
                      creatorId: int.parse(id!),
                      text: edit.text,
                      figure: response.url,
                      video: response.url,
                      audio: response.url,
                      date: "data",
                      type: page.value == 1));
              if (page.value == 1) {
                answers.add(posted);
              } else {
                questions.add(posted);
              }
              Navigator.of(context, rootNavigator: true).pop();
              _loadWidgets();
            }
          } else {
            makeToast("Selecione uma imagem!");
          }

          return response;
        }
      } else {
        makeToast("Selecione uma imagem!");
      }
    } catch (e) {
      return null;
    }
  }

  void makeToast(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  Future<CloudinaryResponse?> uploadFileOnCloudinary(
      {required String filePath,
      required CloudinaryResourceType resourceType}) async {
    String result;
    CloudinaryResponse response;
    try {
      var cloudinary = CloudinaryPublic('ivo-code', 'ml_default', cache: false);
      response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(filePath, resourceType: resourceType),
      );
      return response;
    } on CloudinaryException catch (e, s) {
      return null;
    }
  }

  void input() {
    var el = _filterElements(search.value);
    if (page.value == 0)
      _loadWidgets(questions: el);
    else
      _loadWidgets(answers: el);
  }

  void showRegisterDialog() {
    RxBool isWrited = false.obs;
    RxBool sending = false.obs;
    TextEditingController edit = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        contentPadding: EdgeInsets.all(20),
        children: [
          ItemCard(
            glass: false,
            child: Obx(
              () => sending.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Constants.purple,
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 36,
                        ),
                        TextField(
                            controller: edit,
                            decoration: InputDecoration(
                                hintText: page.value == 0
                                    ? "Qual a sua pergunta?"
                                    : "Qual a sua resposta?",
                                hintStyle: GoogleFonts.raleway(
                                    color: Constants.purple,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400),
                                border: InputBorder.none,
                                fillColor: Constants.background),
                            textAlign: TextAlign.center,
                            onChanged: ((value) {
                              isWrited.value = value != "";
                            }),
                            cursorColor: Constants.purple,
                            style: GoogleFonts.raleway(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Constants.purple,
                            )),
                        Obx(
                          () => isWrited.value
                              ? SizedBox(
                                  height: 36,
                                )
                              : Container(),
                        ),
                        Obx(
                          () => isWrited.value
                              ? CustomTextButton(
                                  icon: Icons.photo,
                                  filled: true,
                                  title: "Insira uma imagem",
                                  color: Constants.purple,
                                  selected: true,
                                  detailed: true,
                                  press: () {
                                    selectFile(edit, sending);
                                  },
                                )
                              : Container(),
                        ),
                        SizedBox(
                          height: 36,
                        ),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }

  void _loadWidgets(
      {List<Elements>? questions, List<Elements>? answers}) async {
    questions ??= this.questions;
    answers ??= this.answers;
    _createSections(questions, question_widgets);
    _createSections(answers, answers_widgets);
  }

  _createSections(var elements, var widgets) {
    var cards = _getCards(
        elements,
        () => Opacity(
            opacity: 0.02 + (Random().nextInt(15) / 100),
            child: ItemCard(
              child: Container(),
            )));
    widgets.clear();

    for (var row = 0; row < 2; row++) {
      for (var col = 0; col < 4; col++) {
        widgets.add(Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            cards[col][row * 3],
            cards[col][row * 3 + 1],
            cards[col][row * 3 + 2]
          ],
        ));
      }
    }

    change(question_widgets, status: RxStatus.success());
  }

  _filterElements(TextEditingValue value) {
    if (page.value == 0) {
      return questions
          .where((i) => i.text.toUpperCase().contains(value.text.toUpperCase()))
          .toList();
    } else {
      return answers
          .where((i) => i.text.toUpperCase().contains(value.text.toUpperCase()))
          .toList();
    }
  }

  Widget _makeCard(Elements element) {
    return GestureDetector(
      onTap: () {
        if (questions.contains(element))
          question.value = element;
        else if (selected.contains(element))
          selected.remove(element);
        else
          selected.add(element);
        pagecontroller.animateToPage(1,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      },
      child: Obx(() => ItemCard(
          glass: element == question.value || selected.contains(element)
              ? false
              : true,
          child: Row(
            children: [
              Expanded(
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Constants.inactive,
                  foregroundImage: NetworkImage(element.figure),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Center(
                    child: Flexible(
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          element.text,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.raleway(
                            color: Constants.purple,
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ))),
    );
  }

  List<List<Widget>> _getCards(List<Elements> elements, Function placeholder) {
    List<List<Widget>> cards = [];
    List<Widget> items = [];

    for (var i = 0; i < elements.length; i++) {
      items.add(Expanded(
        child: _makeCard(elements[i]),
        flex: Random().nextInt(5) + 5,
      ));
    }

    for (var col = 0; col < 4; col++) {
      cards.add([]);
      for (var row = 0; row < 6; row++) {
        cards[col].add(items.isEmpty
            ? Expanded(
                flex: Random().nextInt(5) + 3,
                child: placeholder(),
              )
            : items.removeLast());
      }
    }

    return cards;
  }

  pagechange(int value) {
    page.value = value;
  }

  saveCard() {}
}
