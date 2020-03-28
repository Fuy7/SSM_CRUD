package com.fuy.controller;

import com.fuy.bean.Msg;
import com.fuy.bean.User;
import com.fuy.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
 *处理员工的CRUD请求
 *@return
 */
@Controller
public class UserController {

    @Autowired
    UserService userService;

    /*
     *根据ID删除员工信息
     * 单个删除：1
     * 批量删除：1-2-3 。。。
     *@return
     */
    @RequestMapping(value = "users/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteUserById(@PathVariable("ids")String ids){

        if(ids.contains("-")){  //为批量删除
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            //组装集合
            for (String str_id : str_ids) {
                del_ids.add(Integer.parseInt(str_id));
            }
            userService.deleteUsers(del_ids);

        }else {     //单个删除
            Integer id = Integer.parseInt(ids);
            userService.deleteUserById(id);
        }
        return Msg.success();
    }


    /*
     *根据id修改员工信息
     *@return
     */
    @RequestMapping(value = "/users/{id}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateUser(User user){
        System.out.println(user.toString());
        userService.updateUser(user);
        return Msg.success();
    }
    
    /*
     *根据id查询员工处理
     * /emp/{id}
     *@return
     */
    @RequestMapping(value="/users/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getOneUser(@PathVariable("id") Integer id){
        User user = userService.getOneUser(id);
        return Msg.success().add("user",user);
    }
    

    /*
     *返回响应的json字符数
     * 需要导入jackson包(返回json字符串支持)
     *@return
     */
    @RequestMapping("/users")
    @ResponseBody       //作用：可以返回json字符串
    public Msg getUserJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        //引入PageHelper分页插件
        //查询之前需要调用方法 startPage(第几页开始,每页几条)
        PageHelper.startPage(pn,5);
        //接跟着startPage后的方法就是一个分页查询
        List<User> list = userService.getAll();
        //用PageInfo对结果进行包装后,只需要将PageInfo交给页面
        //封装了详细的分页信息,包括查询出来的数据,传入连续显示的页数
        PageInfo<User> page = new PageInfo(list,5);
        //载入封装的数据到request域键值对
        return Msg.success().add("pageInfo",page);
    }

    /*
     *查询员工数据(分页查询)
     *@return
     */
    //@RequestMapping("/users")
    @ResponseBody
    public String getUser(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        //引入PageHelper分页插件
        //查询之前需要调用方法 startPage(第几页开始,每页几条)
        PageHelper.startPage(pn,5);
        //接跟着startPage后的方法就是一个分页查询
        List<User> list = userService.getAll();
        //用PageInfo对结果进行包装后,只需要将PageInfo交给页面
        //封装了详细的分页信息,包括查询出来的数据,传入连续显示的页数
        PageInfo<User> page = new PageInfo(list,5);
        //载入封装的数据到request域键值对
        model.addAttribute("pageInfo",page);
        return "list";
    }

    /*
     *保存用户
     * 并且使用Rest风格的URI,规定POST方式的为保存请求
     * 自动封装成user对象
     *@return
     */
    @RequestMapping(value = "/users",method = RequestMethod.POST)
    @ResponseBody
    public Msg userSave(User user){
/*        if(result.hasErrors()){
            Map<String,Object> map = new HashMap<>();
            List<FieldError> list = result.getFieldErrors();
            for (FieldError fieldError : list) {
                System.out.println("错误字段名"+ fieldError.getField());
                System.out.println("操作信息"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {*/
            userService.userSave(user);
            return Msg.success();
        //}
    }

    /*
     *校验用户名
     *@return
     */
    @ResponseBody
    @RequestMapping("/checkname")
    public Msg checkUserName(@RequestParam("name")String name){
        //1.判断是否合法
        String regx = "(^[a-z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!name.matches(regx)){   //如果不满足返回false
            return Msg.fail().add("regx_msg","用户名不符合规则(2-5位中文或者6-16位英文和下划线组合)");
        }
        //2.判断是否重复
        Boolean b = userService.checkUserName(name);
        System.out.println(name);
        if(b){
            return Msg.success();
        }else {
            return Msg.fail().add("regx_msg","用户名不可用");
        }
    }
}
