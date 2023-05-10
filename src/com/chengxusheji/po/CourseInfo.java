package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class CourseInfo {
    /*记录编号*/
    private Integer id;
    public Integer getId(){
        return id;
    }
    public void setId(Integer id){
        this.id = id;
    }

    /*课程简介*/
    @NotEmpty(message="课程简介不能为空")
    private String jianjie;
    public String getJianjie() {
        return jianjie;
    }
    public void setJianjie(String jianjie) {
        this.jianjie = jianjie;
    }

    /*课程大纲*/
    @NotEmpty(message="课程大纲不能为空")
    private String dagan;
    public String getDagan() {
        return dagan;
    }
    public void setDagan(String dagan) {
        this.dagan = dagan;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonCourseInfo=new JSONObject(); 
		jsonCourseInfo.accumulate("id", this.getId());
		jsonCourseInfo.accumulate("jianjie", this.getJianjie());
		jsonCourseInfo.accumulate("dagan", this.getDagan());
		return jsonCourseInfo;
    }}