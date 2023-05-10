package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Question {
    /*记录编号*/
    private Integer id;
    public Integer getId(){
        return id;
    }
    public void setId(Integer id){
        this.id = id;
    }

    /*提问的老师*/
    private Teacher teacherId;
    public Teacher getTeacherId() {
        return teacherId;
    }
    public void setTeacherId(Teacher teacherId) {
        this.teacherId = teacherId;
    }

    /*提问者*/
    @NotEmpty(message="提问者不能为空")
    private String questioner;
    public String getQuestioner() {
        return questioner;
    }
    public void setQuestioner(String questioner) {
        this.questioner = questioner;
    }

    /*提问内容*/
    @NotEmpty(message="提问内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*回复内容*/
    @NotEmpty(message="回复内容不能为空")
    private String reply;
    public String getReply() {
        return reply;
    }
    public void setReply(String reply) {
        this.reply = reply;
    }

    /*提问时间*/
    @NotEmpty(message="提问时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonQuestion=new JSONObject(); 
		jsonQuestion.accumulate("id", this.getId());
		jsonQuestion.accumulate("teacherId", this.getTeacherId().getName());
		jsonQuestion.accumulate("teacherIdPri", this.getTeacherId().getId());
		jsonQuestion.accumulate("questioner", this.getQuestioner());
		jsonQuestion.accumulate("content", this.getContent());
		jsonQuestion.accumulate("reply", this.getReply());
		jsonQuestion.accumulate("addTime", this.getAddTime());
		return jsonQuestion;
    }}