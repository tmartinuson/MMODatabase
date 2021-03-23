package ca.ubc.cs304.model;

public class Monster {
    private final String race, type, locationName;
    private final Integer monsterLevel;

    public Monster(String race, String type, Integer monsterLevel, String locationName) {
        this.race = race;
        this.type = type;
        this.monsterLevel = monsterLevel;
        this.locationName = locationName;
    }

    public Integer getMonsterLevel() {
        return monsterLevel;
    }

    public String getRace() {
        return race;
    }

    public String getType() {
        return type;
    }

    public String getLocationName() {
        return locationName;
    }
}
