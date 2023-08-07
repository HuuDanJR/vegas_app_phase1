class BaseModel<T> {
  List<T>? listModel;

// String pyramidPoinToJson(List<PyramidPoint> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  BaseModel({this.listModel});
  BaseModel<T> fromJson(Map<String, dynamic> mapJson, Function fromJson) {
    final items = mapJson['table'].cast<Map<String, dynamic>>();
    return BaseModel<T>(
      listModel: List<T>.from(
        items.map((itemsJson) => fromJson(itemsJson)),
      ),
    );
  }
}
