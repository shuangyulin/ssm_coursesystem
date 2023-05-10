package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Teacher;
import com.chengxusheji.po.Question;

import com.chengxusheji.mapper.QuestionMapper;
@Service
public class QuestionService {

	@Resource QuestionMapper questionMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加在线问答记录*/
    public void addQuestion(Question question) throws Exception {
    	questionMapper.addQuestion(question);
    }

    /*按照查询条件分页查询在线问答记录*/
    public ArrayList<Question> queryQuestion(Teacher teacherId,String questioner,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != teacherId && teacherId.getId()!= null && teacherId.getId()!= 0)  where += " and t_question.teacherId=" + teacherId.getId();
    	if(!questioner.equals("")) where = where + " and t_question.questioner like '%" + questioner + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return questionMapper.queryQuestion(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Question> queryQuestion(Teacher teacherId,String questioner) throws Exception  { 
     	String where = "where 1=1";
    	if(null != teacherId && teacherId.getId()!= null && teacherId.getId()!= 0)  where += " and t_question.teacherId=" + teacherId.getId();
    	if(!questioner.equals("")) where = where + " and t_question.questioner like '%" + questioner + "%'";
    	return questionMapper.queryQuestionList(where);
    }

    /*查询所有在线问答记录*/
    public ArrayList<Question> queryAllQuestion()  throws Exception {
        return questionMapper.queryQuestionList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Teacher teacherId,String questioner) throws Exception {
     	String where = "where 1=1";
    	if(null != teacherId && teacherId.getId()!= null && teacherId.getId()!= 0)  where += " and t_question.teacherId=" + teacherId.getId();
    	if(!questioner.equals("")) where = where + " and t_question.questioner like '%" + questioner + "%'";
        recordNumber = questionMapper.queryQuestionCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取在线问答记录*/
    public Question getQuestion(int id) throws Exception  {
        Question question = questionMapper.getQuestion(id);
        return question;
    }

    /*更新在线问答记录*/
    public void updateQuestion(Question question) throws Exception {
        questionMapper.updateQuestion(question);
    }

    /*删除一条在线问答记录*/
    public void deleteQuestion (int id) throws Exception {
        questionMapper.deleteQuestion(id);
    }

    /*删除多条在线问答信息*/
    public int deleteQuestions (String ids) throws Exception {
    	String _ids[] = ids.split(",");
    	for(String _id: _ids) {
    		questionMapper.deleteQuestion(Integer.parseInt(_id));
    	}
    	return _ids.length;
    }
}
