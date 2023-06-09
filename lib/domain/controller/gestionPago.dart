import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class gestionPago {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<void> updateBalance(String userEmail, double newBalance) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('usuarios')
          .where('correo', isEqualTo: userEmail)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final DocumentSnapshot userDoc = snapshot.docs.first;
        await userDoc.reference
            .update({'saldo': userDoc['saldo'] - newBalance});
        print('Saldo actualizado en la base de datos.');
      } else {
        print('No se encontró ningún usuario con ese correo electrónico.');
      }
    } catch (e) {
      print('Error al actualizar el saldo: $e');
    }
  }
}
