import 'package:food_app/model/product_model.dart';
import 'package:food_app/repository/popular_product_repository.dart';
import 'package:get/get.dart';

import '../repository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepository recommendedProductRepository;


  RecommendedProductController({required this.recommendedProductRepository});


  List<ProductsModel> _recommendedProductList=[];
  List<ProductsModel> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList()async {
    Response response = await recommendedProductRepository.getRecommendedProductList();

    try{


      if(response.statusCode==200){
        print("Got products from the server");
        _recommendedProductList=[];
        _recommendedProductList.addAll(Product.fromJson(response.body).products);
        print(_recommendedProductList);
        _isLoaded = true;
        update();
      }
      else{
        print("Error occurred and the error is "+response.body);
      }
    }catch(e){
      print("Error in the controller is "+e.toString());
    }
  }
}