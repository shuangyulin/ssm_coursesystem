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
import com.chengxusheji.service.QuestionService;
import com.chengxusheji.po.Question;
import com.chengxusheji.service.TeacherService;
import com.chengxusheji.po.Teacher;

//Question管理控制层
@Controller
@RequestMapping("/Question")
public class QuestionController extends BaseController {

    /*业务层对象*/
    @Resource QuestionService questionService;

    @Resource TeacherService teacherService;
	@InitBinder("teacherId")
	public void initBinderteacherId(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("teacherId.");
	}
	@InitBinder("question")
	public void initBinderQuestion(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("question.");
	}
	/*跳转到添加Question视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Question());
		/*查询所有的Teacher信息*/
		List<Teacher> teacherList = teacherService.queryAllTeacher();
		request.setAttribute("teacherList", teacherList);
		return "Question_add";
	}

	/*客户端ajax方式提交添加在线问答信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Question question, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        questionService.addQuestion(question);
        message = "在线问答添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询在线问答信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("teacherId") Teacher teacherId,String questioner,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (questioner == null) questioner = "";
		if(rows != 0)questionService.setRows(rows);
		List<Question> questionList = questionService.queryQuestion(teacherId, questioner, page);
	    /*计算总的页数和总的记录数*/
	    questionService.queryTotalPageAndRecordNumber(teacherId, questioner);
	    /*获取到总的页码数目*/
	    int totalPage = questionService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = questionService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Question question:questionList) {
			JSONObject jsonQuestion = question.getJsonObject();
			jsonArray.put(jsonQuestion);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询在线问答信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Question> questionList = questionService.queryAllQuestion();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Question question:questionList) {
			JSONObject jsonQuestion = new JSONObject();
			jsonQuestion.accumulate("id", question.getId());
			jsonArray.put(jsonQuestion);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询在线问答信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("teacherId") Teacher teacherId,String questioner,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (questioner == null) questioner = "";
		List<Question> questionList = questionService.queryQuestion(teacherId, questioner, currentPage);
	    /*计算总的页数和总的记录数*/
	    questionService.queryTotalPageAndRecordNumber(teacherId, questioner);
	    /*获取到总的页码数目*/
	    int totalPage = questionService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = questionService.getRecordNumber();
	    request.setAttribute("questionList",  questionList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("teacherId", teacherId);
	    request.setAttribute("questioner", questioner);
	    List<Teacher> teacherList = teacherService.queryAllTeacher();
	    request.setAttribute("teacherList", teacherList);
		return "Question/question_frontquery_result"; 
	}

     /*前台查询Question信息*/
	@RequestMapping(value="/{id}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer id,Model model,HttpServletRequest request) throws Exception {
		/*根据主键id获取Question对象*/
        Question question = questionService.getQuestion(id);

        List<Teacher> teacherList = teacherService.queryAllTeacher();
        request.setAttribute("teacherList", teacherList);
        request.setAttribute("question",  question);
        return "Question/question_frontshow";
	}

	/*ajax方式显示在线问答修改jsp视图页*/
	@RequestMapping(value="/{id}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer id,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键id获取Question对象*/
        Question question = questionService.getQuestion(id);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonQuestion = question.getJsonObject();
		out.println(jsonQuestion.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新在线问答信息*/
	@RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
	public void update(@Validated Question question, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			questionService.updateQuestion(question);
			message = "在线问答更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "在线问答更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除在线问答信息*/
	@RequestMapping(value="/{id}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer id,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  questionService.deleteQuestion(id);
	            request.setAttribute("message", "在线问答删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "在线问答删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条在线问答记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String ids,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = questionService.deleteQuestions(ids);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出在线问答信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("teacherId") Teacher teacherId,String questioner, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(questioner == null) questioner = "";
        List<Question> questionList = questionService.queryQuestion(teacherId,questioner);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Question信息记录"; 
        String[] headers = { "记录编号","提问的老师","提问者","提问内容","回复内容","提问时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<questionList.size();i++) {
        	Question question = questionList.get(i); 
        	dataset.add(new String[]{question.getId() + "",question.getTeacherId().getName(),question.getQuestioner(),question.getContent(),question.getReply(),question.getAddTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Question.xls");//filename是下载的xls的名，建议最好用英文 
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
