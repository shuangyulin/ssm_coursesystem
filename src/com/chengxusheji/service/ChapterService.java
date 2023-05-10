package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Chapter;

import com.chengxusheji.mapper.ChapterMapper;
@Service
public class ChapterService {

	@Resource ChapterMapper chapterMapper;
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

    /*添加章信息记录*/
    public void addChapter(Chapter chapter) throws Exception {
    	chapterMapper.addChapter(chapter);
    }

    /*按照查询条件分页查询章信息记录*/
    public ArrayList<Chapter> queryChapter(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return chapterMapper.queryChapter(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Chapter> queryChapter() throws Exception  { 
     	String where = "where 1=1";
    	return chapterMapper.queryChapterList(where);
    }

    /*查询所有章信息记录*/
    public ArrayList<Chapter> queryAllChapter()  throws Exception {
        return chapterMapper.queryChapterList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = chapterMapper.queryChapterCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取章信息记录*/
    public Chapter getChapter(int id) throws Exception  {
        Chapter chapter = chapterMapper.getChapter(id);
        return chapter;
    }

    /*更新章信息记录*/
    public void updateChapter(Chapter chapter) throws Exception {
        chapterMapper.updateChapter(chapter);
    }

    /*删除一条章信息记录*/
    public void deleteChapter (int id) throws Exception {
        chapterMapper.deleteChapter(id);
    }

    /*删除多条章信息信息*/
    public int deleteChapters (String ids) throws Exception {
    	String _ids[] = ids.split(",");
    	for(String _id: _ids) {
    		chapterMapper.deleteChapter(Integer.parseInt(_id));
    	}
    	return _ids.length;
    }
}
