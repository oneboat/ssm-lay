package com.panda.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtil
{
	
  public static boolean isNullOrEmpty(String str)
  {
    if (str == null)
      return true;

    return (str.trim().length() == 0);
  }

  public static boolean isNullOrEmpty(Object str)
  {
    if (str == null)
      return true;
    if (str instanceof String)
      return isNullOrEmpty((String)str);
    return false;
  }

  public static String repairName(String name) {
    if (name.trim().startsWith(":"))
      return name.trim().substring(1);
    return name;
  }

  public static boolean isNumeric(String str) {
    Pattern pattern = Pattern.compile("[0-9]*");
    Matcher isNum = pattern.matcher(str);

    return (isNum.matches());
  }

  public static String replaceAllPunct(String str)
  {
    str = str.replaceAll("\\p{Punct}", "");
    str = str.replaceAll("\\pP", "");

    return str;
  }

  public static Date getDateByStr(String str)
  {
    int dotIndex = str.indexOf(".");
    if (dotIndex != -1)
      str = str.substring(0, str.indexOf("."));

    SimpleDateFormat myFmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    try {
      Date newdate = myFmt.parse(str);
      return newdate;
    } catch (Exception e) {
      e.printStackTrace();
      return null;
    }
  }

  public static String getStrByDate(Date date) {
    SimpleDateFormat myFmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    return myFmt.format(date);
  }

  public static String correctTel(String str) {
    return str.substring(str.length() - 11);
  }

  public static String chopLeftChar(String source, char c)
  {
    String returnValue = source;

    if (returnValue == null) {
      return null;
    }

    do
      returnValue = returnValue.substring(1);
    while (returnValue.startsWith(String.valueOf(c)));

    return returnValue;
  }

  public static String lefgPadding(String source, char c, int length)
  {
    if (source == null) {
      return null;
    }

    if (source.length() >= length)
      return source;

    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < length - source.length(); ++i) {
      sb.append(c);
    }

    sb.append(source);

    return sb.toString();
  }

  public static String rightPadding(String source, char c, int length)
  {
    if (source == null) {
      return null;
    }

    if (source.length() >= length)
      return source;

    StringBuilder sb = new StringBuilder(source);
    for (int i = 0; i < length - source.length(); ++i) {
      sb.append(c);
    }

    return sb.toString();
  }

  public static String paseListToString(List source, String separator)
  {
    String strList = "";
    for (int i = 0; i < source.size(); ++i) {
      strList = strList + ((String)source.get(i));
      if (i < source.size() - 1)
        strList = strList + separator;
    }

    return strList;
  }

  public static List<String> paseStringToList(String source, String separator)
  {
    String[] arrayOfString1;
    List list = new ArrayList();
    if ((source == null) || (source.length() == 0))
      return list;

    String[] strs = source.split(separator);
    int j = (arrayOfString1 = strs).length; for (int i = 0; i < j; ++i) { String str = arrayOfString1[i];
      list.add(str);
    }
    return list;
  }
}