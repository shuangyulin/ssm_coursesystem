package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.CourseInfo;

public interface CourseInfoMapper {
	/*添加课程信息信息*/
	public void addCourseInfo(CourseInfo courseInfo) throws Exception;

	/*按照查询条件分页查询课程信息记录*/
	public ArrayList<CourseInfo> queryCourseInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有课程信息记录*/
	public ArrayList<CourseInfo> queryCourseInfoList(@Param("where") String where) throws Exception;

	/*按照查询条件的课程信息记录数*/
	public int queryCourseInfoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条课程信息记录*/
	public CourseInfo getCourseInfo(int id) throws Exception;

	/*更新课程信息记录*/
	public void updateCourseInfo(CourseInfo courseInfo) throws Exception;

	/*删除课程信息记录*/
	public void deleteCourseInfo(int id) throws Exception;

}
