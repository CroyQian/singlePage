package com.qp.pojo;

public class Agv {
    private String agvid;
    private String agvName;
    private int agvStatus;
    private String isUsed;
    private String location;
    private int batteryCapacity;
    private String agvIP;
    private int agvTask;
    private String area;

    public String getAgvid() {
        return agvid;
    }

    public void setAgvid(String agvid) {
        this.agvid = agvid;
    }

    public String getAgvName() {
        return agvName;
    }

    public void setAgvName(String agvName) {
        this.agvName = agvName;
    }

    public int getAgvStatus() {
        return agvStatus;
    }

    public void setAgvStatus(int agvStatus) {
        this.agvStatus = agvStatus;
    }

    public String getIsUsed() {
        return isUsed;
    }

    public void setIsUsed(String isUsed) {
        this.isUsed = isUsed;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getBatteryCapacity() {
        return batteryCapacity;
    }

    public void setBatteryCapacity(int batteryCapacity) {
        this.batteryCapacity = batteryCapacity;
    }

    public String getAgvIP() {
        return agvIP;
    }

    public void setAgvIP(String agvIP) {
        this.agvIP = agvIP;
    }

    public int getAgvTask() {
        return agvTask;
    }

    public void setAgvTask(int agvTask) {
        this.agvTask = agvTask;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    private int isTest;

    public int getIsTest() {
        return isTest;
    }

    public void setIsTest(int isTest) {
        this.isTest = isTest;
    }
}
