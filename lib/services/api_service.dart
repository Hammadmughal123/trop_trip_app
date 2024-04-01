import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../utils/enums.dart';
import '../utils/helpers.dart';

class APIService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Define callbacks for state changes
  Function(User?)? onUserChanged;
  Function(String)? onError;

  // Constructor: Listen to auth state changes
  APIService() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(User? user) {
    if (onUserChanged != null) {
      onUserChanged!(user);
    }
  }

  // Generic method to handle errors
  void _handleError(Exception e) {
    if (onError != null) {
      onError!(e.toString());
    }
  }

  // Email & Password Sign Up
  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
       AuthResultStatus status = AuthExceptionHandler.handleException(e);
      String errorMessage = AuthExceptionHandler.generateErrorMessage(status);
      // Display the errorMessage to the user
      _handleError(e);
    }
  }

  // Email & Password Sign In
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _handleError(e);
    }
  }

  // Google Sign In
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User cancelled the sign in process
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final  credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _handleError(e);
    }
  }

  // Facebook Sign In
  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status != LoginStatus.success)
        return null; // User cancelled the sign in process
      final  credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _handleError(e);
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    }on FirebaseAuthException catch (e) {
      _handleError(e);
    }
  }

 // Firestore: Add a new document to a collection
  Future<void> addDocumentToCollection(
      String collectionPath, Map<String, dynamic> data) async {
    await _firestore.collection(collectionPath).add(data);
  }

  // Firestore: Update a document
  Future<void> updateDocument(
      String collectionPath, String docId, Map<String, dynamic> data) async {
    await _firestore.collection(collectionPath).doc(docId).update(data);
  }

  // Firestore: Delete a document
  Future<void> deleteDocument(String collectionPath, String docId) async {
    await _firestore.collection(collectionPath).doc(docId).delete();
  }

  // Firestore: Get a single document by ID
  Future<DocumentSnapshot> getDocumentById(
      String collectionPath, String docId) async {
    return await _firestore.collection(collectionPath).doc(docId).get();
  }

  // Firestore: Get documents with a query
  Future<QuerySnapshot> getDocumentsWithQuery(
      String collectionPath, Map<String, dynamic> queryParams) async {
    CollectionReference collection = _firestore.collection(collectionPath);
    Query query = collection;
    queryParams.forEach((key, value) {
      query = query.where(key, isEqualTo: value);
    });
    return await query.get();
  }
}
