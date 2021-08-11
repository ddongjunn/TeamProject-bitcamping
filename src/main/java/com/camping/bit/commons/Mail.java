package com.camping.bit.commons;

import com.camping.bit.dto.MemberDto;
import org.apache.commons.mail.HtmlEmail;

public class Mail {

	public void sendEmail(MemberDto dto) {
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com"; //네이버 이용시 smtp.naver.com
		String hostSMTPid = "bitcamping00@gmail.com";
		String hostSMTPpwd = "qlxm1234";

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "bitcamping00@gmail.com";
		String fromName = "비트캠핑";

		String subject = "";
		String msg = "";

		subject = "[비트캠핑] 임시 비밀번호 발급 안내";
		msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
		msg += "<h3 style='color: blue;'>";
		msg += dto.getId() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
		msg += "<p>임시 비밀번호 : ";
		msg += dto.getPwd() + "</p></div>";


		// 받는 사람 E-Mail 주소
		String mail = dto.getEmail();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSL(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(465); //네이버 이용시 587

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setTLS(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
	}
}
