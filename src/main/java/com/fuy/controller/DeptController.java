package com.fuy.controller;

import com.fuy.bean.Dept;
import com.fuy.bean.Msg;
import com.fuy.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/*
 *处理与有关部门的请求
 *@return
 */
@Controller
public class DeptController {

    @Autowired
    private DeptService deptService;

    /*
     *返回所有部门的信息
     *@return
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        //查询出的所有部门信息
        List<Dept> depts = deptService.getDepts();
        return Msg.success().add("depts",depts);
    }

}
