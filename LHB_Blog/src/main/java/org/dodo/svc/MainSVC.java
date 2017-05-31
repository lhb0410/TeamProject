package org.dodo.svc;

import java.util.*;

import org.dodo.mybatis.*;
import org.dodo.vo.*;
import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.security.crypto.bcrypt.*;
import org.springframework.stereotype.*;

@Service
public class MainSVC {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	@Autowired
	BCryptPasswordEncoder passwordEncoder; // ���� �������Ͽ� ������ ���
	
	public UserVO getUserModify(String id) {
		UserDAO dao = sqlSessionTemplate.getMapper(UserDAO.class);
		return dao.getUserModify(id);
	}


	public boolean getUserDrawal(UserVO uvo) {
		HashMap<String,Object> hs = new HashMap<String,Object>();
		UserDAO dao = sqlSessionTemplate.getMapper(UserDAO.class);
		boolean newPwd = passwordEncoder.matches(uvo.getPwd(),getUserPwd(uvo));
		hs.put("id", uvo.getId());
		hs.put("pwd", getUserPwd(uvo));
		dao.getUserDrawal(hs);
		return newPwd;
	}

	public String getUserPwd(UserVO uvo) {
		UserDAO dao = sqlSessionTemplate.getMapper(UserDAO.class);
		UserVO reUvo = dao.getUserPwd(uvo);
		if(reUvo == null){
			throw new NullPointerException("��");
		}
		return reUvo.getPwd();
	}


	public int getUserModf(UserVO uvo,String id) {
		UserDAO dao = sqlSessionTemplate.getMapper(UserDAO.class);
		uvo.setId(id);
		return dao.getUserModf(uvo);
	}


	
	public int setNewPwdChange(String id, String npwd1) {
		UserDAO dao = sqlSessionTemplate.getMapper(UserDAO.class);
		String newPwd = passwordEncoder.encode(npwd1);
		System.out.println(newPwd);
		UserVO uvo = new UserVO();
		uvo.setPwd(newPwd);
		uvo.setId(id);
		System.out.println("SVC ���̵�"+uvo.getId());
		System.out.println("SVC ��й�ȣ"+uvo.getPwd());
		return dao.setNewPwdChange(uvo);
	}

	

	public UserVO getUserNum(String id) {
		UserDAO dao = sqlSessionTemplate.getMapper(UserDAO.class);
		UserVO uvo = dao.getUserNum(id);
		System.out.println("���ϵ� ���̵��� �ѹ���"+uvo.getNum());
		return uvo;
	}
	
	

}
