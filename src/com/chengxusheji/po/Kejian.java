package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Kejian {
    /*记录编号*/
    private Integer id;
    public Integer getId(){
        return id;
    }
    public void setId(Integer id){
        this.id = id;
    }

    /*课件标题*/
    @NotEmpty(message="课件标题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*文件路径*/
    @NotEmpty(message="文件路径不能为空")
    private String path;
    public String getPath() {
        return path;
    }
    public void setPath(String path) {
        this.path = path;
    }

    /*添加时间*/
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonKejian=new JSONObject(); 
		jsonKejian.accumulate("id", this.getId());
		jsonKejian.accumulate("title", this.getTitle());
		jsonKejian.accumulate("path", this.getPath());
		jsonKejian.accumulate("addTime", this.getAddTime());
		return jsonKejian;
    }}