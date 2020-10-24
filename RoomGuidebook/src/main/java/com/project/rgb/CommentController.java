package com.project.rgb;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import boardAndCommentManagement.CommentService;
import dto.CommentDTO;

@Controller
public class CommentController {
	
	@Autowired
	CommentService commentService;
	
	@RequestMapping(value = "/getCommentList", method = RequestMethod.GET)
	@ResponseBody
	public List<CommentDTO> getList() {
		try {
			List<CommentDTO> commentList = commentService.getList(1); // ���� ���ٶ�� ��ȣ �����Ŵ� �� ó�� �� �ض�.
			return commentList;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null; // ...���⼭ �߸��ȰŸ� �����ִ� ������ �����ϳ�...
	} //ResponseEntity���� ���� ȣ���� ������ ������ ���� �޽����� ������ �� �ַ� ����ϴ� �� �Ͽ� ����Ÿ���� �ٲ���ϴ�.
	
	
	////////////////////���⼭���ʹ� �׽�Ʈ�Դϴ�.////////////////////
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public void ajaxTest() {
		
	} //Ajax �׽�Ʈ(��ȸ������ ����߾���.
	
	@RequestMapping(value = "/registerComment", method = RequestMethod.POST)
	public void register(@RequestBody CommentDTO comment) {
		System.out.println("���⼭���� �����Դϴ�.");
		System.out.println(comment.getCommentId());
		System.out.println(comment.getMemberId());
		System.out.println(comment.getContent());
		System.out.println(comment.getDate());
		System.out.println(comment.getBoardId());
		System.out.println(comment.getUpperId());
	}
}
