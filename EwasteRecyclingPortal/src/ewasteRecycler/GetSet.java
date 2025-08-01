package ewasteRecycler;

/**
 * A simple utility class to store and retrieve a static user ID.
 */
public class GetSet {

    // Static variable to hold user ID
    public static int rid;

    // Getter for user ID
    public static int getId() {
        return rid;
    }

    // Setter for user ID
    public static void setId(int id) {
        GetSet.rid = rid;
    }
}
