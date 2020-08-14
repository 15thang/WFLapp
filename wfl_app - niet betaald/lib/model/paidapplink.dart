class Store {
  String link, store, count;

  Store({
    this.link, this.store, this.count
  });

  Store.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    store = json['store'];
    count = '1';
  }
}

