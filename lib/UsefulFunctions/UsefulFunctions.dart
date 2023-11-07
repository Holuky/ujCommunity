
import 'dart:math';

String getRandomPassword(int _length) {
  var _random = Random();
  //무조건 들어갈 문자종류(문자,숫자,특수기호)의 위치를 기억할 리스트
  var leastCharacterIndex = [];
  var min = 0x21; //start ascii  사용할 아스키 문자의 시작
  var max = 0x7A; //end ascii    사용할 아스키 문자의 끝
  var dat = [];   //비밀번호 저장용 리스트
  var skipCharacter = [0x2F,];
  while(dat.length <= _length) { //무작위로 20개를 생성한다
    var tmp = min + _random.nextInt(max - min); //랜덤으로 아스키값 받기
    if(skipCharacter.contains(tmp)) {
      continue;
    }
    dat.add(tmp); //dat 리스트에 추가
  }

  return String.fromCharCodes(dat.cast<int>());
}