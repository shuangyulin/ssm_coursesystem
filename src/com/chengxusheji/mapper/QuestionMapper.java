package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Question;

public interface QuestionMapper {
	/*添加在线问答信息*/
	public void addQuestion(Question question) throws Exception;

	/*按照查询条件分页查询在线问答记录*/
	public ArrayList<Question> queryQuestion(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有在线问答记录*/
	public ArrayList<Question> queryQuestionList(@Param("where") String where) throws Exception;

	/*按照查询条件的在线问答记录数*/
	public int queryQuestionCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条在线问答记录*/
	public Question getQuestion(int id) throws Exception;

	/*更新在线问答记录*/
	public void updateQuestion(Question question) throws Exception;

	/*删除在线问答记录*/
	public void deleteQuestion(int id) throws Exception;

}
