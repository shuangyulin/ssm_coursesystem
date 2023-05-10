package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Chapter;
import com.chengxusheji.po.Video;

import com.chengxusheji.mapper.VideoMapper;
@Service
public class VideoService {

	@Resource VideoMapper videoMapper;
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

    /*添加视频信息记录*/
    public void addVideo(Video video) throws Exception {
    	videoMapper.addVideo(video);
    }

    /*按照查询条件分页查询视频信息记录*/
    public ArrayList<Video> queryVideo(String title,Chapter chapterId,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_video.title like '%" + title + "%'";
    	if(null != chapterId && chapterId.getId()!= null && chapterId.getId()!= 0)  where += " and t_video.chapterId=" + chapterId.getId();
    	int startIndex = (currentPage-1) * this.rows;
    	return videoMapper.queryVideo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Video> queryVideo(String title,Chapter chapterId) throws Exception  { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_video.title like '%" + title + "%'";
    	if(null != chapterId && chapterId.getId()!= null && chapterId.getId()!= 0)  where += " and t_video.chapterId=" + chapterId.getId();
    	return videoMapper.queryVideoList(where);
    }

    /*查询所有视频信息记录*/
    public ArrayList<Video> queryAllVideo()  throws Exception {
        return videoMapper.queryVideoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String title,Chapter chapterId) throws Exception {
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_video.title like '%" + title + "%'";
    	if(null != chapterId && chapterId.getId()!= null && chapterId.getId()!= 0)  where += " and t_video.chapterId=" + chapterId.getId();
        recordNumber = videoMapper.queryVideoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取视频信息记录*/
    public Video getVideo(int id) throws Exception  {
        Video video = videoMapper.getVideo(id);
        return video;
    }

    /*更新视频信息记录*/
    public void updateVideo(Video video) throws Exception {
        videoMapper.updateVideo(video);
    }

    /*删除一条视频信息记录*/
    public void deleteVideo (int id) throws Exception {
        videoMapper.deleteVideo(id);
    }

    /*删除多条视频信息信息*/
    public int deleteVideos (String ids) throws Exception {
    	String _ids[] = ids.split(",");
    	for(String _id: _ids) {
    		videoMapper.deleteVideo(Integer.parseInt(_id));
    	}
    	return _ids.length;
    }
}
