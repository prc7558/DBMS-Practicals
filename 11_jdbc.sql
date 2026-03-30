-- 1. CREATE DATABASE & USER (MYSQL)
SHOW DATABASES;

CREATE DATABASE testdb11;

CREATE USER 'testuser@localhost' IDENTIFIED BY 'Password';
CREATE USER 'testuser11' IDENTIFIED BY 'Password';

GRANT ALL PRIVILEGES ON testdb11.* TO 'testuser@localhost';
GRANT ALL PRIVILEGES ON testdb11.* TO 'testuser11';

FLUSH PRIVILEGES;


-- 2. INSTALL MYSQL CONNECTOR (JDBC DRIVER)
Downloading MySQL Connector/J Driver from https://downloads.mysql.com/archives/c-j/

Product Version: 8.0.20
Operating System: Ubuntu Linux
OS Version: All

Install the Driver & extract the deb file.

Copy path of mysql-connector-java-8.0.20.jar = /home/mmcoe1/Downloads/mysql-connector-java_8.0.20-1ubuntu20.04_all/data/usr/share/java/mysql-connector-java-8.0.20.jar


-- 3. SIMPLE JAVA CONNECTION PROGRAM
import java.sql.*;

public class myclass2 {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/testdb11";
        String user = "testuser@localhost";
        String password = "Password";

        try {
            System.out.println("Connecting to database...");
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println("Success: Connected!");
            conn.close();
        } catch (SQLException e) {
            System.out.println("Connection failed!");
            e.printStackTrace();
        }
    }
}

import java.sql.*;

public class myclass {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/testdb11";
        String user = "testuser11";
        String password = "Password";

        try {
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println("Connected successfully!");
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

javac myclass2.java

java -cp .:/path/mysql-connector-java.jar myclass2


-- 4. CREATE TABLE
USE testdb11;

CREATE TABLE Stud (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT
);

INSERT INTO Stud VALUES
(1, 'Parth', 60),
(2, 'Vikrant', 70),
(3, 'Altamash', 80),
(4, 'Anula', 65),
(5, 'Ashlesha', 75);


-- 5. JAVA PROGRAM
import java.sql.*;
import java.util.Scanner;

public class Assignment11 {

    static final String DB_URL = "jdbc:mysql://localhost:3306/testdb11";
    static final String USER = "testuser11";
    static final String PASS = "Password";

    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);

        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {

            System.out.println("Connected successfully!");

            int choice;

            do {
                System.out.println("\n1. Add Record");
                System.out.println("2. View Records");
                System.out.println("3. Edit Record");
                System.out.println("4. Delete Record");
                System.out.println("5. Exit");

                System.out.print("Enter choice: ");
                choice = scanner.nextInt();

                switch (choice) {

                    // ADD
                    case 1:
                        System.out.print("Enter ID: ");
                        int id = scanner.nextInt();
                        scanner.nextLine();

                        System.out.print("Enter Name: ");
                        String name = scanner.nextLine();

                        System.out.print("Enter Marks: ");
                        int marks = scanner.nextInt();

                        String insert = "INSERT INTO Stud VALUES (?, ?, ?)";
                        PreparedStatement ps1 = conn.prepareStatement(insert);
                        ps1.setInt(1, id);
                        ps1.setString(2, name);
                        ps1.setInt(3, marks);
                        ps1.executeUpdate();

                        System.out.println("Inserted!");
                        break;

                    // VIEW
                    case 2:
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM Stud");

                        while (rs.next()) {
                            System.out.println(
                                rs.getInt(1) + " " +
                                rs.getString(2) + " " +
                                rs.getInt(3)
                            );
                        }
                        break;

                    // UPDATE
                    case 3:
                        System.out.print("Enter ID: ");
                        int uid = scanner.nextInt();

                        System.out.print("Enter new marks: ");
                        int newMarks = scanner.nextInt();

                        PreparedStatement ps2 = conn.prepareStatement(
                            "UPDATE Stud SET marks=? WHERE id=?"
                        );
                        ps2.setInt(1, newMarks);
                        ps2.setInt(2, uid);

                        ps2.executeUpdate();
                        System.out.println("Updated!");
                        break;

                    // DELETE
                    case 4:
                        System.out.print("Enter ID: ");
                        int did = scanner.nextInt();

                        PreparedStatement ps3 = conn.prepareStatement(
                            "DELETE FROM Stud WHERE id=?"
                        );
                        ps3.setInt(1, did);

                        ps3.executeUpdate();
                        System.out.println("Deleted!");
                        break;

                }

            } while (choice != 5);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

javac Assignment11.java

java -cp .:/path/mysql-connector-java.jar Assignment11