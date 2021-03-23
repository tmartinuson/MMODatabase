package ca.ubc.cs304.model;

public class Player {
    private final String playerID, playerUsername;

    public Player(String playerID, String playerUsername) {
        this.playerID = playerID;
        this.playerUsername = playerUsername;
    }

    public String getPlayerID() {
        return playerID;
    }

    public String getPlayerUsername() {
        return playerUsername;
    }
}
