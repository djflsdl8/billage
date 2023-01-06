package com.bi.billage.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BoardController {
	
	// ��ǰ ����Ʈ ȭ��
	@RequestMapping("list.nv")
	public String novelListView() {
		return "board/novelBoard/novelListView";
	}
	
	// ���� ����Ʈ ȭ��
	@RequestMapping("list.se")
	public String serialListView() {
		return "board/serialBoard/serialListView";
	}
	
	// ���� �󼼺��� ȭ��
	@RequestMapping("detail.se")
	public String serialDetailView() {
		return "board/serialBoard/serialDetailView";
	}
	
	// ���� �ۼ� ȭ��
	@RequestMapping("enrollForm.se")
	public String serialEnroll() {
		return "board/serialBoard/serialEnrollForm";
	}

}
