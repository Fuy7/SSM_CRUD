package com.fuy.test;

import com.fuy.bean.Dept;
import com.fuy.bean.User;
import com.fuy.bean.UserExample;
import com.fuy.dao.DeptMapper;
import com.fuy.dao.UserMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

/*
 *测试Dao层工作
 * 使用Spring自带的测试,可以自动注入需要的组件
 *  1.导入SpringTest依赖坐标
 *  2.@ContextConfiguration注解指定Spring配置文件的位置
 *  3.@RunWith注解指定使用哪个单元测试(指定为Spring的)
 *  4.直接@Autowired直接注入使用组件即可
 *@return
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DeptMapper deptMapper;

    @Autowired
    UserMapper userMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD(){
        System.out.println(deptMapper);

        //1.插入部门
        //deptMapper.insertSelective(new Dept(2,"测试"));
        //deptMapper.insertSelective(new Dept(3,"营销"));
        //2.插入员工
  //      userMapper.insertSelective(new User(null,"jack",1000.0,2));
        //3.批量插入员工,可以使用执行批量操作的SQLSession
        /*for(){
            userMapper.insertSelective(new User(null,"Tom",1000.0,2));
        }*/
//        UserMapper mapper = sqlSession.getMapper(UserMapper.class);//传入配置 让他能够批量生产
//        for (int i = 0; i < 1000; i++) {
//            String uuid = UUID.randomUUID().toString().substring(0,5)+i;//随机生成uname
//            mapper.insertSelective(new User(null,uuid,2000.0,3));
//        }
//        System.out.println("批量完成");
        //4.测试删除
//        userMapper.deleteByPrimaryKey(12);
        //5.测试修改
//        List<User> users = userMapper.selectByExampleByDept(null);
//        for (User user : users) {
//            System.out.println(user.getId());
//        }
        /*UserExample userExample = new UserExample();
        UserExample.Criteria criteria = userExample.createCriteria();
        criteria.andNameEqualTo("付煜");
        long count = userMapper.countByExample(userExample);
        System.out.println(count);*/
/*        List<Dept> list = deptMapper.selectByExample(null);
        for (Dept dept : list) {
            System.out.println(dept.getdName() + " ");
        }*/

        userMapper.deleteByPrimaryKey(6);
    }
}
