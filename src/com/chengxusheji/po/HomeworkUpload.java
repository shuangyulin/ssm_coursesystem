package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class HomeworkUpload {
    /*记录编号*/
    private Integer uploadId;
    public Integer getUploadId(){
        return uploadId;
    }
    public void setUploadId(Integer uploadId){
        this.uploadId = uploadId;
    }

    /*作业标题*/
    private HomeworkTask homeworkTaskObj;
    public HomeworkTask getHomeworkTaskObj() {
        return homeworkTaskObj;
    }
    public void setHomeworkTaskObj(HomeworkTask homeworkTaskObj) {
        this.homeworkTaskObj = homeworkTaskObj;
    }

    /*提交的学生*/
    private Student studentObj;
    public Student getStudentObj() {
        return studentObj;
    }
    public void setStudentObj(Student studentObj) {
        this.studentObj = studentObj;
    }

    /*作业文件*/
    private String homeworkFile;
    public String getHomeworkFile() {
        return homeworkFile;
    }
    public void setHomeworkFile(String homeworkFile) {
        this.homeworkFile = homeworkFile;
    }

    /*提交时间*/
    @NotEmpty(message="提交时间不能为空")
    private String uploadTime;
    public String getUploadTime() {
        return uploadTime;
    }
    public void setUploadTime(String uploadTime) {
        this.uploadTime = uploadTime;
    }

    /*批改结果文件*/
    private String resultFile;
    public String getResultFile() {
        return resultFile;
    }
    public void setResultFile(String resultFile) {
        this.resultFile = resultFile;
    }

    /*批改时间*/
    @NotEmpty(message="批改时间不能为空")
    private String pigaiTime;
    public String getPigaiTime() {
        return pigaiTime;
    }
    public void setPigaiTime(String pigaiTime) {
        this.pigaiTime = pigaiTime;
    }

    /*是否批改*/
    @NotNull(message="必须输入是否批改")
    private Integer pigaiFlag;
    public Integer getPigaiFlag() {
        return pigaiFlag;
    }
    public void setPigaiFlag(Integer pigaiFlag) {
        this.pigaiFlag = pigaiFlag;
    }

    /*评语*/
    private String pingyu;
    public String getPingyu() {
        return pingyu;
    }
    public void setPingyu(String pingyu) {
        this.pingyu = pingyu;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonHomeworkUpload=new JSONObject(); 
		jsonHomeworkUpload.accumulate("uploadId", this.getUploadId());
		jsonHomeworkUpload.accumulate("homeworkTaskObj", this.getHomeworkTaskObj().getTitle());
		jsonHomeworkUpload.accumulate("homeworkTaskObjPri", this.getHomeworkTaskObj().getHomeworkId());
		jsonHomeworkUpload.accumulate("studentObj", this.getStudentObj().getName());
		jsonHomeworkUpload.accumulate("studentObjPri", this.getStudentObj().getStudentNumber());
		jsonHomeworkUpload.accumulate("homeworkFile", this.getHomeworkFile());
		jsonHomeworkUpload.accumulate("uploadTime", this.getUploadTime());
		jsonHomeworkUpload.accumulate("resultFile", this.getResultFile());
		jsonHomeworkUpload.accumulate("pigaiTime", this.getPigaiTime());
		jsonHomeworkUpload.accumulate("pigaiFlag", this.getPigaiFlag());
		jsonHomeworkUpload.accumulate("pingyu", this.getPingyu());
		return jsonHomeworkUpload;
    }}