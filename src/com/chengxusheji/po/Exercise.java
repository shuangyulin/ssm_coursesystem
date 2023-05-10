package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Exercise {
    /*记录编号*/
    private Integer id;
    public Integer getId(){
        return id;
    }
    public void setId(Integer id){
        this.id = id;
    }

    /*习题名称*/
    @NotEmpty(message="习题名称不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*所在章*/
    private Chapter chapterId;
    public Chapter getChapterId() {
        return chapterId;
    }
    public void setChapterId(Chapter chapterId) {
        this.chapterId = chapterId;
    }

    /*练习内容*/
    @NotEmpty(message="练习内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*加入时间*/
    @NotEmpty(message="加入时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonExercise=new JSONObject(); 
		jsonExercise.accumulate("id", this.getId());
		jsonExercise.accumulate("title", this.getTitle());
		jsonExercise.accumulate("chapterId", this.getChapterId().getTitle());
		jsonExercise.accumulate("chapterIdPri", this.getChapterId().getId());
		jsonExercise.accumulate("content", this.getContent());
		jsonExercise.accumulate("addTime", this.getAddTime());
		return jsonExercise;
    }}