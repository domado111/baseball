package controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.REngineException;
import org.rosuda.REngine.Rserve.RConnection;

import dao.GameDAO;
import model.GameCountVO;

public class RserveService {
	GameDAO gameDao=GameDAO.getInstance();
	private static RserveService instance=new RserveService();
	public static void main(String[] args) {}
	public static RserveService getInstance() {
		return instance;
	}
	public Map rData(String path,String dateInput) throws REXPMismatchException,REngineException, ParseException{
		// TODO Auto-generated method stub		
		Map map=new HashMap();
		int gameDataCount=gameDao.getGameDataCount();
		System.out.println(gameDataCount);
		
		RConnection c=new RConnection();
		String imgpath=path+"rimg"+"/"+"dailyData.jpg";
		System.out.println(imgpath);
		
		ArrayList<String> dateList=new ArrayList();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
		Date date = sdf.parse(dateInput);
		Calendar calendar=Calendar.getInstance();		
		calendar.setTime(date);
		
		//date 세팅
		calendar.add(Calendar.DATE,-6);
		for(int i=0;i<7;i++) {
			String strDate=sdf.format(calendar.getTime());
			dateList.add(strDate);	//7일 데이터 들어감	
			System.out.println(strDate);
			calendar.add(Calendar.DATE,+1);
		}
		
		//dates string 세팅
		String dates="\""+dateList.get(0)+"\"";
		for(int i=1;i<7;i++) {
			dates+=",\""+dateList.get(i)+"\"";
		}
		System.out.println(dates);
		
		List<GameCountVO> gameDataList=gameDao.getGameCountList(dateInput);
		ArrayList<String> gameDateList=new ArrayList<String>();
		
		if(gameDataCount!=0) {//db값이 있을 때
			
		
		for(int i=0;i<gameDataList.size();i++) {
			gameDateList.add(gameDataList.get(i).getStart_date());
		}
		System.out.println(gameDateList);
		ArrayList<Integer> countList=new ArrayList();
		
		//countList세팅
		for(int i=0;i<7;i++) {
			System.out.println(dateList.get(i));
			for(int k=0;k<gameDateList.size();k++) {
				if(dateList.get(i).equals(gameDateList.get(k))) {
					System.out.println(gameDataList.get(k).getCount()+"====gameDataList.get(k)");
					countList.add(gameDataList.get(k).getCount());
				}
			}
			if(!gameDateList.contains(dateList.get(i))) {
				countList.add(0);
			}
			System.out.println(countList);

		}
		
		//String count세팅
		
		String count=countList.get(0)+"";
		for(int i=1;i<7;i++) {
			count+=","+countList.get(i);
		}
		
		//출력용 string 세팅
		String xprint="\""+dateList.get(0)+"("+countList.get(0)+")\"";
		for(int i=1;i<7;i++) {
			xprint+=",\""+dateList.get(i)+"("+countList.get(i)+")\"";
		}
		System.out.println(xprint);

		
		c.parseAndEval("png('"+imgpath+"', width=800,height=600)");
		c.parseAndEval("data <-c("+count+")");
		c.parseAndEval("plot(data, type=\"o\", col=\"blue\", axes=F,ann=F)");
		c.parseAndEval("axis(1, at=1:7, labels =c("+xprint+"))");
		c.parseAndEval("axis(2, ylim=c(0,1000))");

		c.parseAndEval("dev.off()");

		c.close();
		System.out.println(dateList+"<<dateList");
		map.put("dateList", dateList);
		map.put("countList", countList);
		}
		
		return map;
	}
	
	
	
}
