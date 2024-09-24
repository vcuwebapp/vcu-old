class UserData {
  final String uid;
  final String std;
  final String feespaid;
  final String batch;
  final String name;
  final String batchname;

  UserData(
      {required this.uid,
        required this.batchname,
      required this.std,
      required this.batch,
      required this.feespaid,
      required this.name});
}

// final UserData tejas = UserData(uid: uid, std: std, batch: batch, feespaid: feespaid, name: name)
