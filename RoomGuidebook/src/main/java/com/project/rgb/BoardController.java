package com.project.rgb;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import boardAndCommentManagement.BoardService;
import dto.BoardDTO;
import dto.ImageDTO;

@Controller
public class BoardController {
	@Autowired
	BoardService boardService;
	
	
	@RequestMapping(value = "/registerBoard", method = RequestMethod.POST)
	public String register(BoardDTO board, ImageDTO image, RedirectAttributes ra) {
		
		return null;
	}
	
	@RequestMapping(value = "/getBoardList", method = RequestMethod.GET)
	public String list(@RequestParam(value="page", defaultValue="1") int page, Model model) {
		try {
			List<BoardDTO> boardList = boardService.getList(page);
			model.addAttribute("boardList", boardList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return "/board/BoardListView"; 
	}
	
	@RequestMapping(value = "/getBoard", method = RequestMethod.GET)
	public String get(@RequestParam(value="no") int no, Model model) {
		try {
			Object[] board = boardService.get(no);
			model.addAttribute("board", (BoardDTO)board[0]);
			model.addAttribute("image", (ImageDTO)board[1]);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return "board/BoardView";
	}
}
