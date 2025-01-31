package com.sp.app.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Board;
import com.sp.app.service.BoardService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j	
@RequestMapping("/bbs/*")
public class BoardController {
	private final BoardService boardService;
	private final PaginateUtil paginateUtil;

	// 스프링 부트 3.2 부터는 @RequestParam, @PathVariable, @Autowired 등 에서 매개변수의 이름을 인식하지 못하는 문제 발생 
	//     Name for argument of type [java.lang.String] not specified, and parameter name information not found in class file either.
	//     해결책 : @RequestParam(name = "username") String username, @PathVariable("userId") String userId 
        //            @Qualifier("memberRepository") MemberRepository memberRepository 처럼 이름 명시
	// 메소드에서 @RequestMapping(value = "list") 처럼 매핑하면 경고 발생

	// @RequestMapping(value = "list", method = {RequestMethod.GET, RequestMethod.POST})
	@GetMapping("list")
	public String list(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req) throws Exception {
		
		// 게시글 리스트
		try {
			int size = 10; // 한 화면에 보여주는 게시물 수
			int total_page = 0;
			int dataCount = 0;

			kwd = URLDecoder.decode(kwd, "utf-8");

			// 전체 페이지 수
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);

			dataCount = boardService.dataCount(map);
			if (dataCount != 0) {
				total_page = paginateUtil.pageCount(dataCount, size);
			}

			// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
			current_page = Math.min(current_page, total_page);

			// 리스트에 출력할 데이터를 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			map.put("offset", offset);
			map.put("size", size);

			List<Board> list = boardService.listBoard(map);

			String cp = req.getContextPath();
			String query = "";
			String listUrl = cp + "/bbs/list";
			String articleUrl  = cp + "/bbs/article?page=" + current_page;
			if (! kwd.isBlank()) {  // if(kwd.length() != 0) {
				query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");

				listUrl += "?" + query;
				articleUrl += "&" + query;
			}

			String paging = paginateUtil.paging(current_page, total_page, listUrl);

			model.addAttribute("list", list);
			model.addAttribute("articleUrl", articleUrl);
			model.addAttribute("page", current_page);
			model.addAttribute("total_page", total_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("paging", paging);

			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			
		} catch (Exception e) {
			log.info("list : ", e);
		}

		return "bbs/list";
	}

	@GetMapping("write")
	public String writeForm(Model model) throws Exception {
		// 게시글 등록 폼
		model.addAttribute("mode", "write");
		return "bbs/write";
	}

	@PostMapping("write")
	public String writeSubmit(Board dto, HttpServletRequest req) throws Exception {
		// 게시글 저장
		try {
			dto.setIpAddr(req.getRemoteAddr());
			boardService.insertBoard(dto);
		} catch (Exception e) {
			log.info("writeSubmit : ", e);
		}

		return "redirect:/bbs/list";
	}

	@GetMapping("article")
	public String article(@RequestParam(name = "num") long num,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model) throws Exception {
		// 게시글 보기
		String query = "page=" + page;
		try {
			kwd = URLDecoder.decode(kwd, "utf-8");
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
			}

			// 조회수 증가 및 해당 레코드 가져 오기
			boardService.updateHitCount(num);

			Board dto = Objects.requireNonNull(boardService.findById(num));

			// 스타일로 처리하는 경우 : style="white-space:pre;"
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

			// 이전 글, 다음 글
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("num", num);

			Board prevDto = boardService.findByPrev(map);
			Board nextDto = boardService.findByNext(map);

			model.addAttribute("dto", dto);
			model.addAttribute("prevDto", prevDto);
			model.addAttribute("nextDto", nextDto);

			model.addAttribute("page", page);
			model.addAttribute("query", query);

			return "bbs/article";
			
		} catch (NullPointerException e) {
			log.debug("article : ", e);
		} catch (Exception e) {
			log.info("article : ", e);
		}
		
		return "redirect:/bbs/list?" + query;
	}

	@GetMapping("update")
	public String updateForm(@RequestParam(name = "num") long num,
			@RequestParam(name = "page") String page,
			Model model) throws Exception {
		// 수정 폼
		try {
			Board dto = Objects.requireNonNull(boardService.findById(num));

			model.addAttribute("mode", "update");
			model.addAttribute("page", page);
			model.addAttribute("dto", dto);

			return "bbs/write";
		} catch (NullPointerException e) {
			log.debug("updateForm : ", e);
		} catch (Exception e) {
			log.info("updateForm : ", e);
		}
		
		return "redirect:/bbs/list?page=" + page;
	}

	@PostMapping("update")
	public String updateSubmit(Board dto,
			@RequestParam(name = "page") String page) throws Exception {
		// 수정 완료
		try {
			boardService.updateBoard(dto);
		} catch (Exception e) {
			log.info("updateSubmit : ", e);
		}

		return "redirect:/bbs/list?page=" + page;
	}

	@RequestMapping(value = "delete")
	public String delete(@RequestParam(name = "num") long num,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd) throws Exception {
		// 게시글 삭제
		String query = "page=" + page;
		try {
			kwd = URLDecoder.decode(kwd, "utf-8");
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
			}
			
			boardService.deleteBoard(num);
		} catch (Exception e) {
			log.info("delete : ", e);
		}

		return "redirect:/bbs/list?" + query;
	}
}
