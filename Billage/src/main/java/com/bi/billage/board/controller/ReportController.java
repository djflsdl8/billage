package com.bi.billage.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ReportController {
	
	@RequestMapping("list.ro")
	public String selectReportList() {
		return "board/reportBoard/reportBoardListView";
	}
	
	@RequestMapping("detail.ro")
	public String selectReportDetail() {
		return"board/reportBoard/reportBoardDetailView";
	}
	
	@RequestMapping("insertForm.ro")
	public String insertReportForm() {
		return"board/reportBoard/reportEnrollForm";
	}
}