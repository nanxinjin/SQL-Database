import java.sql.*;

class Part4 {
    
    public static void main(String[] args) {
        try {
            Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@claros.cs.purdue.edu:1524:strep", args[0], args[1]);
            conn.setAutoCommit(false);
            String a = "SELECT title,name,address,hall,starttime,endtime FROM Showtimes NATURAL JOIN Movies NATURAL JOIN Theaters WHERE movieID = '"+args[2]+"'";
            String b = "SELECT movieID, age, COUNT(*) FROM (SELECT userID, age, movieID,showID FROM Tickets NATURAL JOIN Showtimes NATURAL JOIN Users) WHERE movieID = '"+args[2]+"' GROUP BY movieID, age";
            //System.out.println(a);
            //System.out.println(b);
            PreparedStatement ps1 = conn.prepareStatement(a);
            PreparedStatement ps2 = conn.prepareStatement(b);
            ResultSet rs1 = ps1.executeQuery();
            ResultSet rs2 = ps2.executeQuery();
            while ( rs1.next() )
            {
                System.out.println( "Movie Name: " + rs1.getString(1) );
                System.out.println( "   Theater Name: " + rs1.getString(2) );
                System.out.println( "   Address: " + rs1.getString(3) );
                System.out.println( "   Hall: " + rs1.getString(4) );
                System.out.println( "   Start Time: " + rs1.getString(5) );
                System.out.println( "   End Time: " + rs1.getString(6) );
            }
	    System.out.println("");
            while ( rs2.next() )
            {
                System.out.println("The movieID is: " + rs2.getString(1));
                //System.out.println( rs2.getString(1) );
                System.out.println( "   " + "Age Group: " + rs2.getString(2) );
                System.out.println( "   " + "Number of Users in the Group: " + rs2.getString(3) );
            }
            conn.rollback();
            rs1.close();
            rs2.close();
            ps1.close();
            ps2.close();
        }
        catch ( SQLException s ) {
            System.err.println( s.getMessage() );
        }
    }
}

//To run this program:
//Complile in this way: javac b4_jinn.java
//Run in this way: java -cp .:/p/oracle12c/ojdbc7.jar Part4 jinn Kim1004! movieId
//java version "1.8.0_92"
