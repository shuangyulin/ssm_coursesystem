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
import com.chengxusheji.service.StudentService;
import com.chengxusheji.po.Student;

//Student管理控制层
@Controller
@RequestMapping("/Student")
public class StudentController extends BaseController {

    /*业务层对象*/
    @Resource StudentService studentService;

	@InitBinder("student")
	public void initBinderStudent(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("student.");
	}
	/*跳转到添加Student视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Student());
		return "Student_add";
	}

	/*客户端ajax方式提交添加学生信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Student student, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(studentService.getStudent(student.getStudentNumber()) != null) {
			message = "学号已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			student.setPhoto(this.handlePhotoUpload(request, "photoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        studentService.addStudent(student);
        message = "学生信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询学生信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String studentNumber,String name,String birthday,String className,String telephone,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (studentNumber == null) studentNumber = "";
		if (name == null) name = "";
		if (birthday == null) birthday = "";
		if (className == null) className = "";
		if (telephone == null) telephone = "";
		if(rows != 0)studentService.setRows(rows);
		List<Student> studentList = studentService.queryStudent(studentNumber, name, birthday, className, telephone, page);
	    /*计算总的页数和总的记录数*/
	    studentService.queryTotalPageAndRecordNumber(studentNumber, name, birthday, className, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = studentService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = studentService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Student student:studentList) {
			JSONObject jsonStudent = student.getJsonObject();
			jsonArray.put(jsonStudent);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询学生信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Student> studentList = studentService.queryAllStudent();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Student student:studentList) {
			JSONObject jsonStudent = new JSONObject();
			jsonStudent.accumulate("studentNumber", student.getStudentNumber());
			jsonStudent.accumulate("name", student.getName());
			jsonArray.put(jsonStudent);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询学生信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String studentNumber,String name,String birthday,String className,String telephone,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (studentNumber == null) studentNumber = "";
		if (name == null) name = "";
		if (birthday == null) birthday = "";
		if (className == null) className = "";
		if (telephone == null) telephone = "";
		List<Student> studentList = studentService.queryStudent(studentNumber, name, birthday, className, telephone, currentPage);
	    /*计算总的页数和总的记录数*/
	    studentService.queryTotalPageAndRecordNumber(studentNumber, name, birthday, className, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = studentService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = studentService.getRecordNumber();
	    request.setAttribute("studentList",  studentList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("studentNumber", studentNumber);
	    request.setAttribute("name", name);
	    request.setAttribute("birthday", birthday);
	    request.setAttribute("className", className);
	    request.setAttribute("telephone", telephone);
		return "Student/student_frontquery_result"; 
	}

     /*前台查询Student信息*/
	@RequestMapping(value="/{studentNumber}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String studentNumber,Model model,HttpServletRequest request) throws Exception {
		/*根据主键studentNumber获取Student对象*/
        Student student = studentService.getStudent(studentNumber);

        request.setAttribute("student",  student);
        return "Student/student_frontshow";
	}

	/*ajax方式显示学生信息修改jsp视图页*/
	@RequestMapping(value="/{studentNumber}/update",method=RequestMethod.GET)
	public void update(@PathVariable String studentNumber,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键studentNumber获取Student对象*/
        Student student = studentService.getStudent(studentNumber);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonStudent = student.getJsonObject();
		out.println(jsonStudent.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新学生信息信息*/
	@RequestMapping(value = "/{studentNumber}/update", method = RequestMethod.POST)
	public void update(@Validated Student student, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String photoFileName = this.handlePhotoUpload(request, "photoFile");
		if(!photoFileName.equals("upload/NoImage.jpg"))student.setPhoto(photoFileName); 


		try {
			studentService.updateStudent(student);
			message = "学生信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "学生信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除学生信息信息*/
	@RequestMapping(value="/{studentNumber}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String studentNumber,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  studentService.deleteStudent(studentNumber);
	            request.setAttribute("message", "学生信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "学生信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条学生信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String studentNumbers,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = studentService.deleteStudents(studentNumbers);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出学生信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String studentNumber,String name,String birthday,String className,String telephone, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(studentNumber == null) studentNumber = "";
        if(name == null) name = "";
        if(birthday == null) birthday = "";
        if(className == null) className = "";
        if(telephone == null) telephone = "";
        List<Student> studentList = studentService.queryStudent(studentNumber,name,birthday,className,telephone);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Student信息记录"; 
        String[] headers = { "学号","姓名","性别","出生日期","政治面貌","所在班级","联系电话","个人照片"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<studentList.size();i++) {
        	Student student = studentList.get(i); 
        	dataset.add(new String[]{student.getStudentNumber(),student.getName(),student.getSex(),student.getBirthday(),student.getZzmm(),student.getClassName(),student.getTelephone(),student.getPhoto()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Student.xls");//filename是下载的xls的名，建议最好用英文 
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
