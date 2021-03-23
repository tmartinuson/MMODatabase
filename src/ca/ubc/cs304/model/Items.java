package ca.ubc.cs304.model;

public class Items {
    private final String itemID, stats;
    private final Integer price;

    public Items(String itemID, Integer price, String stats) {
        this.itemID = itemID;
        this.price = price;
        this.stats = stats;
    }

    public String getItemID() {
        return itemID;
    }

    public Integer getPrice() {
        return price;
    }

    public String getStats() {
        return stats;
    }
}
