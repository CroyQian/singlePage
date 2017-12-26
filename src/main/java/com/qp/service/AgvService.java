package com.qp.service;

import com.qp.dao.AgvManageMapper;
import com.qp.pojo.Agv;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;

@Named
@Transactional
public class AgvService {

    @Inject
    private AgvManageMapper agvManageMapper;

    public List<Agv> findAll() {
        return agvManageMapper.findAllAgv();
    }

//    public void save(Movie movie) {
//        agvManageMapper.save(movie);
//    }
//
//    public Movie findMovieById(Integer id) {
//        return agvManageMapper.findById(id);
//    }
//
//    public void delMovie(Integer id) {
//        agvManageMapper.remove(id);
//    }
//
//    public void editMovie(Movie movie) {
//        agvManageMapper.update(movie);
//    }
}
