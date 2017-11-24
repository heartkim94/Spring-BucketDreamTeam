package com.pknu.project.user.common;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Component;

@Component
public class MailUtil {
	private final JavaMailSender javaMailSender;

	@Autowired
	public MailUtil(JavaMailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}
	
	public void sendMail(String certKey, String email) {
//		String url = "http://localhost/project/checkJoin.user?certKey=";
//		
//		String subject = "회원 가입 인증 관련 메일입니다";
//		StringBuilder sb = new StringBuilder();
//		sb.append(url).append(certKey);
//		send(subject, sb.toString(), "bum6613@gmail.com", email);
		
		String linkFront = "<a href=\"";
		String url = "http://localhost/project/checkJoin.user?certKey=";
		String linkBack = "\">인증하기</a>";
		
		String subject = "회원 가입 인증 관련 메일입니다";
		StringBuilder sb = new StringBuilder();
		sb.append(linkFront).append(url).append(certKey).append(linkBack);
		send(subject, sb.toString(), "bum6613@gmail.com", email);
	}
	
	public void sendPass(String pass,String email) {
		String subject="비밀번호 찾기 관련 메일입니다.";
		StringBuffer sb=new StringBuffer();
		sb.append(pass);		
		send(subject, sb.toString(),"bum6613@gmail.com", email);
	}
	
	public boolean send(final String subject, final String text, final String from, final String to) {
		MimeMessagePreparator preparator = new MimeMessagePreparator() {
			
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
				mimeMessage.setFrom(new InternetAddress(from));
				mimeMessage.setSubject(subject);
				mimeMessage.setText(text,"utf-8","html");
			}
		};
		
		try {
			javaMailSender.send(preparator);
			return true;
		} catch (MailException e) {
			// TODO: handle exception
			return false;
		}
		
		
	}
}
