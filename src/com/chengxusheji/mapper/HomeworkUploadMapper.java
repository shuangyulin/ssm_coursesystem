package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.HomeworkUpload;

public interface HomeworkUploadMapper {
	/*添加上传的作业信息*/
	public void addHomeworkUpload(HomeworkUpload homeworkUpload) throws Exception;

	/*按照查询条件分页查询上传的作业记录*/
	public ArrayList<HomeworkUpload> queryHomeworkUpload(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有上传的作业记录*/
	public ArrayList<HomeworkUpload> queryHomeworkUploadList(@Param("where") String where) throws Exception;

	/*按照查询条件的上传的作业记录数*/
	public int queryHomeworkUploadCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条上传的作业记录*/
	public HomeworkUpload getHomeworkUpload(int uploadId) throws Exception;

	/*更新上传的作业记录*/
	public void updateHomeworkUpload(HomeworkUpload homeworkUpload) throws Exception;

	/*删除上传的作业记录*/
	public void deleteHomeworkUpload(int uploadId) throws Exception;

}
