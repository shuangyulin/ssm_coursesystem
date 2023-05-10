package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.HomeworkTask;
import com.chengxusheji.po.Student;
import com.chengxusheji.po.HomeworkUpload;

import com.chengxusheji.mapper.HomeworkUploadMapper;
@Service
public class HomeworkUploadService {

	@Resource HomeworkUploadMapper homeworkUploadMapper;
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

    /*添加上传的作业记录*/
    public void addHomeworkUpload(HomeworkUpload homeworkUpload) throws Exception {
    	homeworkUploadMapper.addHomeworkUpload(homeworkUpload);
    }

    /*按照查询条件分页查询上传的作业记录*/
    public ArrayList<HomeworkUpload> queryHomeworkUpload(HomeworkTask homeworkTaskObj,Student studentObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != homeworkTaskObj && homeworkTaskObj.getHomeworkId()!= null && homeworkTaskObj.getHomeworkId()!= 0)  where += " and t_homeworkUpload.homeworkTaskObj=" + homeworkTaskObj.getHomeworkId();
    	if(null != studentObj &&  studentObj.getStudentNumber() != null  && !studentObj.getStudentNumber().equals(""))  where += " and t_homeworkUpload.studentObj='" + studentObj.getStudentNumber() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return homeworkUploadMapper.queryHomeworkUpload(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<HomeworkUpload> queryHomeworkUpload(HomeworkTask homeworkTaskObj,Student studentObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != homeworkTaskObj && homeworkTaskObj.getHomeworkId()!= null && homeworkTaskObj.getHomeworkId()!= 0)  where += " and t_homeworkUpload.homeworkTaskObj=" + homeworkTaskObj.getHomeworkId();
    	if(null != studentObj &&  studentObj.getStudentNumber() != null && !studentObj.getStudentNumber().equals(""))  where += " and t_homeworkUpload.studentObj='" + studentObj.getStudentNumber() + "'";
    	return homeworkUploadMapper.queryHomeworkUploadList(where);
    }

    /*查询所有上传的作业记录*/
    public ArrayList<HomeworkUpload> queryAllHomeworkUpload()  throws Exception {
        return homeworkUploadMapper.queryHomeworkUploadList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(HomeworkTask homeworkTaskObj,Student studentObj) throws Exception {
     	String where = "where 1=1";
    	if(null != homeworkTaskObj && homeworkTaskObj.getHomeworkId()!= null && homeworkTaskObj.getHomeworkId()!= 0)  where += " and t_homeworkUpload.homeworkTaskObj=" + homeworkTaskObj.getHomeworkId();
    	if(null != studentObj &&  studentObj.getStudentNumber() != null && !studentObj.getStudentNumber().equals(""))  where += " and t_homeworkUpload.studentObj='" + studentObj.getStudentNumber() + "'";
        recordNumber = homeworkUploadMapper.queryHomeworkUploadCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取上传的作业记录*/
    public HomeworkUpload getHomeworkUpload(int uploadId) throws Exception  {
        HomeworkUpload homeworkUpload = homeworkUploadMapper.getHomeworkUpload(uploadId);
        return homeworkUpload;
    }

    /*更新上传的作业记录*/
    public void updateHomeworkUpload(HomeworkUpload homeworkUpload) throws Exception {
        homeworkUploadMapper.updateHomeworkUpload(homeworkUpload);
    }

    /*删除一条上传的作业记录*/
    public void deleteHomeworkUpload (int uploadId) throws Exception {
        homeworkUploadMapper.deleteHomeworkUpload(uploadId);
    }

    /*删除多条上传的作业信息*/
    public int deleteHomeworkUploads (String uploadIds) throws Exception {
    	String _uploadIds[] = uploadIds.split(",");
    	for(String _uploadId: _uploadIds) {
    		homeworkUploadMapper.deleteHomeworkUpload(Integer.parseInt(_uploadId));
    	}
    	return _uploadIds.length;
    }
}
