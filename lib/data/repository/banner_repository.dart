import '../../common/http_client.dart';
import '../dataSource/banner_data_source.dart';
import '../model/BannerEntity.dart';



final bannerRepository = BannerRepository(BannerRemoteDataSource(httpClient));

abstract class IBannerRepository {
  Future<List<BannerEntity>> getAll(String accessTocken);
}

class BannerRepository implements IBannerRepository {
  final IBannerDataSource dataSource;

  BannerRepository(this.dataSource);

  @override
  Future<List<BannerEntity>> getAll(String accessTocken) => dataSource.getAll(accessTocken);
}