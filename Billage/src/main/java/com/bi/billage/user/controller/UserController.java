package com.bi.billage.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {
	
	// ������ ����
	
	// ������ ������
	@RequestMapping("admin.ad")
	public String adminPage() {
		return "admin/adminPage";
	}
	
	// 1:1���� ��û��
	@RequestMapping("enroll.iq")
	public String enrollInquiry() {
		return "admin/inqEnrollForm";
	}
	
	// ���� ��û��
	@RequestMapping("request.se")
	public String requestSerial() {
		return "admin/serialRequestForm";
	}
	
	@RequestMapping("enrollForm.nv")
	public String enrollNovel() {
		return "admin/novelEnrollForm";
	}
	
	// ������ ���� ��
	
	@RequestMapping("userEnrollForm.me")
	public String userEnrollForm() {
		return "user/userEnrollForm";
	}
	
	@RequestMapping("mypage.me")
	public String myPage() {
		return "user/myPage";
	}
	
}