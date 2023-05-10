package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.CourseInfo;

import com.chengxusheji.mapper.CourseInfoMapper;
@Service
public class CourseInfoService {

	@Resource CourseInfoMapper courseInfoMapper;
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

    /*添加课程信息记录*/
    public void addCourseInfo(CourseInfo courseInfo) throws Exception {
    	courseInfoMapper.addCourseInfo(courseInfo);
    }

    /*按照查询条件分页查询课程信息记录*/
    public ArrayList<CourseInfo> queryCourseInfo(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return courseInfoMapper.queryCourseInfo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<CourseInfo> queryCourseInfo() throws Exception  { 
     	String where = "where 1=1";
    	return courseInfoMapper.queryCourseInfoList(where);
    }

    /*查询所有课程信息记录*/
    public ArrayList<CourseInfo> queryAllCourseInfo()  throws Exception {
        return courseInfoMapper.queryCourseInfoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = courseInfoMapper.queryCourseInfoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取课程信息记录*/
    public CourseInfo getCourseInfo(int id) throws Exception  {
        CourseInfo courseInfo = courseInfoMapper.getCourseInfo(id);
        return courseInfo;
    }

    /*更新课程信息记录*/
    public void updateCourseInfo(CourseInfo courseInfo) throws Exception {
        courseInfoMapper.updateCourseInfo(courseInfo);
    }

    /*删除一条课程信息记录*/
    public void deleteCourseInfo (int id) throws Exception {
        courseInfoMapper.deleteCourseInfo(id);
    }

    /*删除多条课程信息信息*/
    public int deleteCourseInfos (String ids) throws Exception {
    	String _ids[] = ids.split(",");
    	for(String _id: _ids) {
    		courseInfoMapper.deleteCourseInfo(Integer.parseInt(_id));
    	}
    	return _ids.length;
    }
}
