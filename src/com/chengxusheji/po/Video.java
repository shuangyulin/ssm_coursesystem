package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Video {
    /*记录编号*/
    private Integer id;
    public Integer getId(){
        return id;
    }
    public void setId(Integer id){
        this.id = id;
    }

    /*视频资料标题*/
    @NotEmpty(message="视频资料标题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*所属章*/
    private Chapter chapterId;
    public Chapter getChapterId() {
        return chapterId;
    }
    public void setChapterId(Chapter chapterId) {
        this.chapterId = chapterId;
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
    @NotEmpty(message="添加时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonVideo=new JSONObject(); 
		jsonVideo.accumulate("id", this.getId());
		jsonVideo.accumulate("title", this.getTitle());
		jsonVideo.accumulate("chapterId", this.getChapterId().getTitle());
		jsonVideo.accumulate("chapterIdPri", this.getChapterId().getId());
		jsonVideo.accumulate("path", this.getPath());
		jsonVideo.accumulate("addTime", this.getAddTime());
		return jsonVideo;
    }}