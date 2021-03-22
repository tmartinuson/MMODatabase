package ca.ubc.cs304.model;

public class LocationAndPrice {
    private final String location;
    private final double maxPrice;

    public LocationAndPrice(String location, double maxPrice) {
        this.location = location;
        this.maxPrice = maxPrice;
    }

    public String getLocation() {
        return location;
    }

    public double getMaxPrice() {
        return maxPrice;
    }
}
