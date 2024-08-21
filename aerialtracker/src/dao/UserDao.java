package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bean.User;
import dbconnection.DBconnection;
import org.mindrot.jbcrypt.BCrypt;

public class UserDao {

	// Method to validate user credentials
	public boolean checkLogin(User user) {
		boolean isValidUser = false;
		String sql = "SELECT password FROM userregistration WHERE email = ?";

		try (Connection connection = DBconnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, user.getEmail());

			try (ResultSet resultSet = statement.executeQuery()) {
				if (resultSet.next()) {
					String storedPasswordHash = resultSet.getString("password");
					isValidUser = BCrypt.checkpw(user.getPassword(), storedPasswordHash);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return isValidUser;
	}

	// Method to register a new user
	public boolean registerUser(User user) {
		boolean isRegistered = false;
		String sql = "INSERT INTO userregistration (email, password) VALUES (?, ?)";

		try (Connection connection = DBconnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, user.getEmail());
			statement.setString(2, user.getPassword()); // Ensure this is hashed password

			int rowsInserted = statement.executeUpdate();
			if (rowsInserted > 0) {
				isRegistered = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return isRegistered;
	}

	// Method to check if an email already exists
	public boolean emailExists(String email) {
		boolean exists = false;
		String sql = "SELECT COUNT(*) FROM userregistration WHERE email = ?";

		try (Connection connection = DBconnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, email);

			try (ResultSet resultSet = statement.executeQuery()) {
				if (resultSet.next() && resultSet.getInt(1) > 0) {
					exists = true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return exists;
	}

	// Method to get user details by email
	public User getUserByEmail(String email) {
		User user = null;
		String sql = "SELECT * FROM userregistration WHERE email = ?";

		try (Connection connection = DBconnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, email);

			try (ResultSet resultSet = statement.executeQuery()) {
				if (resultSet.next()) {
					user = new User();
					user.setEmail(resultSet.getString("email"));
					user.setPassword(resultSet.getString("password"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return user;
	}

	// Method to update user password
	public boolean updateUserPassword(String email, String newPassword) {
		boolean isUpdated = false;
		String sql = "UPDATE userregistration SET password = ? WHERE email = ?";

		try (Connection connection = DBconnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, newPassword);
			statement.setString(2, email);

			int rowsUpdated = statement.executeUpdate();
			if (rowsUpdated > 0) {
				isUpdated = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return isUpdated;
	}

	// Method to delete a user
	public boolean deleteUser(String email) {
		boolean isDeleted = false;
		String sql = "DELETE FROM userregistration WHERE email = ?";

		try (Connection connection = DBconnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, email);

			int rowsDeleted = statement.executeUpdate();
			if (rowsDeleted > 0) {
				isDeleted = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return isDeleted;
	}

	public Integer getUserIdByEmail(String email) {
		Integer userId = null;
		String sql = "SELECT user_id FROM userregistration WHERE email = ?";

		try (Connection connection = DBconnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, email);

			try (ResultSet resultSet = statement.executeQuery()) {
				if (resultSet.next()) {
					userId = resultSet.getInt("user_id");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return userId;
	}
}