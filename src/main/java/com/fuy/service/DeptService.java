package com.fuy.service;

import com.fuy.bean.Dept;
import com.fuy.bean.User;
import com.fuy.dao.DeptMapper;
import com.fuy.dao.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptService {

    @Autowired
    private DeptMapper deptMapper;
    /*
     *获取所有部门信息
     *@return
     */
    public List<Dept> getDepts(){
        List<Dept> list = deptMapper.selectByExample(null);
        return list;
    }

}
