package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    //DB Access Object
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    //contructor
    public UserDAO(){
        try{
            // Access Local Host and Databse:BBS
            String dbURL = "jdbc:mysql://localhost:3306/BBS";
            String dbID = "root";
            String dbPassword = "123456789";
            // To find Library to find DB
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
            // all the information will be stored in "conn" object.

        }catch (Exception e){
            //when issue occure, print statcktrace, means show what is the error
            e.printStackTrace();
        }
    }

    public int login (String userID, String userPassword){
        //Bring user Password
        String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
        try {
            // To Prevent SQL injection Hacking!!, use prepared Statement
            // details: Prepare one senetence, and use =? , later the content of ?, insert as userID
            //parameter userID can be inserted to ?
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                if (rs.getString(1).equals(userPassword)) {
                    return 1; // login succuess
                } else {
                    return 0; // password is not correct
                }
            }
            return -1; // there is no ID

        } catch (Exception e){
            e.printStackTrace();

        }
        return -2; // Dataabse Error means -2
    }
}
