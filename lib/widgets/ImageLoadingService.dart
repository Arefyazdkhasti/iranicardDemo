import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageLoadingService extends StatelessWidget {
  const ImageLoadingService({super.key, required this.imageUrl, this.borderRadius});

  final String imageUrl;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
          imageUrl: imageUrl,
          httpHeaders: const {
            "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI2NDgwMmEyODE2MWQwMzE1YzMwN2ZmMzIiLCJqdGkiOiI0NTQwMmYxZTdmYjMzYjZmZjJjNzI1YjU0NzAyYmFmZTM1YjM4ZWY2NWI1MjZiZmZjNTI4NjU4NjVlMmNlZjIwMmI3YTA3Mjc4MmUzNWI1MCIsImlhdCI6MTY4NjEzMTE5Ni41OTI0NDQsIm5iZiI6MTY4NjEzMTE5Ni41OTI0NiwiZXhwIjoxNzE3NzUzNTk2LjU2NTU1NCwic3ViIjoiNjIyNWI1NDc2NWI0YWI1MzU0NDk4ZWFjIiwic2NvcGVzIjpbXX0.7sEgtXYi1DiwNBDlCkqVR3SMFpK5LWv_KA2Z6FXxeElQiS15JqunZJ9sL-9uP-dEo_SMzFqQKEmKmp0sazTwI3nSDr8KYtnUOXlF1VgsQgGAHwwTxf8pKac-gars84Co1WCFa3MZhEIcF1x-s1cnBpk74tK7uuL18Oir51mVTdXFAyuofU3AajoODaxJMwpB5rCnzRUTOG5YUnNKJ4PcMfGTOPddAkvHE4Zl-VIAJfWDa6mmY3QyCibE6ylHGUkaBWKoV323FLD6-Lj1sMn1EfdnICJPpAiKqjhuYz35YYD7G2MrBXozMTBKRGxyLa-RQs8hXiPFHw3qB9O5aWmQOtn2T9-4L81CdifLMdUdcogz9d2XzU0tVBHUnh_LMdMZcRt3agZm0utEjNhUT9ph8cVUgMnuKtcjEZbvrTaUyDbSKw-CE5N5-7484aWhRgD7WWev1qhrDC8yATcwdxi9wrtPZTmU_xnj083HpRQ7qjeEDYhE_PzjJs7rNMhb7RmE4r92xaOEFc0e6bs2GfrVobna6kwtKDWe7Wzb9O8pJfJTAlPJzx7_MgYLhc75CKjBOrv-vFbxYrWp-OigSrIVkB1TEhESRMXnpvynYH6IcX9zUvat387df-NlN3EOLbNi9KTG2NFxr08uFHc82upCLd0rvUrKNPjLcVYwwGZ-ZFU"
          },
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => Container(color: Colors.red)),
    );
  }
}
