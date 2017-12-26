package com.qp.service;

import com.qp.dao.TaskManageMapper;
import com.qp.pojo.Task;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;

@Named
@Transactional
public class TaskService {

    @Inject
    private TaskManageMapper taskManageMapper;

    public List<Task> findAll(){
        return taskManageMapper.findAllTask();
    }
}
