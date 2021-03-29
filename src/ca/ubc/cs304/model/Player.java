package ca.ubc.cs304.model;

public class Player {
    private final String playerID, playerUsername;
    private final Integer playerLevel;

    public Player(String playerID, String playerUsername, Integer playerLevel) {
        this.playerID = playerID;
        this.playerUsername = playerUsername;
        this.playerLevel = playerLevel;
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

    @Override
    public String toString() {
        return "Player{" +
                "playerID='" + playerID + '\'' +
                ", playerUsername='" + playerUsername + '\'' +
                ", playerLevel=" + playerLevel +
                '}';
    }
}
