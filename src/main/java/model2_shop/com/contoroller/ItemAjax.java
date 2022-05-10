package model2_shop.com.contoroller;

import org.json.JSONObject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model2_shop.com.dao.ItemCommentDao;
import model2_shop.com.dao.ItemDao;
import model2_shop.com.vo.ItemVo;

@WebServlet("/item/ajax.do")
public class ItemAjax extends HttpServlet {
    // list or ?id=detail
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// id 파라미터가 오면 detail을 반환
		String item_num=request.getParameter("item_num");
		
		ItemDao itemDao=new ItemDao();
		response.setContentType("application/json; charset=UTF-8");
		try {
			if(item_num==null) {
				response.getWriter().append(itemDao.list(0).toString());
			}else {
				response.getWriter().append(itemDao.detail(Integer.parseInt(item_num)).toString());
			}
		} catch (ClassNotFoundException | IOException | SQLException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 헤더 본문에 문자열에서 JSON으로 보낸 파라미터 불러오기
		ItemVo item=new ItemVo();
		ItemDao itemDao=new ItemDao();
		/*
		item.setCate_num(Integer.parseInt(json.getString("cate_num") ));
		item.setCount(Integer.parseInt(json.getString("count") ));
		item.setPrice(Integer.parseInt(json.getString("price")));
		item.setState(Byte.parseByte(json.getString("state")));
		item.setColor(json.getString("color"));
		item.setDetail_img(json.getString("detail_img"));
		item.setMain_img(json.getString("main_img"));
		item.setMember_id(json.getString("member_id"));
		item.setModel_num(json.getString("model_num"));
		item.setName(json.getString("name"));
		item.setTitle(json.getString("title"));
		String sale_time_str=json.getString("sale_time");//"2022-05-03T10:45"
		String sale_end_time_str=json.getString("sale_end_time");//"2022-05-03T10:45"
		
		System.out.println(item);
		
		boolean insert=false;
		ItemDao itemDao=new ItemDao();
		try {
			Timestamp sale_time=(sale_time_str!="")?
					Timestamp.valueOf(sale_time_str.replace("T"," ")+":00"):
					new Timestamp(new Date().getTime());
			Timestamp sale_end_time=(sale_end_time_str!="")?Timestamp.valueOf(sale_end_time_str.replace("T"," ")+":00"):null;
			item.setSale_time(sale_time);
			item.setSale_end_time(sale_end_time);
			
			insert=itemDao.insert(item);
		} catch (ClassNotFoundException | SQLException | IllegalArgumentException e) {
			e.printStackTrace();
		}
		*/
		boolean insert=false;
		boolean fileUp=true;
		String save_Path=request.getServletContext().getRealPath("public/img");
		int maxSize=1024*1024*1;
		MultipartRequest multiReq=null;
		File mainImFile=null;
		File detailImFile=null;
		try {
			multiReq=new MultipartRequest(request,save_Path,maxSize,"UTF-8",new FileRenamePolicy() {
				@Override
				public File rename(File f) {
					String ext=f.getName().substring(f.getName().lastIndexOf("."));
					String newFileName="item_"+System.currentTimeMillis()+"_"+(int)(Math.random()*10000)+ext;
					
					return new File(f.getParent(),newFileName);
				};
			});
			mainImFile=multiReq.getFile("main_img");
			detailImFile=multiReq.getFile("detail_img");
			String mainImgType=multiReq.getContentType("main_img").split("/")[0];
			// "image/jpeg" => image
			String detailImgType=multiReq.getContentType("detail_img").split("/")[0];
			String mainImgExt=multiReq.getContentType("main_img").split("/")[1];
			// "image/jpeg" => jpeg
			String detailImgExt=multiReq.getContentType("detail_img").split("/")[1];
			if(mainImgType.equals("image") && detailImgType.equals("image")) {
				// 메인 이미지 썸네일 생성
				BufferedImage mainImg=ImageIO.read(mainImFile);
				BufferedImage mainImgThumb=new BufferedImage(100, 100, BufferedImage.TYPE_3BYTE_BGR);
				mainImgThumb.getGraphics().drawImage(mainImg, 0, 0, 100, 100, null);
				ImageIO.write(mainImgThumb, mainImgExt, new File(save_Path+"/thumb/"+mainImFile.getName()));
				// 디테일 이미지 썸네일 생성
				BufferedImage detailImg=ImageIO.read(detailImFile);
				BufferedImage detailImgThumb=new BufferedImage(100, 100, BufferedImage.TYPE_3BYTE_BGR);
				detailImgThumb.getGraphics().drawImage(detailImg, 0, 0, 100, 100, null);
				ImageIO.write(detailImgThumb, detailImgExt, new File(save_Path+"/d_thumb/"+detailImFile.getName()));
			}else { 
			// 둘중에 하나라도 이미지가 아니면 두 파일 모두 삭제 => dao를 실행 x
				fileUp=false;
				mainImFile.delete();
				detailImFile.delete();
			}
		} catch (Exception e) {
			// 파일이 커서 등록 실패
			fileUp=false;
			e.printStackTrace();
		}
		if(fileUp) {
			item.setCate_num(Integer.parseInt(multiReq.getParameter("cate_num") ));
			item.setCount(Integer.parseInt(multiReq.getParameter("count") ));
			item.setPrice(Integer.parseInt(multiReq.getParameter("price")));
			item.setState(Byte.parseByte(multiReq.getParameter("state")));
			item.setColor(multiReq.getParameter("color"));
			item.setMain_img(mainImFile.getName());
			item.setDetail_img(detailImFile.getName());
			item.setMember_id(multiReq.getParameter("member_id"));
			item.setModel_num(multiReq.getParameter("model_num"));
			item.setName(multiReq.getParameter("name"));
			item.setTitle(multiReq.getParameter("title"));
			try {
				insert=itemDao.insert(item);
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			}
		}
		response.getWriter().append("{ \"insert\" : "+insert+"}");
	}


	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StringBuffer json_str=new StringBuffer();
		BufferedReader br=request.getReader(); // 본문 헤더의 문자열을 읽는 객체
		String line="";
		while((line=br.readLine())!=null) {
			json_str.append(line);
		}
		JSONObject json=new JSONObject(json_str.toString());
		
