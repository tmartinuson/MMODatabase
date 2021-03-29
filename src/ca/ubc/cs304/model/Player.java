package ca.ubc.cs304.model;

public class Player {
    private final String playerID, playerUsername;
    private final Integer playerLevel, playerXP;

    public Player(String playerID, String playerUsername, Integer playerLevel, Integer playerXP) {
        this.playerID = playerID;
        this.playerUsername = playerUsername;
        this.playerLevel = playerLevel;
        this.playerXP = playerXP;
    }

    public String getPlayerID() {
        return playerID;
    }

    public String getPlayerUsername() {
        return playerUsername;
    }

    public Integer getPlayerLevel() {
        return playerLevel;
    }

    public Integer getPlayerXP() {
        return playerXP;
    }

    @Override
    public String toString() {
        return "Player{" +
                "playerID='" + playerID + '\'' +
                ", playerUsername='" + playerUsername + '\'' +
                ", playerLevel=" + playerLevel +
                ", playerXP=" + playerXP +
                '}';
    }
}
