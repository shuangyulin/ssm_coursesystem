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
import com.chengxusheji.service.HomeworkUploadService;
import com.chengxusheji.po.HomeworkUpload;
import com.chengxusheji.service.HomeworkTaskService;
import com.chengxusheji.po.HomeworkTask;
import com.chengxusheji.service.StudentService;
import com.chengxusheji.po.Student;

//HomeworkUpload管理控制层
@Controller
@RequestMapping("/HomeworkUpload")
public class HomeworkUploadController extends BaseController {

    /*业务层对象*/
    @Resource HomeworkUploadService homeworkUploadService;

    @Resource HomeworkTaskService homeworkTaskService;
    @Resource StudentService studentService;
	@InitBinder("homeworkTaskObj")
	public void initBinderhomeworkTaskObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("homeworkTaskObj.");
	}
	@InitBinder("studentObj")
	public void initBinderstudentObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("studentObj.");
	}
	@InitBinder("homeworkUpload")
	public void initBinderHomeworkUpload(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("homeworkUpload.");
	}
	/*跳转到添加HomeworkUpload视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new HomeworkUpload());
		/*查询所有的HomeworkTask信息*/
		List<HomeworkTask> homeworkTaskList = homeworkTaskService.queryAllHomeworkTask();
		request.setAttribute("homeworkTaskList", homeworkTaskList);
		/*查询所有的Student信息*/
		List<Student> studentList = studentService.queryAllStudent();
		request.setAttribute("studentList", studentList);
		return "HomeworkUpload_add";
	}

	/*客户端ajax方式提交添加上传的作业信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated HomeworkUpload homeworkUpload, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			homeworkUpload.setHomeworkFile(this.handlePhotoUpload(request, "homeworkFileFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			homeworkUpload.setResultFile(this.handlePhotoUpload(request, "resultFileFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        homeworkUploadService.addHomeworkUpload(homeworkUpload);
        message = "上传的作业添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询上传的作业信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("homeworkTaskObj") HomeworkTask homeworkTaskObj,@ModelAttribute("studentObj") Student studentObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)homeworkUploadService.setRows(rows);
		List<HomeworkUpload> homeworkUploadList = homeworkUploadService.queryHomeworkUpload(homeworkTaskObj, studentObj, page);
	    /*计算总的页数和总的记录数*/
	    homeworkUploadService.queryTotalPageAndRecordNumber(homeworkTaskObj, studentObj);
	    /*获取到总的页码数目*/
	    int totalPage = homeworkUploadService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = homeworkUploadService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(HomeworkUpload homeworkUpload:homeworkUploadList) {
			JSONObject jsonHomeworkUpload = homeworkUpload.getJsonObject();
			jsonArray.put(jsonHomeworkUpload);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询上传的作业信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<HomeworkUpload> homeworkUploadList = homeworkUploadService.queryAllHomeworkUpload();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(HomeworkUpload homeworkUpload:homeworkUploadList) {
			JSONObject jsonHomeworkUpload = new JSONObject();
			jsonHomeworkUpload.accumulate("uploadId", homeworkUpload.getUploadId());
			jsonArray.put(jsonHomeworkUpload);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询上传的作业信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("homeworkTaskObj") HomeworkTask homeworkTaskObj,@ModelAttribute("studentObj") Student studentObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<HomeworkUpload> homeworkUploadList = homeworkUploadService.queryHomeworkUpload(homeworkTaskObj, studentObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    homeworkUploadService.queryTotalPageAndRecordNumber(homeworkTaskObj, studentObj);
	    /*获取到总的页码数目*/
	    int totalPage = homeworkUploadService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = homeworkUploadService.getRecordNumber();
	    request.setAttribute("homeworkUploadList",  homeworkUploadList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("homeworkTaskObj", homeworkTaskObj);
	    request.setAttribute("studentObj", studentObj);
	    List<HomeworkTask> homeworkTaskList = homeworkTaskService.queryAllHomeworkTask();
	    request.setAttribute("homeworkTaskList", homeworkTaskList);
	    List<Student> studentList = studentService.queryAllStudent();
	    request.setAttribute("studentList", studentList);
		return "HomeworkUpload/homeworkUpload_frontquery_result"; 
	}

     /*前台查询HomeworkUpload信息*/
	@RequestMapping(value="/{uploadId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer uploadId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键uploadId获取HomeworkUpload对象*/
        HomeworkUpload homeworkUpload = homeworkUploadService.getHomeworkUpload(uploadId);

        List<HomeworkTask> homeworkTaskList = homeworkTaskService.queryAllHomeworkTask();
        request.setAttribute("homeworkTaskList", homeworkTaskList);
        List<Student> studentList = studentService.queryAllStudent();
        request.setAttribute("studentList", studentList);
        request.setAttribute("homeworkUpload",  homeworkUpload);
        return "HomeworkUpload/homeworkUpload_frontshow";
	}

	/*ajax方式显示上传的作业修改jsp视图页*/
	@RequestMapping(value="/{uploadId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer uploadId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键uploadId获取HomeworkUpload对象*/
        HomeworkUpload homeworkUpload = homeworkUploadService.getHomeworkUpload(uploadId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonHomeworkUpload = homeworkUpload.getJsonObject();
		out.println(jsonHomeworkUpload.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新上传的作业信息*/
	@RequestMapping(value = "/{uploadId}/update", method = RequestMethod.POST)
	public void update(@Validated HomeworkUpload homeworkUpload, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String homeworkFileFileName = this.handlePhotoUpload(request, "homeworkFileFile");
		if(!homeworkFileFileName.equals("upload/NoImage.jpg"))homeworkUpload.setHomeworkFile(homeworkFileFileName); 


		String resultFileFileName = this.handlePhotoUpload(request, "resultFileFile");
		if(!resultFileFileName.equals("upload/NoImage.jpg"))homeworkUpload.setResultFile(resultFileFileName); 


		try {
			homeworkUploadService.updateHomeworkUpload(homeworkUpload);
			message = "上传的作业更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "上传的作业更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除上传的作业信息*/
	@RequestMapping(value="/{uploadId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer uploadId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  homeworkUploadService.deleteHomeworkUpload(uploadId);
	            request.setAttribute("message", "上传的作业删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "上传的作业删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条上传的作业记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String uploadIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = homeworkUploadService.deleteHomeworkUploads(uploadIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出上传的作业信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("homeworkTaskObj") HomeworkTask homeworkTaskObj,@ModelAttribute("studentObj") Student studentObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<HomeworkUpload> homeworkUploadList = homeworkUploadService.queryHomeworkUpload(homeworkTaskObj,studentObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "HomeworkUpload信息记录"; 
        String[] headers = { "记录编号","作业标题","提交的学生","作业文件","提交时间","批改结果文件","批改时间","是否批改","评语"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<homeworkUploadList.size();i++) {
        	HomeworkUpload homeworkUpload = homeworkUploadList.get(i); 
        	dataset.add(new String[]{homeworkUpload.getUploadId() + "",homeworkUpload.getHomeworkTaskObj().getTitle(),homeworkUpload.getStudentObj().getName(),homeworkUpload.getHomeworkFile(),homeworkUpload.getUploadTime(),homeworkUpload.getResultFile(),homeworkUpload.getPigaiTime(),homeworkUpload.getPigaiFlag() + "",homeworkUpload.getPingyu()});
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
			response.setHeader("Content-disposition","attachment; filename="+"HomeworkUpload.xls");//filename是下载的xls的名，建议最好用英文 
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
