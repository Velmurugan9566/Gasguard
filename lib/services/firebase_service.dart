import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/history_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<HistoryData>> fetchHistoricalData() {
    return _firestore.collection('sensorData')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs
            .map((doc) => HistoryData.fromMap(doc.data()))
            .toList()
    );
  }
}
