import 'package:core_foundation/core/core.dart';
import '../entities/detail_item.dart';

abstract class DetailsRepository {
  Future<Result<List<DetailItem>>> getItems();
  Future<Result<void>> addItem(String name);
  Future<Result<void>> removeAt(int index);
  Future<Result<void>> clearAll();
  Future<Result<void>> reorder({required int oldIndex, required int newIndex});
}
