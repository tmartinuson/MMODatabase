package ca.ubc.cs304.model;

import java.util.Date;

public class Conversation {
    private final String playerId, NPCName;
    private final Date converseDate;

    public Conversation(String playerId, String NPCName, Date converseDate) {
        this.playerId = playerId;
        this.NPCName = NPCName;
        this.converseDate = converseDate;
    }

    public String getPlayerId() {
        return playerId;
    }

    public String getNPCName() {
        return NPCName;
    }

    public Date getConverseDate() {
        return converseDate;
    }

    @Override
    public String toString() {
        return "playerId='" + playerId + '\'' +
                ", NPCName='" + NPCName + '\'' +
                ", converseDate=" + converseDate +
                '}';
    }
}
