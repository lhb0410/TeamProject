package org.dodo.cont;

import java.security.*;
import java.util.*;

import javax.servlet.http.*;

import org.dodo.svc.*;
import org.dodo.vo.*;
import org.json.simple.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.security.core.*;
import org.springframework.security.core.context.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping("uc/") // 유저컨트롤러 
public class UserCont {
	
	@Autowired
	private UserSVC usvc;
	@Autowired
	private BoardSVC bsvc;
	
	
	// 인덱스에서 로그인 클릭시
	@RequestMapping(value = "User/loginform", method = RequestMethod.GET)
	public String setGoLogin(){
		System.out.println("로그인 폼 돌아감");
		return "User/LoginForm";
	}
	
	// 로그인폼에서 회원가입폼으로
	@RequestMapping(value = "User/userjoin", method = RequestMethod.GET)
	public String setUserJoin(){
		return "User/UserJoin";
	}
	
	
	// 메인페이지
	@RequestMapping(value = "Main/main")
	public String setGoMainList(Model model,HttpSession session,Authentication auth) {
		BoardVO vo = bsvc.getgoodList();//최신글6개
		BoardVO bvo = bsvc.getNoticeBoard();
		List<NoticeVO> nList = bvo.getNlist();
		session.setAttribute("glist", vo.getBlist());
		session.setAttribute("flist", bsvc.getGoodfilename(vo)); //파일이름6개
		session.setAttribute("nList", nList);
		if(auth!=null){
		String id = auth.getName();
		session.setAttribute("USERID",id);
		List<CategoryVO> cList = usvc.getHobbyList(id);
		session.setAttribute("cList", cList);
		return "Main/main";
		}
		return "Main/main";
	}
	
	
	// 유저 회원가입
	@RequestMapping(value = "User/usave")
	@ResponseBody
	public Object setUserSave(UserVO user){
		boolean result = usvc.setUserSave(user);
		usvc.setUserHobby(user);
		/*System.out.println("회원가입 리턴값"+result);*/
		JSONObject json = new JSONObject();
		json.put("save", result);
		return json.toJSONString();
	}
	
	// 로그아웃
	@RequestMapping(value = "User/logout")
	public String isUserLogout(HttpSession session) {
		System.out.println("유저 로그아웃 돌아감!");
		session.removeAttribute("USERID");
		return "User/LoginForm";
	}
	
	//id/pwd찾기 페이지 이동
	@RequestMapping(value = "User/infofind")
	public String setUserInfoFind() {
		return "User/UserInfoFind";
	}
	
	//ID찾기
	@RequestMapping(value="User/idfind" ,method=RequestMethod.POST)
	@ResponseBody
	public Object getUserIdFind(UserVO uvo) {
		String getId = null;
		UserVO reUvo = usvc.getUserIdFind(uvo);
		getId = reUvo.getId();
		JSONObject json = new JSONObject();
		json.put("get", getId);
		return json;
	}
	
	
	//Pwd찾기
	@RequestMapping(value="User/pwdfind" ,method=RequestMethod.POST)
	@ResponseBody
	public Object getUserPwdFind(UserVO uvo) throws Exception {
		/*System.out.println(uvo.getId());
		System.out.println(uvo.getEmail());
		System.out.println(uvo.getQue());
		System.out.println(uvo.getAns());*/
		int result = usvc.getUserPwdFind(uvo);
		JSONObject json = new JSONObject();
		json.put("pwd", result);
		return json;
	}
	
	
	//id 중복 체크
	@RequestMapping(value="User/idcheck" ,method=RequestMethod.POST)
	@ResponseBody
	public Object getIdCheck(@RequestParam String id){
		System.out.println("ID 체크값 "+id);
		UserVO result = usvc.getIdCheck(id);
		JSONObject json = new JSONObject();
		json.put("idc", result.getId());
		return json;
	}
	
		
}
