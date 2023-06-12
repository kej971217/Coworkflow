package kr.or.ddit.commons.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.vo.News;

@Service
public class WebCrawlerService {
	
	
	
    public List<News> getNewsFromNaver(String keyword) {
        List<News> newsList = new ArrayList<>();
        
        //전체 기간
        String url = "https://search.naver.com/search.naver?where=news&sm=tab_jum&query=" + keyword;
        
        //1일 기간 내
//        String url = "https://search.naver.com/search.naver?where=news&query=" + keyword + "&sm=tab_opt&sort=0&photo=0&field=0&pd=4&ds=&de=&docid=&related=0&mynews=0&office_type=0&office_section_code=0&news_office_checked=&nso=so%3Ar%2Cp%3A1d&is_sug_officeid=0";

        System.out.println(url);
        
        try {
            Document doc = Jsoup.connect(url).get();

            Elements titles = doc.select("a.news_tit");
            Elements descriptions = doc.select(".news_dsc .dsc_wrap");
            Elements beforeTimes = doc.select(".news_info .info_group span.info");
            
            if(titles.size() != 0 ) {
            	for (int i = 0; i < titles.size(); i++) {
            		String addr = titles.get(i).attr("href");
            		String title = titles.get(i).text();
            		String description = descriptions.get(i).text();
            		String beforeTime = beforeTimes.get(i).text();
            		
            		News news = new News(addr, title, description, beforeTime);
            		newsList.add(news);
            	}
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return newsList;
    }
}
