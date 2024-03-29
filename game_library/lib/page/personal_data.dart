import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';
import 'package:game_library/model/personal_model.dart';
import 'package:game_library/services/file_storage.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({Key? key}) : super(key: key);

  @override
  State<PersonalData> createState() => _PersonalData();
}

class _PersonalData extends State<PersonalData> {
  int _activeStep = 0;
  String? name, mail, password;
  List<Step> allSteps = [];
  List<String> selectTypeGame = List.filled(4, "null");
  var key0 = GlobalKey<FormFieldState>();
  var key1 = GlobalKey<FormFieldState>();
  var key2 = GlobalKey<FormFieldState>();
  bool checkBoxState1 = false,
      checkBoxState3 = false,
      checkBoxState2 = false,
      checkBoxState4 = false;

  TextEditingController nameText = TextEditingController();
  TextEditingController mailText = TextEditingController();

  bool error = false;
  final FileStorageServices _fileStorageServices = FileStorageServices();

  @override
  void initState() {
    super.initState();
    _dataRead();
  }

  @override
  Widget build(BuildContext context) {
    allSteps = _stepList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Verileriniz",
          style: ConstantsStyles.titleStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Stepper(
          steps: allSteps,
          currentStep: _activeStep,
          onStepContinue: () {
            if (_activeStep < allSteps.length) {
              setState(() {
                _nextButton();
              });
            }
          },
          onStepCancel: () {
            if (_activeStep > 0) {
              setState(() {
                _activeStep--;
              });
            }
          },
        ),
      ),
    );
  }

  List<Step> _stepList() {
    List<Step> stepler = [
      Step(
          title: const Text("Kullanıcı İsminizi Giriniz"),
          subtitle: const Text("örnek : user5421"),
          state: _statestatus(0),
          isActive: true,
          content: Column(
            children: [
              TextFormField(
                controller: nameText,
                key: key0,
                decoration: const InputDecoration(
                    hintText: "Kullanıcı adı", border: OutlineInputBorder()),
                validator: (value) {
                  if (value!.length < 6) {
                    return "En az 6 karakter giriniz";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  name = value;
                },
              ),
              const SizedBox(height: 15),
              Text(
                "En sevdiğiniz Oyun türlerini seçiniz : ",
                style: ConstantsStyles.textStyle,
              ),
              CheckboxListTile(
                value: checkBoxState1,
                onChanged: (value) {
                  setState(() {
                    checkBoxState1 = value!;
                    selectTypeGame[0] = value ? "Aksiyon" : "null";
                  });
                },
                title: const Text("Aksiyon Oyunları"),
              ),
              CheckboxListTile(
                value: checkBoxState2,
                onChanged: (value) {
                  setState(() {
                    checkBoxState2 = value!;
                    selectTypeGame[1] = value ? "Macera" : "null";
                  });
                },
                title: const Text("Macera Oyunları"),
              ),
              CheckboxListTile(
                value: checkBoxState3,
                onChanged: (value) {
                  setState(() {
                    checkBoxState3 = value!;
                    selectTypeGame[2] = value ? "Savaş" : "null";
                  });
                },
                title: const Text("Savaş Oyunları"),
              ),
              CheckboxListTile(
                value: checkBoxState4,
                onChanged: (value) {
                  setState(() {
                    checkBoxState4 = value!;
                    selectTypeGame[3] = value ? "Strateji" : "null";
                  });
                },
                title: const Text("Strateji Oyunları"),
              )
            ],
          )),
      Step(
          title: const Text("Lütfen mail adresini giriniz"),
          subtitle: const Text("örnek : exp@example.com"),
          state: _statestatus(1),
          isActive: true,
          content: TextFormField(
            controller: mailText,
            keyboardType: TextInputType.emailAddress,
            key: key1,
            decoration: const InputDecoration(
                hintText: "Mail", border: OutlineInputBorder()),
            validator: (value) {
              if (value!.length < 6 || !value.contains("@")) {
                return "Geçerli bir mail adresi giriniz";
              } else {
                return null;
              }
            },
            onSaved: (inputValue) {
              mail = inputValue;
            },
          )),
      Step(
          title: const Text("Şifrenizi Belirleyiniz"),
          subtitle: const Text("Tahmin edilemeyecek bir şifre oluşturunuz "),
          state: _statestatus(2),
          isActive: true,
          content: TextFormField(
            key: key2,
            obscureText: true,
            decoration: const InputDecoration(
                hintText: "Şifre", border: OutlineInputBorder()),
            validator: (value) {
              if (value!.length < 6) {
                return "En az 6 karakter giriniz";
              } else {
                return null;
              }
            },
            onSaved: (inputValue) {
              password = inputValue;
            },
          )),
    ];
    return stepler;
  }

  StepState _statestatus(int currentStep) {
    if (_activeStep == currentStep) {
      if (error) {
        return StepState.error;
      } else {
        return StepState.editing;
      }
    } else {
      return StepState.complete;
    }
  }

  void _nextButton() {
    switch (_activeStep) {
      case 0:
        if (key0.currentState!.validate()) {
          key0.currentState!.save();
          error = false;
          _activeStep = 1;
        } else {
          error = true;
        }

        break;
      case 1:
        if (key1.currentState!.validate()) {
          key1.currentState!.save();
          error = false;
          _activeStep = 2;
        } else {
          error = true;
        }

        break;
      case 2:
        if (key2.currentState!.validate()) {
          key2.currentState!.save();
          error = false;
          _activeStep = 2;
          List<String> newList = [];
          for (var i = 0; i < 4; i++) {
            if (selectTypeGame[i] != "null") {
              newList.add(selectTypeGame[i]);
            }
          }
          PersonalModel personel = PersonalModel(name!, mail!, newList);
          _fileStorageServices.dataInsert(personel);

          setState(() {
            _showMyDialog();
          });
        } else {
          error = true;
        }

        break;
    }
  }

  Future<void> _showMyDialog() async {
    List<String> newList = [];
    for (var i = 0; i < 4; i++) {
      if (selectTypeGame[i] != "null") {
        newList.add(selectTypeGame[i]);
      }
    }
    return showDialog<void>(
      context: context,

      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kişisel Bilgileriniz'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(name!),
                Text(mail!),
                for (var item in newList) Text(item)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _dataRead() async {
    var data = await _fileStorageServices.dataRead();
    name = data.name;
    mail = data.mail;
    mailText.text = data.mail;
    nameText.text = data.name;
    setState(() {});
  }
}
