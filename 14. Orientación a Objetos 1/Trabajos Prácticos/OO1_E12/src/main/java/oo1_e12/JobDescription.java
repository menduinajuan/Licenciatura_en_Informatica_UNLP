package oo1_e12;

public class JobDescription {

    private double effort;
    private int priority;
    private String description;

    public JobDescription (double anEffort, int aPriority, String aDescription) {
        this.effort=anEffort;
        this.priority=aPriority;
        this.description=aDescription;
    }

    public double getEffort() {
        return this.effort;
    }

    public int getPriority() {
        return this.priority;
    }

    public String getDescription() {
        return this.description;
    }

}