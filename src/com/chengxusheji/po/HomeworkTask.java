package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class HomeworkTask {
    /*记录编号*/
    private Integer homeworkId;
    public Integer getHomeworkId(){
        return homeworkId;
    }
    public void setHomeworkId(Integer homeworkId){
        this.homeworkId = homeworkId;
    }

    /*老师*/
    private Teacher teacherObj;
    public Teacher getTeacherObj() {
        return teacherObj;
    }
    public void setTeacherObj(Teacher teacherObj) {
        this.teacherObj = teacherObj;
    }

    /*作业标题*/
    @NotEmpty(message="作业标题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*作业内容*/
    @NotEmpty(message="作业内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*发布时间*/
    @NotEmpty(message="发布时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonHomeworkTask=new JSONObject(); 
		jsonHomeworkTask.accumulate("homeworkId", this.getHomeworkId());
		jsonHomeworkTask.accumulate("teacherObj", this.getTeacherObj().getName());
		jsonHomeworkTask.accumulate("teacherObjPri", this.getTeacherObj().getId());
		jsonHomeworkTask.accumulate("title", this.getTitle());
		jsonHomeworkTask.accumulate("content", this.getContent());
		jsonHomeworkTask.accumulate("addTime", this.getAddTime());
		return jsonHomeworkTask;
    }}