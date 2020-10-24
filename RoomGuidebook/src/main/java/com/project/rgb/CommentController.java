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
			List<CommentDTO> commentList = commentService.getList(1); // 에러 없앨라고 번호 넣은거니 또 처리 잘 해라.
			return commentList;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null; // ...여기서 잘못된거를 돌려주는 식으로 가야하나...
	} //ResponseEntity같은 경우는 호출한 쪽으로 에러의 원인 메시지를 전송할 때 주로 사용하는 듯 하여 리턴타입을 바꿨습니다.
	
	
	////////////////////여기서부터는 테스트입니다.////////////////////
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public void ajaxTest() {
		
	} //Ajax 테스트(조회용으로 사용했었음.
	
	@RequestMapping(value = "/registerComment", method = RequestMethod.POST)
	public void register(@RequestBody CommentDTO comment) {
		System.out.println("여기서부터 실험입니다.");
		System.out.println(comment.getCommentId());
		System.out.println(comment.getMemberId());
		System.out.println(comment.getContent());
		System.out.println(comment.getDate());
		System.out.println(comment.getBoardId());
		System.out.println(comment.getUpperId());
	}
}
