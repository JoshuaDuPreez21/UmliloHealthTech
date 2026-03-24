package Utils;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBUtil {
	public static Connection getConnection() throws SQLException {
		try {
			InitialContext ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/MySQLDataSource");
			return ds.getConnection();
		} catch (NamingException e) {
			throw new SQLException("DataSource lookup failed", e);
		}
	}
}
