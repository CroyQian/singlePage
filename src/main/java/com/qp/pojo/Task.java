package com.qp.pojo;

import java.sql.Timestamp;

public class Task {
    private Integer taskID;
    private Integer taskType;
    private Integer taskStatus;
    private Timestamp taskStartTime;
    private String taskAgvID;
    private Timestamp taskFinishTime;

    public Integer getTaskID() {
        return taskID;
    }

    public void setTaskID(Integer taskID) {
        this.taskID = taskID;
    }

    public Integer getTaskType() {
        return taskType;
    }

    public void setTaskType(Integer taskType) {
        this.taskType = taskType;
    }

    public Integer getTaskStatus() {
        return taskStatus;
    }

    public void setTaskStatus(Integer taskStatus) {
        this.taskStatus = taskStatus;
    }

    public Timestamp getTaskStartTime() {
        return taskStartTime;
    }

    public void setTaskStartTime(Timestamp taskStartTime) {
        this.taskStartTime = taskStartTime;
    }

    public String getTaskAgvID() {
        return taskAgvID;
    }

    public void setTaskAgvID(String taskAgvID) {
        this.taskAgvID = taskAgvID;
    }

    public Timestamp getTaskFinishTime() {
        return taskFinishTime;
    }

    public void setTaskFinishTime(Timestamp taskFinishTime) {
        this.taskFinishTime = taskFinishTime;
    }
}
