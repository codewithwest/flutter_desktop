class PostsList {
  PostsList(
    this.id,
    this.post,
    this.likes,
  );
  late int id;
  late String post;
  late int likes;
}

double width = MediaQuery.of(context).size.width;
double height = MediaQuery.of(context).size.height;
