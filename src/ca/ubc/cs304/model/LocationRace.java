package ca.ubc.cs304.model;

public class LocationRace {

    private final String location;
    private final int raceCount;

    public LocationRace(String location, int raceCount) {
        this.location = location;
        this.raceCount = raceCount;
    }

    public String getLocation() {
        return location;
    }

    public int getRaceCount() {
        return raceCount;
    }
}
