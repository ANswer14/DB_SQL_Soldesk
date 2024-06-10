package com.lyh.franc.main;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Scanner;

import com.lyh.db.manager.LyhDBManger;
import com.lyh.franc.reservation.Reservation;
import com.lyh.franc.restaurant.Restaurant;

public class DAO {
	// MVC패턴의 M
	//		DAO / DTO 패턴
	// 		DAO (Data Access Object)
	//			: M 중에서 DB관련한 작업을 전담하는 클래스 
	//		DTO (Data Transfer / Temp Object)
	//			: DAO의 작업결과를 표현하는 클래스 (Reservation / Restaurant)
	
	// 	java.util.Date - 주력 (Spring에서는 이걸 원함)
	//	java.sql.Date - JDBC에서는 이걸 원함
	
	// 	java.util.Date => java.sql.Date
	//		: new Date(클래스명.get날짜관련멤버변수명().getTime());
	
	// 	java.sql.Date => java.util.Date : 알아서 바꿔줌
	
		// 1. 예약하기
		public static String book(Reservation rsv) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = LyhDBManger.connect();
				String sql = "insert into reservation "
						+ "values(reservation_seq.nextval, ?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, rsv.getName());
				pstmt.setDate(2, new Date(rsv.getWhen().getTime()));
				pstmt.setString(3,rsv.getPhone());
				pstmt.setString(4, rsv.getLocation());
				
				if (pstmt.executeUpdate() == 1) {
					return "예약 성공!";
				}
				return ""; // Java문법상 필요해서 억지로 넣은 것!
			} catch (Exception e) {
				e.printStackTrace();
				return "예약 실패";
			} finally {
				LyhDBManger.close(con, pstmt, null);
			}
			
		}
		
		
		// 2. 매장 등록
		public static String register(Restaurant rst) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = LyhDBManger.connect();
			String sql = "insert into burgerking "
					+ "values(?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rst.getLocation());
			pstmt.setString(2, rst.getCeo());
			pstmt.setInt(3, rst.getSeat());
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
			if (pstmt.executeUpdate() == 1) {
				return "등록 성공!";
			}
			return ""; // Java문법상 필요해서 억지로 넣은 것!
		} catch (Exception e) {
			e.printStackTrace();
			return "등록 실패";
		} finally {
			LyhDBManger.close(con, pstmt, null);
		}
		}
		// 3. 전체 예약 확인 (예약번호 오름차순 정렬)
		public static ArrayList<Reservation> checkRsv() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = LyhDBManger.connect();
				String sql = "select * from reservation order by r_no";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd / E a HH:mm");
				
				ArrayList<Reservation> rsvs = new ArrayList<Reservation>();
				
				Reservation r = null;
				while (rs.next()) {
//					System.out.println(rs.getInt("r_no"));
//					System.out.println(rs.getString("r_name"));
//					System.out.println(sdf.format(rs.getDate("r_time").getTime()));
//					System.out.println(rs.getString("r_phone_number"));
//					System.out.println(rs.getString("b_location"));
					r = new Reservation();
					r.setNo(rs.getInt("r_no"));
					r.setName(rs.getString("r_name"));
					r.setWhen(rs.getDate("r_time"));
					r.setPhone(rs.getString("r_phone_number"));
					r.setLocation(rs.getString("b_location"));
					rsvs.add(r);
				}
				return rsvs;
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			} finally {
				LyhDBManger.close(con, pstmt, rs);
			}
		}
		// 4. 전체 매장 확인 (지점명 오름차순 정렬)
		public static void checkRst() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				con = LyhDBManger.connect();
				String sql = "select b_location||'('||b_seat||')'||'-'||b_ceo info from burgerking order by b_location";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				while (rs.next()) {
					System.out.println(rs.getString("info"));
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				LyhDBManger.close(con, pstmt, rs);
			}
		}
		// 5. 매장 찾기 (입력한 좌석 수 이상을 가지고 있는 매장, 지점명 오름차순 정렬)
