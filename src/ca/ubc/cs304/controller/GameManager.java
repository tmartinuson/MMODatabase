package ca.ubc.cs304.controller;

import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.delegates.LoginWindowDelegate;
import ca.ubc.cs304.delegates.TerminalTransactionsDelegate;
import ca.ubc.cs304.model.*;
import ca.ubc.cs304.ui.LoginWindow;
import ca.ubc.cs304.ui.TerminalTransactions;

import java.util.ArrayList;

/**
 * This is the main controller class that will orchestrate everything.
 */
public class GameManager implements LoginWindowDelegate, TerminalTransactionsDelegate {
	private DatabaseConnectionHandler dbHandler = null;
	private LoginWindow loginWindow = null;

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

			TerminalTransactions transaction = new TerminalTransactions();
			transaction.setupDatabase(this);
			transaction.showMainMenu(this);
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
	 * Delete branch with given branch ID.
	 */ 
    public void deleteBranch(int branchId) {
    	//dbHandler.deleteBranch(branchId);
    }
    
    /**
	 * TermainalTransactionsDelegate Implementation
	 * 
	 * Update the branch name for a specific ID
	 */

    public void updateLocationBiome(String locName, String biome) {
    	dbHandler.updateLocationBiome(locName, biome);
    }


	public void countRaceByLocation() {
    	//TODO: This is where you can print the results to the gui
		ArrayList<LocationRace> results = dbHandler.countRaceByLocation();
	}


	public void nestedPriceQuery() {
		//TODO: This is where you can print the results to the gui
		ArrayList<LocationAndPrice> results = dbHandler.nestedPriceQuery();
	}

	public void projectFromItems() {
		//TODO: This is where you can print the results to the gui
		ArrayList<SimplifiedItemModel> results = dbHandler.projectFromItems();
	}

	public void deleteGivenWarrior(String playerID) {
        dbHandler.deleteGivenWarrior(playerID);
    }

    public void viewItemsInStockAtStore(String shopName, String location) {
        ArrayList<Items> results = dbHandler.viewItemsInStockAtStore(shopName,location);
    }

    public void storesInLocation(String location) {
        ArrayList<Store> results = dbHandler.storesInLocation(location);
    }

    public void strongMonstersByLocation() {
        ArrayList<Monster> results = dbHandler.strongMonstersByLocation();
    }

    public void completedAllLocations() {
        ArrayList<Player> results = dbHandler.completedAllLocations();
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
    
	/**
	 * Main method called at launch time
	 */
	public static void main(String args[]) {
		GameManager gameManager = new GameManager();
		gameManager.start();
	}
}
