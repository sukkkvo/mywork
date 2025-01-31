package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.model.Demo;
import com.sp.app.service.DemoService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/demo/*")
public class DemoController {
	private final DemoService service;
	
	@GetMapping("write")
	public String handleForm() {
		return "demo/write";
	}
	
	@PostMapping("write")
	public String handleSubmit(
			Demo dto,
			final RedirectAttributes rAttr,
			Model model) {
		
		try {
			
			service.insertDemo(dto);
			
			rAttr.addFlashAttribute("message", "데이터 등록 성공!!!");
		} catch (Exception e) {
			rAttr.addFlashAttribute("message", "데이터 등록 실패ㅗㅗㅗ");
		}
		
		return "redirect:/demo/complete";
	}
	
	@GetMapping("complete")
	public String handleComplete(
			@ModelAttribute("message") String message) {
		
		return "demo/result";
	}
	
	
}
