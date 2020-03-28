package com.fuy.service;

import com.fuy.bean.User;
import com.fuy.bean.UserExample;
import com.fuy.dao.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service        //业务逻辑组件
public class UserService {

    @Autowired
    UserMapper userMapper;  //mapper是dao实现类

    /*
     *批量删除
     *@return
     */
    public void deleteUsers(List<Integer> ids){
        UserExample example = new UserExample();
        UserExample.Criteria criteria = example.createCriteria();
        //delete from user where id = in (1,2,3...)
        criteria.andIdIn(ids);
        userMapper.deleteByExample(example);
    }
    /*
     *根据id删除员工
     *@return
     */
    public void deleteUserById(Integer id){
        userMapper.deleteByPrimaryKey(id);
    }

    /*
     *根据ID更新用户
     *@return
     */
    public void updateUser(User user){
        //按照主键有选择的更新
        userMapper.updateByPrimaryKeySelective(user);
    }

    /*
     *查询所有员工
     *@return
     */
    public List<User> getAll(){
        return  userMapper.selectByExampleByDept(null);
    }

    /*
     *员工保存
     *@return
     */
    public void userSave(User user){
        userMapper.insertSelective(user);
    }
    /*
     *校验用户名
     * count == 0 代表没有记录 用户名可用
     *@return
     */
    public Boolean checkUserName(String name){
        UserExample userExample = new UserExample();
        UserExample.Criteria criteria = userExample.createCriteria();
        criteria.andNameEqualTo(name);
        long count = userMapper.countByExample(userExample);
        return count == 0;
    }

    /*
     *根据id查询一个用户
     *@return
     */
    public User getOneUser(Integer id){
        User user = userMapper.selectByPrimaryKey(id);
        return user;
    }
}
