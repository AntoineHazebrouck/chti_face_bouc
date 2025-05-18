class MembersCollection {
  static const collection = "members";

  static const firstname = "name";
  static const lastname = "surname";
  static const description = "description";
  static const profilePictureUrl = "profilePicture";
  static const coverPictureUrl = "coverPicture";
}

class PostsCollection {
  static const collection = "posts";

  static const text = "text";
  static const date = "date";
  static const likes = "likes";
  static const imageUrl = "image";
  static const memberId = "memberId";
}

class CommentsCollection {
  static const collection = "comments";

  static const text = "text";
  static const date = "date";
  static const memberId = "memberId";
}

class NotifsCollection {
  static const collection = "notifications";

  static const from = "from";
  static const text = "text";
  static const postId = "postID";
  static const isRead = "read";
  static const date = "date";
}
