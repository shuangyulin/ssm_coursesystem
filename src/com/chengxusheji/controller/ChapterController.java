package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.ChapterService;
import com.chengxusheji.po.Chapter;

//Chapter管理控制层
@Controller
@RequestMapping("/Chapter")
public class ChapterController extends BaseController {

    /*业务层对象*/
    @Resource ChapterService chapterService;

	@InitBinder("chapter")
	public void initBinderChapter(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("chapter.");
	}
	/*跳转到添加Chapter视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Chapter());
		return "Chapter_add";
	}

	/*客户端ajax方式提交添加章信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Chapter chapter, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        chapterService.addChapter(chapter);
        message = "章信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询章信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)chapterService.setRows(rows);
		List<Chapter> chapterList = chapterService.queryChapter(page);
	    /*计算总的页数和总的记录数*/
	    chapterService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = chapterService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = chapterService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Chapter chapter:chapterList) {
			JSONObject jsonChapter = chapter.getJsonObject();
			jsonArray.put(jsonChapter);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询章信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Chapter> chapterList = chapterService.queryAllChapter();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Chapter chapter:chapterList) {
			JSONObject jsonChapter = new JSONObject();
			jsonChapter.accumulate("id", chapter.getId());
			jsonChapter.accumulate("title", chapter.getTitle());
			jsonArray.put(jsonChapter);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询章信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<Chapter> chapterList = chapterService.queryChapter(currentPage);
	    /*计算总的页数和总的记录数*/
	    chapterService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = chapterService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = chapterService.getRecordNumber();
	    request.setAttribute("chapterList",  chapterList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "Chapter/chapter_frontquery_result"; 
	}

     /*前台查询Chapter信息*/
	@RequestMapping(value="/{id}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer id,Model model,HttpServletRequest request) throws Exception {
		/*根据主键id获取Chapter对象*/
        Chapter chapter = chapterService.getChapter(id);

        request.setAttribute("chapter",  chapter);
        return "Chapter/chapter_frontshow";
	}

	/*ajax方式显示章信息修改jsp视图页*/
	@RequestMapping(value="/{id}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer id,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键id获取Chapter对象*/
        Chapter chapter = chapterService.getChapter(id);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonChapter = chapter.getJsonObject();
		out.println(jsonChapter.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新章信息信息*/
	@RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
	public void update(@Validated Chapter chapter, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			chapterService.updateChapter(chapter);
			message = "章信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "章信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除章信息信息*/
	@RequestMapping(value="/{id}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer id,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  chapterService.deleteChapter(id);
	            request.setAttribute("message", "章信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "章信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条章信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String ids,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = chapterService.deleteChapters(ids);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出章信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<Chapter> chapterList = chapterService.queryChapter();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Chapter信息记录"; 
        String[] headers = { "记录编号","章标题","添加时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<chapterList.size();i++) {
        	Chapter chapter = chapterList.get(i); 
        	dataset.add(new String[]{chapter.getId() + "",chapter.getTitle(),chapter.getAddTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Chapter.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
