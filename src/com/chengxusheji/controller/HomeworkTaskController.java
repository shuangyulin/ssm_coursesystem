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
import com.chengxusheji.service.HomeworkTaskService;
import com.chengxusheji.po.HomeworkTask;
import com.chengxusheji.service.TeacherService;
import com.chengxusheji.po.Teacher;

//HomeworkTask管理控制层
@Controller
@RequestMapping("/HomeworkTask")
public class HomeworkTaskController extends BaseController {

    /*业务层对象*/
    @Resource HomeworkTaskService homeworkTaskService;

    @Resource TeacherService teacherService;
	@InitBinder("teacherObj")
	public void initBinderteacherObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("teacherObj.");
	}
	@InitBinder("homeworkTask")
	public void initBinderHomeworkTask(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("homeworkTask.");
	}
	/*跳转到添加HomeworkTask视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new HomeworkTask());
		/*查询所有的Teacher信息*/
		List<Teacher> teacherList = teacherService.queryAllTeacher();
		request.setAttribute("teacherList", teacherList);
		return "HomeworkTask_add";
	}

	/*客户端ajax方式提交添加作业任务信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated HomeworkTask homeworkTask, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        homeworkTaskService.addHomeworkTask(homeworkTask);
        message = "作业任务添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询作业任务信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("teacherObj") Teacher teacherObj,String title,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (title == null) title = "";
		if(rows != 0)homeworkTaskService.setRows(rows);
		List<HomeworkTask> homeworkTaskList = homeworkTaskService.queryHomeworkTask(teacherObj, title, page);
	    /*计算总的页数和总的记录数*/
	    homeworkTaskService.queryTotalPageAndRecordNumber(teacherObj, title);
	    /*获取到总的页码数目*/
	    int totalPage = homeworkTaskService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = homeworkTaskService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(HomeworkTask homeworkTask:homeworkTaskList) {
			JSONObject jsonHomeworkTask = homeworkTask.getJsonObject();
			jsonArray.put(jsonHomeworkTask);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询作业任务信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<HomeworkTask> homeworkTaskList = homeworkTaskService.queryAllHomeworkTask();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(HomeworkTask homeworkTask:homeworkTaskList) {
			JSONObject jsonHomeworkTask = new JSONObject();
			jsonHomeworkTask.accumulate("homeworkId", homeworkTask.getHomeworkId());
			jsonHomeworkTask.accumulate("title", homeworkTask.getTitle());
			jsonArray.put(jsonHomeworkTask);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询作业任务信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("teacherObj") Teacher teacherObj,String title,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (title == null) title = "";
		List<HomeworkTask> homeworkTaskList = homeworkTaskService.queryHomeworkTask(teacherObj, title, currentPage);
	    /*计算总的页数和总的记录数*/
	    homeworkTaskService.queryTotalPageAndRecordNumber(teacherObj, title);
	    /*获取到总的页码数目*/
	    int totalPage = homeworkTaskService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = homeworkTaskService.getRecordNumber();
	    request.setAttribute("homeworkTaskList",  homeworkTaskList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("teacherObj", teacherObj);
	    request.setAttribute("title", title);
	    List<Teacher> teacherList = teacherService.queryAllTeacher();
	    request.setAttribute("teacherList", teacherList);
		return "HomeworkTask/homeworkTask_frontquery_result"; 
	}

     /*前台查询HomeworkTask信息*/
	@RequestMapping(value="/{homeworkId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer homeworkId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键homeworkId获取HomeworkTask对象*/
        HomeworkTask homeworkTask = homeworkTaskService.getHomeworkTask(homeworkId);

        List<Teacher> teacherList = teacherService.queryAllTeacher();
        request.setAttribute("teacherList", teacherList);
        request.setAttribute("homeworkTask",  homeworkTask);
        return "HomeworkTask/homeworkTask_frontshow";
	}

	/*ajax方式显示作业任务修改jsp视图页*/
	@RequestMapping(value="/{homeworkId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer homeworkId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键homeworkId获取HomeworkTask对象*/
        HomeworkTask homeworkTask = homeworkTaskService.getHomeworkTask(homeworkId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonHomeworkTask = homeworkTask.getJsonObject();
		out.println(jsonHomeworkTask.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新作业任务信息*/
	@RequestMapping(value = "/{homeworkId}/update", method = RequestMethod.POST)
	public void update(@Validated HomeworkTask homeworkTask, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			homeworkTaskService.updateHomeworkTask(homeworkTask);
			message = "作业任务更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "作业任务更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除作业任务信息*/
	@RequestMapping(value="/{homeworkId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer homeworkId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  homeworkTaskService.deleteHomeworkTask(homeworkId);
	            request.setAttribute("message", "作业任务删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "作业任务删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条作业任务记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String homeworkIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = homeworkTaskService.deleteHomeworkTasks(homeworkIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出作业任务信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("teacherObj") Teacher teacherObj,String title, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(title == null) title = "";
        List<HomeworkTask> homeworkTaskList = homeworkTaskService.queryHomeworkTask(teacherObj,title);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "HomeworkTask信息记录"; 
        String[] headers = { "记录编号","老师","作业标题","发布时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<homeworkTaskList.size();i++) {
        	HomeworkTask homeworkTask = homeworkTaskList.get(i); 
        	dataset.add(new String[]{homeworkTask.getHomeworkId() + "",homeworkTask.getTeacherObj().getName(),homeworkTask.getTitle(),homeworkTask.getAddTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"HomeworkTask.xls");//filename是下载的xls的名，建议最好用英文 
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