		ItemVo item=new ItemVo();
		item.setItem_num(Integer.parseInt(json.getString("item_num") ));
		item.setCate_num(Integer.parseInt(json.getString("cate_num") ));
		item.setCount(Integer.parseInt(json.getString("count") ));
		item.setPrice(Integer.parseInt(json.getString("price")));
		item.setState(Byte.parseByte(json.getString("state")));
		item.setColor(json.getString("color"));
		item.setMain_img(json.getString("main_img"));
		item.setDetail_img(json.getString("detail_img"));
		item.setModel_num(json.getString("model_num"));
		item.setMember_id(json.getString("member_id"));
		item.setName(json.getString("name"));
		item.setTitle(json.getString("title"));
		Timestamp sale_time=(json.get("sale_time")!="")?Timestamp.valueOf(json.getString("sale_time")):null;
		Timestamp sale_end_time=(json.get("sale_end_time")!="")?Timestamp.valueOf(json.getString("sale_end_time")):null;
		item.setSale_time(sale_time);
		item.setSale_end_time(sale_end_time);
//		String sale_time=json.getString("sale_time");
//		Timestamp saleTime=null;
//		if(sale_time!="" && sale_time.split(":").length==2) {
//			saleTime= Timestamp.valueOf(sale_time.replace("T"," ")+":00");
//		}else if(sale_time!="" && sale_time.split(":").length==3){
//			saleTime= Timestamp.valueOf(sale_time.replace("T"," "));
//		}
//		item.setSale_time(saleTime);
//		
//		String sale_end_time=json.getString("sale_end_time");
//		Timestamp saleEndTime=(sale_end_time!="")?Timestamp.valueOf(sale_end_time.replace("T"," ")+":00"):null;
//		item.setSale_end_time(saleEndTime);
		
		System.out.println(item);
		
		ItemDao itemDao=new ItemDao();
		boolean update=false;
		try {
			update=itemDao.update(item);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		response.getWriter().append("{ \"update\" : "+update+" }");
	}


	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String item_num=request.getParameter("item_num");
		ItemDao itemDao=new ItemDao();
		ItemCommentDao itemCommentDao=new ItemCommentDao();
		// 아이템에 달린 상품평도 동시에 삭제
		// 삭제 응답 {delete:true,comment_delete:4}

		boolean delete=false;
		int comment_delete=0;
		try {
			comment_delete=itemCommentDao.deleteItemNum(Integer.parseInt(item_num));
			delete=itemDao.delete(Integer.parseInt(item_num));
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		HashMap<String, Object> delMap=new HashMap<>();
		delMap.put("comment_delete", comment_delete);
		delMap.put("delete", delete);
		System.out.println(new JSONObject(delMap).toString());
		response.getWriter().append(new JSONObject(delMap).toString());
	}
}
