package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Chapter;

public interface ChapterMapper {
	/*添加章信息信息*/
	public void addChapter(Chapter chapter) throws Exception;

	/*按照查询条件分页查询章信息记录*/
	public ArrayList<Chapter> queryChapter(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有章信息记录*/
	public ArrayList<Chapter> queryChapterList(@Param("where") String where) throws Exception;

	/*按照查询条件的章信息记录数*/
	public int queryChapterCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条章信息记录*/
	public Chapter getChapter(int id) throws Exception;

	/*更新章信息记录*/
	public void updateChapter(Chapter chapter) throws Exception;

	/*删除章信息记录*/
	public void deleteChapter(int id) throws Exception;

}
