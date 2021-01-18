import 'package:firebase_database/firebase_database.dart';

class OffersModel{
  String _offerId;

  String get offerId => _offerId;

  set offerId(String value) {
    _offerId = value;
  }

  String _canTravel;
  String _cashComp;
  String _offerDescription;
  String _offerTitle;
  String _offerdID;
  String _opId;
  String _postId;
  String _status;

   OffersModel();

   void setModelData(DataSnapshot dataSnapshot)
   {
     canTravel = dataSnapshot.value["canTravel"];
     cashComp = dataSnapshot.value["cashComp"];
     offerDescription = dataSnapshot.value["offerDescription"];
     offerTitle = dataSnapshot.value["offerTitle"];
     offerdID = dataSnapshot.value["offeredId"];
     opId = dataSnapshot.value["opId"];
     postId = dataSnapshot.value["postId"];
     status = dataSnapshot.value["status"];
   }
   String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get postId => _postId;

  set postId(String value) {
    _postId = value;
  }

  String get opId => _opId;

  set opId(String value) {
    _opId = value;
  }

  String get offerdID => _offerdID;

  set offerdID(String value) {
    _offerdID = value;
  }

  String get offerTitle => _offerTitle;

  set offerTitle(String value) {
    _offerTitle = value;
  }

  String get offerDescription => _offerDescription;

  set offerDescription(String value) {
    _offerDescription = value;
  }

  String get cashComp => _cashComp;

  set cashComp(String value) {
    _cashComp = value;
  }

  String get canTravel => _canTravel;

  set canTravel(String value) {
    _canTravel = value;
  }
}