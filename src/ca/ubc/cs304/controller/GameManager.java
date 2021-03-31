package ca.ubc.cs304.controller;

import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.delegates.LoginWindowDelegate;
import ca.ubc.cs304.delegates.TerminalTransactionsDelegate;
import ca.ubc.cs304.model.*;
import ca.ubc.cs304.ui.LoginWindow;
import ca.ubc.cs304.ui.MainMenuWindow;

import java.util.ArrayList;

/**
 * This is the main controller class that will orchestrate everything.
 */
public class GameManager implements LoginWindowDelegate, TerminalTransactionsDelegate {
	private DatabaseConnectionHandler dbHandler = null;
	private LoginWindow loginWindow = null;
	private MainMenuWindow mainMenuWindow = null;

	public GameManager() {
		dbHandler = new DatabaseConnectionHandler();
	}
	
	private void start() {
		loginWindow = new LoginWindow();
		loginWindow.showFrame(this);
	}
	
	/**
	 * LoginWindowDelegate Implementation
	 * 
     * connects to Oracle database with supplied username and password
     */ 
	public void login(String username, String password) {
		boolean didConnect = dbHandler.login(username, password);

		if (didConnect) {
			// Once connected, remove login window and start text transaction flow
			loginWindow.dispose();

			// TODO put GUI menu here
			mainMenuWindow = new MainMenuWindow();
			mainMenuWindow.showFrame(this);

//			UI Menu
//			TerminalTransactions transaction = new TerminalTransactions();
//			transaction.setupDatabase(this);
//			transaction.showMainMenu(this);
		} else {
			loginWindow.handleLoginFailed();

			if (loginWindow.hasReachedMaxLoginAttempts()) {
				loginWindow.dispose();
				System.out.println("You have exceeded your number of allowed attempts");
				System.exit(-1);
			}
		}
	}
	
	/**
	 * TermainalTransactionsDelegate Implementation
	 * 
	 * Insert an assassin player character with given info
	 */
    public void insertAssassinPlayerCharacter(String username, String id, int money,
							 int xp, int attackPower) {
    	dbHandler.insertAssassinPlayerCharacter(username, id, money, xp, attackPower);
    }
    
    /**
	 * TermainalTransactionsDelegate Implementation
	 * 
	 * Update the location's biome
	 */
    public void updateLocationBiome(String locName, String biome) {
    	dbHandler.updateLocationBiome(locName, biome);
    }


    // aggregation with group
	public ArrayList<LocationRace> countRaceByLocation() {
		ArrayList<LocationRace> results = dbHandler.countRaceByLocation();
		return results;
	}

	// nested aggregation
	public ArrayList<LocationAndPrice> nestedPriceQuery() {
    	ArrayList<LocationAndPrice> results = dbHandler.nestedPriceQuery();
		return results;
	}

	// projection
	public ArrayList<SimplifiedItemModel> projectFromItems() {
    	ArrayList<SimplifiedItemModel> results = dbHandler.projectFromItems();
		return results;
	}

	// deletion
	public void deleteGivenWarrior(String playerID) {
        dbHandler.deleteGivenWarrior(playerID);
    }

	// selection
    public ArrayList<Conversation> findPlayersConverses(String date) {
        ArrayList<Conversation> results = dbHandler.findPlayersConverses(date);
        return results;
    }

    // join
    public ArrayList<Player> findAllPlayersWithLevelsUnder(int level) {
        ArrayList<Player> results = dbHandler.findAllPlayersWithLevelsUnder(level);
        return results;
    }

    // aggregation with having
    public ArrayList<LocationShop> countShopsByLocation() {
        ArrayList<LocationShop> results = dbHandler.countShopsByLocation();
        return results;
    }

    // division
    public ArrayList<Player> findPlayersThatBoughtFromAllLocations() {
        ArrayList<Player> results = dbHandler.findPlayersThatBoughtFromAllLocations();
		return results;
	}

	// display all locations
    public ArrayList<Location> displayAllLocations() {
        ArrayList<Location> results = dbHandler.displayAllLocations();
        return results;
    }


	/**
	 * TerminalTransactionsDelegate Implementation
	 * 
     * The TerminalTransaction instance tells us that it is done with what it's 
     * doing so we are cleaning up the connection since it's no longer needed.
     */ 
    public void terminalTransactionsFinished() {
    	dbHandler.close();
    	dbHandler = null;
    	
    	System.exit(0);
    }
    
    /**
	 * TerminalTransactionsDelegate Implementation
	 * 
     * The TerminalTransaction instance tells us that the user is fine with dropping any existing table
     * called branch and creating a new one for this project to use
     */ 
	public void databaseSetup() {
		dbHandler.databaseSetup();
		
	}

	// TODO remove this method
	@Override
	public void deleteBranch(int branchId) {
//		dbHandler.deleteBranch(branchId);
		System.out.println("deleteBranch");
	}

	/**
	 * Main method called at launch time
	 */
	public static void main(String args[]) {
		GameManager gameManager = new GameManager();
		gameManager.start();
	}
}
