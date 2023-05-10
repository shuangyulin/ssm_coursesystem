package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.HomeworkTask;

public interface HomeworkTaskMapper {
	/*添加作业任务信息*/
	public void addHomeworkTask(HomeworkTask homeworkTask) throws Exception;

	/*按照查询条件分页查询作业任务记录*/
	public ArrayList<HomeworkTask> queryHomeworkTask(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有作业任务记录*/
	public ArrayList<HomeworkTask> queryHomeworkTaskList(@Param("where") String where) throws Exception;

	/*按照查询条件的作业任务记录数*/
	public int queryHomeworkTaskCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条作业任务记录*/
	public HomeworkTask getHomeworkTask(int homeworkId) throws Exception;

	/*更新作业任务记录*/
	public void updateHomeworkTask(HomeworkTask homeworkTask) throws Exception;

	/*删除作业任务记录*/
	public void deleteHomeworkTask(int homeworkId) throws Exception;

}
