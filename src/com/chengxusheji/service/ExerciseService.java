package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Chapter;
import com.chengxusheji.po.Exercise;

import com.chengxusheji.mapper.ExerciseMapper;
@Service
public class ExerciseService {

	@Resource ExerciseMapper exerciseMapper;
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

    /*添加习题信息记录*/
    public void addExercise(Exercise exercise) throws Exception {
    	exerciseMapper.addExercise(exercise);
    }

    /*按照查询条件分页查询习题信息记录*/
    public ArrayList<Exercise> queryExercise(String title,Chapter chapterId,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_exercise.title like '%" + title + "%'";
    	if(null != chapterId && chapterId.getId()!= null && chapterId.getId()!= 0)  where += " and t_exercise.chapterId=" + chapterId.getId();
    	int startIndex = (currentPage-1) * this.rows;
    	return exerciseMapper.queryExercise(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Exercise> queryExercise(String title,Chapter chapterId) throws Exception  { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_exercise.title like '%" + title + "%'";
    	if(null != chapterId && chapterId.getId()!= null && chapterId.getId()!= 0)  where += " and t_exercise.chapterId=" + chapterId.getId();
    	return exerciseMapper.queryExerciseList(where);
    }

    /*查询所有习题信息记录*/
    public ArrayList<Exercise> queryAllExercise()  throws Exception {
        return exerciseMapper.queryExerciseList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String title,Chapter chapterId) throws Exception {
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_exercise.title like '%" + title + "%'";
    	if(null != chapterId && chapterId.getId()!= null && chapterId.getId()!= 0)  where += " and t_exercise.chapterId=" + chapterId.getId();
        recordNumber = exerciseMapper.queryExerciseCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取习题信息记录*/
    public Exercise getExercise(int id) throws Exception  {
        Exercise exercise = exerciseMapper.getExercise(id);
        return exercise;
    }

    /*更新习题信息记录*/
    public void updateExercise(Exercise exercise) throws Exception {
        exerciseMapper.updateExercise(exercise);
    }

    /*删除一条习题信息记录*/
    public void deleteExercise (int id) throws Exception {
        exerciseMapper.deleteExercise(id);
    }

    /*删除多条习题信息信息*/
    public int deleteExercises (String ids) throws Exception {
    	String _ids[] = ids.split(",");
    	for(String _id: _ids) {
    		exerciseMapper.deleteExercise(Integer.parseInt(_id));
    	}
    	return _ids.length;
    }
}
