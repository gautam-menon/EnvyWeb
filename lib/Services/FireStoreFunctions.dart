import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreFunctions {
  String status = 'STATUS';
  Future getStatus() async {
    return FirebaseFirestore.instance.collection(status).snapshots();
  }

  Future<bool> addStatus(
      String choice, String name, String editorId, String orderId) async {
    try {
      Map<String, dynamic> message = {
        'message': statusSetting(choice, name, orderId),
        'time': DateTime.now().millisecondsSinceEpoch,
        'editorId': editorId
      };
      await FirebaseFirestore.instance.collection(status).add(message);
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  String statusSetting(choice, editorId, orderId) {
    switch (choice) {
      case 'accepted':
        return editorId + " has accepted order: " + orderId;
        break;
      case 'declined':
        return editorId + " has declined order: " + orderId;
        break;
      // case 'deadlineReached':
      //   return name + " with " + orderId + " has crossed the deadline.";
      //   break;
      default:
        return "Invalid status";
        break;
    }
  }

  Future<bool> deleteStatus(String docId) async {
    try {
      await FirebaseFirestore.instance.collection(status).doc(docId).delete();
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }
}
