class CommentsData {
  String? comment1;

  CommentsData({
    this.comment1,
  });

  factory CommentsData.fromJson(Map<String, dynamic> parsedJson) {
    return CommentsData(
      comment1: parsedJson['comment1'] ?? "Try printing a comment",
    );
  }
}
