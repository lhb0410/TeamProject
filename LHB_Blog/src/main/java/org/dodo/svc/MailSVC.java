package org.dodo.svc;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.dodo.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;



@Service("mailService")
public class MailSVC {

     
    @Autowired
    protected JavaMailSender mailSender;

    
    public boolean sendMail(UserVO uvo,String newPwd) throws Exception {
        try{
	        MimeMessage msg = mailSender.createMimeMessage();
	        InternetAddress addr = new InternetAddress("siaert00@gmail.com");
	        msg.setFrom(addr); // 송신자를 설정해도 소용없지만 없으면 오류가 발생한다

	        //msg.setFrom("someone@paran.com");
	        msg.setSubject("Dodo 임시 비밀번호 입니다.");



	        // 일반 텍스트만 전송하려는 경우
	        msg.setText("임시비밀번호는 "+newPwd+" 입니다. 사용 후 반드시 비밀번호를 변경해 주세요." );  



	        //HTML 컨텐츠를 전송하려면. http://micropilot.tistory.com/category/Java%20Mail/HTML%20Contents
	       /* msg.setContent("<a href='http://192.168.0.112:8081/SpringWeb/int/login'>로그인 접속</a>", "text/html;charset=utf-8");*/
	        msg.setRecipient(RecipientType.TO , new InternetAddress(uvo.getEmail()));

	         
	        mailSender.send(msg);
	        return true;

        }catch(Exception ex) {
        	ex.printStackTrace();
        }
        return false;
    }
}



