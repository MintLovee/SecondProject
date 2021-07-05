package util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class MyCalendar {
	public static boolean isLeapYear(int year) {
		return (year % 4 ==0) && (year % 100 !=0) ||(year % 400 ==0);
	}
	
	public static int lastDay(int year ,int month ) {
		int[] m = {31,28,31,30,31,30,31,31,30,31,30,31};
		m[1]=isLeapYear(year)? 29:28;
		return m[month-1];
	}
	
	public static int totalDay(int year, int month, int day) {
		int sum = (year-1)*365 +(year-1)/4 - (year-1)/100 +(year-1)/400;
		for (int i = 1; i < month; i++) {
			sum += lastDay(year,i);
		}
		return sum + day;
	}
	
	public static int weekDay(int year, int month, int day) {
		return totalDay(year, month, day) % 7;
	}
	
	public static int printDay(int year, int month, int day) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
		@SuppressWarnings("deprecation")
		Date cDay = new Date(year, month-1, day);
		int printDay = Integer.parseInt(sdf.format(cDay));
		return printDay;
	}
	
	public static String printDay2(int year, int month, int day) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
		@SuppressWarnings("deprecation")
		Date cDay = new Date(year, month-1, day);
		String printDay = sdf.format(cDay);
		return printDay;
	}
	
	public static int today() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
		Date now = new Date();
		int today = Integer.parseInt(sdf.format(now));
		return today;
	}
	
	public static int afterWeeks() {
		Date now = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(now);
		cal.add(Calendar.DATE, 56);
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
		int afterWeeks = Integer.parseInt(sdf.format(cal.getTime()));
		return afterWeeks;
	}
}