import 'dart:io';

void clearScreen() => stdout.write('\x1B[2J');
void setPosition(int x, int y) => stdout.write('\x1B[$y;${x}H');
void setCharColor(int n) => stdout.write('\x1B[3${n}m');

var scores = [
  {'title': '味', 'value' : 10, 'color' : 2},
  {'title': '香り', 'value': 20, 'color' : 3},
  {'title': '辛さ', 'value' : 15, 'color' : 4},
];

Future draw () async {
  int i = 0;
  return Future.forEach(scores, (Map data) async { 
    setPosition(0, i+1);
    setCharColor(7);
    stdout.write(data['title']);
    setPosition(6, i+1);
    stdout.write(':');

    setPosition(8, i+1);
    setCharColor(data['color'] as int);
    String label = 
        data['title'] == '味' ? '😋'
        : data['title'] == '香り' ? '🌹'
        : '🌶️';
    for (var j = 0; j <= (data['value'] as int); j++) {
      setPosition(10 + j*2, i+1);
      await Future.delayed(Duration(milliseconds: 10));
      stdout.write(label);
      await stdout.flush();
    }
    i++;
  });


} 

void main(List<String> arguments) async {
  clearScreen();
  await draw();

  setPosition(0, 4);
  setCharColor(7);
  stdout.write("\n\n~~ finish ~~~\n\n");
  await stdout.flush();
}
