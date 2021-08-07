import 'package:floor/floor.dart';
import 'package:visual_novel_strider/entity/tag_entity.dart';

@dao
abstract class TagDao {
  @Query('select * from tags')
  Future<List<TagEntity>> findAllTags();

  @Query("select * from tags where id in (:id)")
  Future<List<TagEntity?>> findTagById(List<int> id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTag(TagEntity tagEntity);
}
