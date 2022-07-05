import 'package:cloud_firestore/cloud_firestore.dart';
import 'CarouselModel.dart';


class BannerService {
  final bannersRef = FirebaseFirestore.instance.collection('banner').withConverter<CarouselModel>(
    fromFirestore: (snapshot, _) => CarouselModel.fromJson(snapshot.data()!),
    toFirestore: (movie, _) => movie.toJson(),
  );

  Future<List<CarouselModel>> getBanners() async {
    var querySnapshot = await bannersRef.get();
    var carouselItemList =  querySnapshot.docs.map((doc) => doc.data()).toList();
    return carouselItemList;
  }
}