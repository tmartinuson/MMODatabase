package ca.ubc.cs304.model;

public class Location {
    private final String locationName, biome;

    public Location(String locationName, String biome) {
        this.locationName = locationName;
        this.biome = biome;
    }

    public String getLocationName() {
        return locationName;
    }

    public String getBiome() {
        return biome;
    }
}
