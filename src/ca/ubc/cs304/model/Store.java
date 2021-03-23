package ca.ubc.cs304.model;

public class Store {
    private final String name, type;

    public Store(String name, String type) {
        this.name = name;
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public String getType() {
        return type;
    }
}
