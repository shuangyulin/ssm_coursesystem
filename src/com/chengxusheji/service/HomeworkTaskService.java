package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Teacher;
import com.chengxusheji.po.HomeworkTask;

import com.chengxusheji.mapper.HomeworkTaskMapper;
@Service
public class HomeworkTaskService {

	@Resource HomeworkTaskMapper homeworkTaskMapper;
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

    /*添加作业任务记录*/
    public void addHomeworkTask(HomeworkTask homeworkTask) throws Exception {
    	homeworkTaskMapper.addHomeworkTask(homeworkTask);
    }

    /*按照查询条件分页查询作业任务记录*/
    public ArrayList<HomeworkTask> queryHomeworkTask(Teacher teacherObj,String title,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != teacherObj && teacherObj.getId()!= null && teacherObj.getId()!= 0)  where += " and t_homeworkTask.teacherObj=" + teacherObj.getId();
    	if(!title.equals("")) where = where + " and t_homeworkTask.title like '%" + title + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return homeworkTaskMapper.queryHomeworkTask(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<HomeworkTask> queryHomeworkTask(Teacher teacherObj,String title) throws Exception  { 
     	String where = "where 1=1";
    	if(null != teacherObj && teacherObj.getId()!= null && teacherObj.getId()!= 0)  where += " and t_homeworkTask.teacherObj=" + teacherObj.getId();
    	if(!title.equals("")) where = where + " and t_homeworkTask.title like '%" + title + "%'";
    	return homeworkTaskMapper.queryHomeworkTaskList(where);
    }

    /*查询所有作业任务记录*/
    public ArrayList<HomeworkTask> queryAllHomeworkTask()  throws Exception {
        return homeworkTaskMapper.queryHomeworkTaskList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Teacher teacherObj,String title) throws Exception {
     	String where = "where 1=1";
    	if(null != teacherObj && teacherObj.getId()!= null && teacherObj.getId()!= 0)  where += " and t_homeworkTask.teacherObj=" + teacherObj.getId();
    	if(!title.equals("")) where = where + " and t_homeworkTask.title like '%" + title + "%'";
        recordNumber = homeworkTaskMapper.queryHomeworkTaskCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取作业任务记录*/
    public HomeworkTask getHomeworkTask(int homeworkId) throws Exception  {
        HomeworkTask homeworkTask = homeworkTaskMapper.getHomeworkTask(homeworkId);
        return homeworkTask;
    }

    /*更新作业任务记录*/
    public void updateHomeworkTask(HomeworkTask homeworkTask) throws Exception {
        homeworkTaskMapper.updateHomeworkTask(homeworkTask);
    }

    /*删除一条作业任务记录*/
    public void deleteHomeworkTask (int homeworkId) throws Exception {
        homeworkTaskMapper.deleteHomeworkTask(homeworkId);
    }

    /*删除多条作业任务信息*/
    public int deleteHomeworkTasks (String homeworkIds) throws Exception {
    	String _homeworkIds[] = homeworkIds.split(",");
    	for(String _homeworkId: _homeworkIds) {
    		homeworkTaskMapper.deleteHomeworkTask(Integer.parseInt(_homeworkId));
    	}
    	return _homeworkIds.length;
    }
}
