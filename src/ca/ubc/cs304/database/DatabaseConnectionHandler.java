package ca.ubc.cs304.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import ca.ubc.cs304.model.*;

/**
 * This class handles all database related transactions
 */
public class DatabaseConnectionHandler {
	// Use this version of the ORACLE_URL if you are running the code off of the server
//	private static final String ORACLE_URL = "jdbc:oracle:thin:@dbhost.students.cs.ubc.ca:1522:stu";
	// Use this version of the ORACLE_URL if you are tunneling into the undergrad servers
	private static final String ORACLE_URL = "jdbc:oracle:thin:@localhost:1522:stu";
	private static final String EXCEPTION_TAG = "[EXCEPTION]";
	private static final String WARNING_TAG = "[WARNING]";
	
	private Connection connection = null;
	
	public DatabaseConnectionHandler() {
		try {
			// Load the Oracle JDBC driver
			// Note that the path could change for new drivers
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		} catch (SQLException e) {
			System.out.println(EXCEPTION_TAG + " " + e.getMessage());
		}
	}
	
	public void close() {
		try {
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException e) {
			System.out.println(EXCEPTION_TAG + " " + e.getMessage());
		}
	}

	public ArrayList<SimplifiedItemModel> projectFromItems() {
		// return attributes in a simplified item object
		ArrayList<SimplifiedItemModel> result = new ArrayList<SimplifiedItemModel>();

		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT ItemID, Stats, ShopName, LocationName, PlayerUsername " +
												"FROM Item_Equip_Sells");

			while(rs.next()) {
				SimplifiedItemModel model = new SimplifiedItemModel(rs.getString("ItemID"),
						rs.getString("Stats"),
						rs.getString("ShopName"),
						rs.getString("LocationName"),
						rs.getString("PlayerUsername"));
				result.add(model);
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			System.out.println(EXCEPTION_TAG + " " + e.getMessage());
			rollbackConnection();
		}

