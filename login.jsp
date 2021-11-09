<%-- 
    Document   : login
    Created on : 07-Oct-2021, 11:50:04 am
    Author     : khushiagrawal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*,java.io.IOException,java.math.BigInteger,java.util.*"%>

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

<%!
    public static int[] decryptMessage(int[] msg){
        int f = 0, k=1, d = 0;
        // Find d value
        while (f==0){
            if (((1+(k*60))%13)==0){
                d = ((1+(k*60))/13);
                f = 1;
            }else k+=1;
        }

        // Decrypt
        BigInteger de = BigInteger.valueOf(d);
        BigInteger n = BigInteger.valueOf(77);
        for (int i=0; i<msg.length; i++){
            BigInteger val = BigInteger.valueOf(msg[i]);
            BigInteger s = val.modPow(de, n);
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
            
            
            if(b.equals("Add")){%>
            <%@include file="index.jsp"%>
            
                
                <%
                int enarr[] = new int[u.length()];
                for (int j=0; j<u.length(); j++){
                    enarr[j] = map.get(u.charAt(j));
                }
                enarr = encryptMessage(enarr);
                String encrypted_usern = f.get_varchar(enarr);
                out.println("<h2'>encrypted username</h2><br/>");
                
                int enarr1[] = new int[p.length()];
                for (int j=0; j<p.length(); j++){
                    enarr1[j] = map.get(p.charAt(j));
                }
                enarr1 = encryptMessage(enarr1);
                String encrypted_pass = f.get_varchar(enarr1);
                
                PreparedStatement pstmt1=con.prepareStatement("insert into user_info values(?,?,?)");
                pstmt1.setInt(1,id);
                pstmt1.setString(2,encrypted_usern);
                pstmt1.setString(3,encrypted_pass);
                int j=pstmt1.executeUpdate();
                
                if(j>0)
                    out.println("<h2>User Added</h2><br/>");
                else
                    out.println("<h2>Cannot be added</h2><br/>");
            }

            else if(b.equals("Modify and Change")){
                PreparedStatement pstmt1=con.prepareStatement("select username,password from user_info where user_id=?");
                pstmt1.setInt(1,id);
                int count=0;
                ResultSet rs=pstmt1.executeQuery();
                while(rs.next())
                {
                    count++;
                    String name=rs.getString(1);
                    String password=rs.getString(2);
                    int[] fet_username = f.getback_arr(name);
                    int[] fet_pass = f.getback_arr(password);
                    int[] dec_username = decryptMessage(fet_username);
                    int[] dec_pass = decryptMessage(fet_pass);
                    
                    StringBuffer sb = new StringBuffer();
                    
                    for (int k=0; k<dec_username.length; k++){
                        int val = dec_username[k];
                        for (char key: map.keySet()){
                            if (map.get(key)==val){
                                sb.append(key);
                                break;
                            }
                        }
                    }
                    
                    String decrypt_username = sb.toString();
                    
                    sb.setLength(0);
                    for (int k=0; k<dec_pass.length; k++){
                        int val = dec_pass[k];
                        for (char key: map.keySet()){
                            if (map.get(key)==val){
                                sb.append(key);
                                break;
                            }
                        }
                    }
                    String decrypt_pass = sb.toString();
                    %>
                    
                    <html>
                    <head>
                            <meta charset = 'UTF-8'>
                            <meta name = 'viewport' content = 'width = device-width, initial-scale = 1.0'>
                            <meta http-equiv = 'X-UA-Compatible' content = 'ie = edge'>

                            <link rel="stylesheet" type="text/css" href="./isaa_style.css">

                            <link rel = "stylesheet" href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

                            <title>Information Security</title>
                    </head>
                        <body>
                    <div id = 'title_id'>
                            <h1>Encryption and Decryption</h1>
                    </div>

                    <form action="update.jsp" method="post" id = 'form_id'>
                            <div id = 'form_title'>
                                    <h2>Register Form</h2>
                            </div>
                            <div class="input-container">
                                    <i class="fa fa-envelope icon"></i>
                                    <input class="input-field" type="text" placeholder="ID" name="uid" value=<%=id%>>
                            </div>
                            
                            <div class="input-container">
                                    <i class = "fa fa-user icon"></i>

                                    <input class = "input-field" type="text" placeholder = "Username" name="user" value=<%=decrypt_username%>>
                            </div>

                            

                            <div class="input-container">
                                    <i class="fa fa-key icon"></i>
                                    <input class="input-field" type="password" placeholder="Password" name="pass" value=<%=decrypt_pass%>>
                            </div>
                             <div class="btn-group">
                            <input type="submit" value="Add" name="btn" id = 'add_id' class = 'btns'>
                            <input type="submit" value="Modify and Save" name="btn" id = 'add_id' class = 'btns'>
                            <input type="submit" value="View" name="btn" id = 'add_id' class = 'btns'>
                            <input type="submit" value="Delete" name="btn" id = 'add_id' class = 'btns'>
                            </div>
                            
                    </form>

                    <br>

            </body>
               
                    <%
                }
                if(count==0){%>
                    <%@include file="index.jsp"%>
                   <% out.println("<h2>Invalid User</h2>");
                }
            }


            else if(b.equals("Delete")){%>
            <%@include file="index.jsp"%>
            <%
                PreparedStatement pstmt1=con.prepareStatement("delete from user_info where user_id=?");
                pstmt1.setInt(1,id);
                int j=pstmt1.executeUpdate();
                if(j>0)
                    out.println("<h2>User Removed</h2>");
                else
                    out.println("<h2>Cannot be removed</h2>");
            }


            else if(b.equals("View")){%>
            <%@include file="index.jsp"%>
            <%
                PreparedStatement pstmt1=con.prepareStatement("select * from user_info where user_id=?");
                pstmt1.setInt(1,id);
                int count=0;
                ResultSet rs=pstmt1.executeQuery();
                while(rs.next())
                {
                    count++;
                    String name=rs.getString(2);
                    String password=rs.getString(3);
                    int[] fet_username = f.getback_arr(name);
                    int[] fet_pass = f.getback_arr(password);
                    int[] dec_username = decryptMessage(fet_username);
                    int[] dec_pass = decryptMessage(fet_pass);
                    
                    StringBuffer sb = new StringBuffer();
                    
                    for (int k=0; k<dec_username.length; k++){
                        int val = dec_username[k];
                        for (char key: map.keySet()){
                            if (map.get(key)==val){
                                sb.append(key);
                                break;
                            }
                        }
                    }
                    
                    String decrypt_username = sb.toString();
                    
                    sb.setLength(0);
                    for (int k=0; k<dec_pass.length; k++){
                        int val = dec_pass[k];
                        for (char key: map.keySet()){
                            if (map.get(key)==val){
                                sb.append(key);
                                break;
                            }
                        }
                    }
                    String decrypt_pass = sb.toString();
                    out.println("<h2>Username is "+decrypt_username+"<br/>Password is "+decrypt_pass+"</h2>");
                }
                if(count==0)
                    out.println("<h2>Invalid User</h2>");
            }
            
            
        }
        catch(Exception exe)
        {System.out.println(exe);}
        %>
    