import 'dart:io';

import './macro_expert.dart';
import './micro_expert.dart';
import './text_expert.dart';

class DecisionForum{

  static final DecisionForum _instance = DecisionForum._internal();

  static DecisionForum get instance => _instance;

  MacroImageExpert? macroImageExpert;
  MicroImageExpert? microImageExpert;
  TextExpert? textExpert;
  
  DecisionForum._internal(){
    macroImageExpert = MacroImageExpert(expertUrl: 'https://mushroom.kindwise.com/api/v1/identification?details=edibility');
    microImageExpert = MicroImageExpert(expertUrl: 'https://alamo2-mushroom-model.hf.space/run/predict');
    textExpert = TextExpert(expertUrl: 'https://openrouter.ai/api/v1/chat/completions');
  }

  void selectMicroImage(File? microImage){
    this.microImageExpert?.setImage(microImage);
  }

  void selectMacroImage(File? macroImage){
    this.macroImageExpert?.setImage(macroImage);
  }

  void setFormInput(String field, String value){

  }

  bool? isMicroImageReady(){
    return this.microImageExpert?.canUseExpert();
  }

  bool? isMacroImageReady(){
    return this.macroImageExpert?.canUseExpert();
  }

}