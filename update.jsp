<%-- 
    Document   : x
    Created on : 07-Oct-2021, 12:12:48 pm
    Author     : khushiagrawal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*,java.io.IOException,java.math.BigInteger,java.util.*"%>
<%@include file="index.jsp"%>

<%! private static HashMap<Character, Integer> map = new HashMap<>();%>

<%!
    class Funcs{
    public String get_varchar(int[] arr){
        StringBuffer sb = new StringBuffer();
        for (int i=0; i<arr.length-1; i++){
            sb.append(String.valueOf(arr[i])+" ");
        }
        sb.append(String.valueOf(arr[arr.length-1]));
        return sb.toString();
    }

    public int[] getback_arr(String s){
        String[] sarr = s.split(" ");
        int[] arr= new int[sarr.length];
        for (int i=0; i<arr.length; i++){
            arr[i] = Integer.parseInt(sarr[i]);
        }
        return arr;
    }
}
%>

<%!
    public static int[] encryptMessage(int[] msg){
        BigInteger b = BigInteger.valueOf(77);
        BigInteger e = BigInteger.valueOf(13);
        for (int i=0; i<msg.length; i++){
            BigInteger val = BigInteger.valueOf(msg[i]);
            BigInteger s = val.modPow(e, b);
            msg[i] = s.intValue();
        }
        return msg;
    }
%>

<%
    try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            String conURL="jdbc:mysql://localhost:3306/isaa_da";
            String user="root";
            String pass="";
            Connection con=DriverManager.getConnection(conURL,user,pass);
            String b=request.getParameter("btn");
            int id=Integer.parseInt(request.getParameter("uid")); 
            String u=request.getParameter("user");
            String p=request.getParameter("pass");
            %>
            <%! Funcs f = new Funcs();%>
            <%
            
            int i = 0;
            for (char c='a'; c<='z'; c++){
                map.put(c, i);
                i++;
            }
            map.put(' ', 26);
            map.put('.', 27);
            map.put(',', 28);
            map.put('-', 29);
            i+=5;
            for (char c='A'; c<='Z'; c++){
                map.put(c, i);
                i++;
            }
            
            if(b.equals("Modify and Save")){
            
            int enarr[] = new int[u.length()];
            for (int j=0; j<u.length(); j++){
                enarr[j] = map.get(u.charAt(j));
            }
            enarr = encryptMessage(enarr);
            String encrypted_usern = f.get_varchar(enarr);
 
            int enarr1[] = new int[p.length()];
            for (int j=0; j<p.length(); j++){
                enarr1[j] = map.get(p.charAt(j));
            }
            enarr1 = encryptMessage(enarr1);
            String encrypted_pass = f.get_varchar(enarr1);
            
            PreparedStatement pstmt1=con.prepareStatement("update user_info set username=?,password=? where user_id=?");
            pstmt1.setString(1,encrypted_usern);
            pstmt1.setString(2,encrypted_pass);
            pstmt1.setInt(3,id);
            int j=pstmt1.executeUpdate();
            if(j>0){
            out.println("<h2>Updated User Credentials</h2><br/>");
            %>
            
            <%
    }
    else{
            out.println("<h2>Cannot be updated</h2><br/>");
        }
    }
    }
    catch(Exception exe)
    {System.out.println(exe);}
    %>
