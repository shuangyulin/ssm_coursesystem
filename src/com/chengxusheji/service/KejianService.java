package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Kejian;

import com.chengxusheji.mapper.KejianMapper;
@Service
public class KejianService {

	@Resource KejianMapper kejianMapper;
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

    /*添加课件信息记录*/
    public void addKejian(Kejian kejian) throws Exception {
    	kejianMapper.addKejian(kejian);
    }

    /*按照查询条件分页查询课件信息记录*/
    public ArrayList<Kejian> queryKejian(String title,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_kejian.title like '%" + title + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return kejianMapper.queryKejian(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Kejian> queryKejian(String title) throws Exception  { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_kejian.title like '%" + title + "%'";
    	return kejianMapper.queryKejianList(where);
    }

    /*查询所有课件信息记录*/
    public ArrayList<Kejian> queryAllKejian()  throws Exception {
        return kejianMapper.queryKejianList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String title) throws Exception {
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_kejian.title like '%" + title + "%'";
        recordNumber = kejianMapper.queryKejianCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取课件信息记录*/
    public Kejian getKejian(int id) throws Exception  {
        Kejian kejian = kejianMapper.getKejian(id);
        return kejian;
    }

    /*更新课件信息记录*/
    public void updateKejian(Kejian kejian) throws Exception {
        kejianMapper.updateKejian(kejian);
    }

    /*删除一条课件信息记录*/
    public void deleteKejian (int id) throws Exception {
        kejianMapper.deleteKejian(id);
    }

    /*删除多条课件信息信息*/
    public int deleteKejians (String ids) throws Exception {
    	String _ids[] = ids.split(",");
    	for(String _id: _ids) {
    		kejianMapper.deleteKejian(Integer.parseInt(_id));
    	}
    	return _ids.length;
    }
}
