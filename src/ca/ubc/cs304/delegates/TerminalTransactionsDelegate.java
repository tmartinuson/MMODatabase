package ca.ubc.cs304.delegates;

/**
 * This interface uses the delegation design pattern where instead of having
 * the TerminalTransactions class try to do everything, it will only
 * focus on handling the UI. The actual logic/operation will be delegated to the 
 * controller class (in this case Bank).
 * 
 * TerminalTransactions calls the methods that we have listed below but 
 * Bank is the actual class that will implement the methods.
 */
public interface TerminalTransactionsDelegate {
	void databaseSetup();
	void deleteBranch(int branchId);
	void insertAssassinPlayerCharacter(String username, String id, int money,
									   int xp, int attackPower);
	void projectFromItems();
	void updateLocationBiome(String name, String biome);
	void countRaceByLocation();
	void nestedPriceQuery();
	
	void terminalTransactionsFinished();
}
