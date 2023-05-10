package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Student;

public interface StudentMapper {
	/*添加学生信息信息*/
	public void addStudent(Student student) throws Exception;

	/*按照查询条件分页查询学生信息记录*/
	public ArrayList<Student> queryStudent(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有学生信息记录*/
	public ArrayList<Student> queryStudentList(@Param("where") String where) throws Exception;

	/*按照查询条件的学生信息记录数*/
	public int queryStudentCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条学生信息记录*/
	public Student getStudent(String studentNumber) throws Exception;

	/*更新学生信息记录*/
	public void updateStudent(Student student) throws Exception;

	/*删除学生信息记录*/
	public void deleteStudent(String studentNumber) throws Exception;

}
