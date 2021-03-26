package ca.ubc.cs304.model;

/**
 * The intent for this class is to update/store information about an Item_Equips_sells tuple
 */
public class SimplifiedItemModel {
	private final String id;
	private final String stats; //TODO: update after Yukie fixes stats
	private final String shopName;
	private final String locationName;

	public SimplifiedItemModel(String id, String stats, String shopName, String locationName) {
		this.id = id;
		this.stats = stats;
		this.shopName = shopName;
		this.locationName = locationName;
	}

	public String getId() {
		return id;
	}

	public String getStats() {
		return stats;
	}

	public String getShopName() {
		return shopName;
	}

	public String getLocationName() {
		return locationName;
	}
}