//		public static void searchRst() {
//			Scanner k = new Scanner(System.in);
//			Connection con = null;
//			PreparedStatement pstmt = null;
//			ResultSet rs = null;
//			System.out.print("좌석 수 : ");
//			int seat = k.nextInt();
//			try {
//				con = LyhDBManger.connect();
//				String sql = "select b_location from burgerking where b_seat >=" + seat + "order by b_location";
//				
//				pstmt = con.prepareStatement(sql);
//				
//				rs = pstmt.executeQuery();
//				while (rs.next()) {
//					System.out.println(rs.getString("b_location"));
//				}
//				
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//			
//		}
		public static ArrayList<Restaurant> searchRst() {
			Scanner k = new Scanner(System.in);
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			System.out.print("좌석 수 : ");
			int seat = k.nextInt();
			try {
				con = LyhDBManger.connect();
				String sql = "select b_location from burgerking where b_seat >=" + seat + "order by b_location";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				ArrayList<Restaurant> arst = new ArrayList<Restaurant>();
				Restaurant r = null;
				
				while (rs.next()) {
					r = new Restaurant();
					r.setLocation(rs.getString("b_location"));
					r.setCeo(rs.getString("b_ceo"));
					r.setSeat(rs.getInt("b_seat"));
					arst.add(r);
				}
				
				return arst;
				}catch (Exception e) {
					return null;
				}finally {
					LyhDBManger.close(con, pstmt, rs);
				}
		}
		// 6. 예약 찾기 (예약자의 이름으로 찾기, 예약번호 오름차순 정렬)
		public static ArrayList<Reservation> searchRsv(Reservation rsv) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = LyhDBManger.connect();
				
				String sql = "select * from reservation "
						+ "where r_name like '%'||?||'%' "
						+ "order by r_no";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				pstmt.setString(1, rsv.getName());
				rs = pstmt.executeQuery();
				
				ArrayList<Reservation> rsvs = new ArrayList<Reservation>();
				while (rs.next()) {
					rsvs.add(new Reservation(rs.getInt("r_no"), rs.getString("r_name"), rs.getDate("r_time"), rs.getString("r_phone_number"), rs.getString("b_location")));
				}
				return rsvs;
				
			} catch (Exception e) {
				return null;
			} finally {
				LyhDBManger.close(con, pstmt, rs);
			}
			
		}
		// 7. 예약정보수정 (예약자의 전화번호 수정하기)
		public static String updateRsv(Reservation rsv) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = LyhDBManger.connect();
				String sql = "update reservation set r_phone_number =? where r_no = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, rsv.getPhone());
				pstmt.setInt(2, rsv.getNo());
				
				if (pstmt.executeUpdate() == 1) {
					return "예약수정 성공";
				}
				return "예약정보 없음";
			} catch (Exception e) {
				e.printStackTrace();
				return "예약수정 실패";
			}finally {
				LyhDBManger.close(con, pstmt, null);
			}
		}
		
		// 8. 예약취소 (예약 번호로 취소하기)
//		public static void cancleRsv() {
//			Connection con = null;
//			PreparedStatement pstmt = null;
//			
//			Scanner k = new Scanner(System.in);
//			System.out.print("예약번호 : ");
//			int num = k.nextInt();
//			
//			try {
//				con = LyhDBManger.connect();
//				String sql = "delete * from reservation where r_no = ?";
//				pstmt = con.prepareStatement(sql);
//				pstmt.setInt(1, num);
//				
//				System.out.println("취소 성공");
//			} catch (Exception e) {
//				System.out.println("취소 실패");
//				e.printStackTrace();
//			}finally {
//				LyhDBManger.close(con, pstmt, null);
//			}
//		}
		public static String deleteRsv(Reservation rsv) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			Scanner k = new Scanner(System.in);
			int num = k.nextInt();
			
			try {
				con = LyhDBManger.connect();
				String sql = "delete from reservation where r_no = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, rsv.getNo());
				
				if (pstmt.executeUpdate() >= 1) {
					return "예약취소 성공";
				}
					return "예약정보 없음";
			} catch (Exception e) {
				e.printStackTrace();
				return "예약취소 실패";
			}finally {
				LyhDBManger.close(con, pstmt, null);
			}
			
		}
		}
	
	
	
	
	

