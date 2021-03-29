package ca.ubc.cs304.model;

public class LocationShop {
    private final String locationName;
    private final Integer shopCount;

    public LocationShop(String locationName, Integer shopCount) {
        this.locationName = locationName;
        this.shopCount = shopCount;
    }

    @Override
    public String toString() {
        return "LocationShop{" +
                "locationName='" + locationName + '\'' +
                ", shopCount=" + shopCount +
                '}';
    }

    public String getLocationName() {
        return locationName;
    }

    public Integer getShopCount() {
        return shopCount;
    }
}