		return result;
	}

    public void deleteGivenWarrior(String playerID) {
        try {
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("DELETE FROM Warrior WHERE ID = " + playerID);

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            System.out.println(EXCEPTION_TAG + " " + e.getMessage());
            rollbackConnection();
        }
    }

    public ArrayList<Items> viewItemsInStockAtStore(String shopName, String location) {
        ArrayList<Items> result = new ArrayList<Items>();

        try {
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT ItemID, Price, Stats FROM Item_Equips_Sells as i " +
                    "WHERE i.ShopName = " + shopName + " AND i.LocationName = " + location);

            while(rs.next()) {
                Items model = new Items(
                        rs.getString("ItemID"),
                        rs.getInt("Price"),
                        rs.getString("Stats"));
                result.add(model);
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            System.out.println(EXCEPTION_TAG + " " + e.getMessage());
            rollbackConnection();
        }

        return result;
    }

    public ArrayList<Store> storesInLocation(String location) {
        ArrayList<Store> result = new ArrayList<Store>();

        try {
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT ShopName, Type FROM Shop_IsIn as s, Location as l " +
                    "WHERE s.LocationName = l.Name AND s.LocationName = " + location + " AND l.Name = " + location);

            while(rs.next()) {
                Store model = new Store(
                        rs.getString("ShopName"),
                        rs.getString("Type"));
                result.add(model);
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            System.out.println(EXCEPTION_TAG + " " + e.getMessage());
            rollbackConnection();
        }

        return result;
    }


    public ArrayList<Monster> strongMonstersByLocation() {
        ArrayList<Monster> result = new ArrayList<Monster>();

        try {
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT Race, Type, MonsterLevel, LocationName" +
                                                " FROM Monster_isAt" +
                                                " GROUP BY LocationName" +
                                                " HAVING MonsterLevel > 60");

            while(rs.next()) {
                Monster model = new Monster(
                        rs.getString("Race"),
                        rs.getString("Type"),
                        rs.getInt("MonsterLevel"),
                        rs.getString("LocationName"));
                result.add(model);
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            System.out.println(EXCEPTION_TAG + " " + e.getMessage());
            rollbackConnection();
        }

        return result;
    }

    public ArrayList<Player> completedAllLocations() {
	    //This one needs to be fixed for division
        //Scope is to find all players that have completed all locations
        //May need to join for username
        ArrayList<Player> result = new ArrayList<Player>();

        try {
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT c.PlayerID, c.PlayerUsername" +
                                                " FROM Completes as c" +
                                                " WHERE NOT EXISTS (" +
                                                " SELECT *" +
                                                " FROM Completes as c1" +
                                                " WHERE NOT EXISTS (" +
                                                " SELECT *" +
                                                " FROM Completes as c2" +
                                                " WHERE (c1.LocationName = c2.LocationName) AND (c1.PlayerID = c2.PlayerID)))");

            while(rs.next()) {
                Player model = new Player(
                        rs.getString("PlayerID"),
                        rs.getString("PlayerUsername"));
                result.add(model);
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            System.out.println(EXCEPTION_TAG + " " + e.getMessage());
            rollbackConnection();
        }

        return result;
    }


	public ArrayList<LocationRace> countRaceByLocation() {
		ArrayList<LocationRace> result = new ArrayList<LocationRace>();

		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT LocationName, Count(Race) FROM Monster_isAt GROUP BY LocationName");

			while(rs.next()) {
				LocationRace model = new LocationRace(
						rs.getString("LocationName"),
						rs.getInt("Count(Race)"));
				result.add(model);
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			System.out.println(EXCEPTION_TAG + " " + e.getMessage());
			rollbackConnection();
		}

		return result;
	}

	public ArrayList<LocationAndPrice> nestedPriceQuery() {
		ArrayList<LocationAndPrice> result = new ArrayList<LocationAndPrice>();

		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT locationName, MAX(avgPrice) " +
												"FROM Item_Equips_Sells I " +
												"WHERE (SELECT locationName, shopType, AVG(price) AS avgPrice " +
														"FROM Item_Equips_Sells " +
														"WHERE itemID > 10000 " +
														"GROUP BY shopType, locationName)" +
												"GROUP BY locationName");

			while(rs.next()) {
				LocationAndPrice model = new LocationAndPrice(
						rs.getString("LocationName"),
						rs.getDouble("MAX(avgPrice)"));
				result.add(model);
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			System.out.println(EXCEPTION_TAG + " " + e.getMessage());
			rollbackConnection();
		}

		return result;
	}
	
	public void insertAssassinPlayerCharacter(String username, String id, int money,
											  int xp, int attackPower) {
		try {
			PreparedStatement ps = connection.prepareStatement("INSERT INTO PlayerCharacter VALUES (?,?,?,?)");
			ps.setString(1, username);
			ps.setString(2, id);
			ps.setInt(3, money);
			ps.setInt(4, xp);
			/*if (xp == 0) {
				ps.setNull(5, java.sql.Types.INTEGER);
			} else {
				ps.setInt(5, model.getPhoneNumber());
			}*/
			ps.executeUpdate();
			connection.commit();
			ps.close();

			PreparedStatement ps2 = connection.prepareStatement("INSERT INTO Assassin VALUES (?,?,?)");
			ps2.setString(1, username);
			ps2.setString(2, id);
			ps2.setInt(3, attackPower);
			ps2.executeUpdate();
			connection.commit();
			ps2.close();
		} catch (SQLException e) {
			System.out.println(EXCEPTION_TAG + " " + e.getMessage());
			rollbackConnection();
		}
	}
	
	public void updateLocationBiome(String locName, String biome) {
		try {
		  PreparedStatement ps = connection.prepareStatement("UPDATE Location SET Biome = ? WHERE Name = ?");
		  ps.setString(1, locName);
		  ps.setString(2, biome);
		
		  int rowCount = ps.executeUpdate();
		  if (rowCount == 0) {
		      System.out.println(WARNING_TAG + " Location " + locName + " does not exist!");
		  }
	
		  connection.commit();
		  
		  ps.close();
		} catch (SQLException e) {
			System.out.println(EXCEPTION_TAG + " " + e.getMessage());
			rollbackConnection();
		}	
	}
	
	public boolean login(String username, String password) {
		try {
			if (connection != null) {
				connection.close();
			}
	
			connection = DriverManager.getConnection(ORACLE_URL, username, password);
			connection.setAutoCommit(false);
	
			System.out.println("\nConnected to Oracle!");
			return true;
		} catch (SQLException e) {
			System.out.println(EXCEPTION_TAG + " " + e.getMessage());
			return false;
		}
	}

	private void rollbackConnection() {
		try  {
			connection.rollback();	
		} catch (SQLException e) {
			System.out.println(EXCEPTION_TAG + " " + e.getMessage());
		}
	}
	
	public void databaseSetup() {
		//TODO: remove this method, I believe it is not necessary
		dropBranchTableIfExists();
		
		try {
			Statement stmt = connection.createStatement();
			stmt.executeUpdate("CREATE TABLE branch (branch_id integer PRIMARY KEY, branch_name varchar2(20) not null, branch_addr varchar2(50), branch_city varchar2(20) not null, branch_phone integer)");
			stmt.close();
		} catch (SQLException e) {
			System.out.println(EXCEPTION_TAG + " " + e.getMessage());
		}
	}
	
	private void dropBranchTableIfExists() {
		//TODO: remove this method, I believe it is not necessary
		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("select table_name from user_tables");
			
			while(rs.next()) {
				if(rs.getString(1).toLowerCase().equals("branch")) {
					stmt.execute("DROP TABLE branch");
					break;
				}
			}
			
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			System.out.println(EXCEPTION_TAG + " " + e.getMessage());
		}
	}

	public void deleteBranch(int branchId) {
		System.out.println("deleteBranch");
	}
}
