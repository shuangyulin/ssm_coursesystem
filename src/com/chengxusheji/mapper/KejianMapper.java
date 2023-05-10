package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Kejian;

public interface KejianMapper {
	/*添加课件信息信息*/
	public void addKejian(Kejian kejian) throws Exception;

	/*按照查询条件分页查询课件信息记录*/
	public ArrayList<Kejian> queryKejian(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有课件信息记录*/
	public ArrayList<Kejian> queryKejianList(@Param("where") String where) throws Exception;

	/*按照查询条件的课件信息记录数*/
	public int queryKejianCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条课件信息记录*/
	public Kejian getKejian(int id) throws Exception;

	/*更新课件信息记录*/
	public void updateKejian(Kejian kejian) throws Exception;

	/*删除课件信息记录*/
	public void deleteKejian(int id) throws Exception;

}
