package com.sp.app.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.sp.app.common.APISerializer;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/*")
@RequiredArgsConstructor
public class MyApiController {
	private final APISerializer serializer;
	
	@GetMapping("main")
	public ModelAndView main() {
		return new ModelAndView("api/main");
	}
	
	// AJAX JSON 형식의 문자열 반환
	@GetMapping(value = "weather")
	public String weatherJSON(@RequestParam(name = "nx") String nx,
			@RequestParam(name = "ny") String ny) { 
		String result = null;
		
		String servicekey = "내 api key";
		String spec = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst";
		int numOfRows = 10;
		int pageNo = 1;
		String dataType = "JSON";
		String base_date = "20250206";
		String base_time = "1100";
		
		String params = "ServiceKey=" + servicekey + "&numOfRows=" + numOfRows + "&pageNo=" + pageNo 
				+ "&base_date=" + base_date + "&base_time=" + base_time 
				+ "&nx=" + nx + "&ny=" + ny + "&dataType=" + dataType;
		
		spec += "?" + params;
		
		try {
			result = serializer.receiveToString(spec);
		} catch (Exception e) {
		}
			
		return result;
	}
	
	// AJAX-XML 형식 문자열 반환
	@GetMapping(value = "weatherXML")
	public String weatherXML() throws Exception { 
		String result = null;
		
		String spec = "https://www.kma.go.kr/XML/weather/sfc_web_map.xml";
		
		try {
			result = serializer.receiveToString(spec);
		} catch (Exception e) {
		}
		
		return result;
	}
	
}
