import 'dart:math';

class T1<E1> {
  E1 item1;
}

class T2<E1, E2> {
  E1 item1;
  E2 item2;
}

class LimitedQueue<T> {
  var _indexPush = 0;
  int _indexPop;
  bool _full = false;
  get full => _full;
  final int length;
  final List<T> _content;

  LimitedQueue(this.length)
      : _content = List(length),
        _indexPop = length - 1;

  void push(T item) {
    _content[_indexPush] = item;
    _indexPush = (_indexPush + 1) % length;
    if (_indexPush == 0) _full = true;
  }

  T pop() {
    _indexPop = (_indexPop + 1) % length;
    return _content[_indexPop];
  }

  List<T> part(double fraction, [index = 0]) {
    int l = full ? length * fraction ~/ 1 : _indexPush * fraction ~/ 1;
    final int i = index * l;
    l = min(i + l, length) - i;
    return List.generate(l, (index) => _content[i + index]);
  }
}
