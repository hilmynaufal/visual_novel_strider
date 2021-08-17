import 'package:floor/floor.dart';
import 'package:visual_novel_strider/entity/trait_entity.dart';

@dao
abstract class TraitsDao {
  @Query('select * from traits')
  Future<List<TraitEntity>> findAllTags();

  @Query("select * from traits where id in (:id)")
  Future<List<TraitEntity?>> findTraitsById(List<int> id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTraits(TraitEntity tagEntity);
}
