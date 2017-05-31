package org.dodo.cont;

import javax.servlet.http.*;
import javax.validation.*;

import org.dodo.svc.*;
import org.dodo.vo.*;
import org.json.simple.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.validation.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

@Controller
@RequestMapping("mc/") // 유저컨트롤러 
public class MainCont {

		@Autowired private MainSVC msvc;
		
		// 메인페이지에서 설정 클릭시 
		@RequestMapping(value = "Main/setup")
		public String goSetup(){
			return "Main/MainSetup";
		}
		
		//회원탈퇴 페이지로 이동 
		@RequestMapping(value = "Main/withdrawal")
		public ModelAndView getWithdrawal(HttpSession session){
			ModelAndView view = new ModelAndView();
			String id = (String) session.getAttribute("USERID");
			System.out.println("설정에 들어가 있는 id값:"+id);
			view.addObject("uvo", msvc.getUserNum(id));
			view.setViewName("Main/Withdrawal");
			return view;
		}
		
		//회원탈퇴
		@RequestMapping(value = "Main/drawal")
		@ResponseBody
		public Object getUserDrawal(UserVO uvo, BindingResult re){
			boolean result = msvc.getUserDrawal(uvo);
			JSONObject json = new JSONObject();
			System.out.println(result);
			json.put("result", result);
			return json;
			
		}
		
		
		//회원정보수정 페이지로 이동
		@RequestMapping(value = "Main/usermodify")
		public String getUserModPage(HttpSession session,Model model){
			String id = (String) session.getAttribute("USERID");
			System.out.println("수정 아이디값"+id);
			UserVO uvo = msvc.getUserModify(id);
			model.addAttribute("uvo",uvo);
			return "Main/UserModify";
		}
		
		
		//회원정보수정
		@RequestMapping(value = "Main/modf")
		@ResponseBody
		public Object getUserModify(UserVO uvo,HttpSession session){
			String id = (String)session.getAttribute("USERID");
			int result = msvc.getUserModf(uvo,id);
			System.out.println("모디파이 리절트값"+result);
			JSONObject json = new JSONObject();
			json.put("result", result);
			return json;
		}
		
		
		//비밀번호 변경 페이지로
		@RequestMapping(value = "Main/passwordchange")
		public String getPasswordChange(){
			return "Main/PwdChange";
		}
		
		
		//비밀번호 변경
		@RequestMapping(value = "Main/pwdchange")
		@ResponseBody
		public Object setNewPwdChange(
				@RequestParam String id,
				@RequestParam String npwd1,
				HttpSession session
				){
			String id1=(String) session.getAttribute("USERID");
			System.out.println(id1+npwd1);
			
			int result = msvc.setNewPwdChange(id1,npwd1);
			JSONObject json = new JSONObject();
			System.out.println(result);
			json.put("result", result);
			return json;
		}
		
	
}

