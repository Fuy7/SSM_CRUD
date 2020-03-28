package com.fuy.test;

import com.fuy.bean.User;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/*
 *使用Spring测试模块提供的测试请求功能,测试CRUD
 * java.lang.NoClassDefFoundError: javax/servlet/SessionCookieConfig：
 *      Spring4测试的时候需要Servlet3.0的支持
 *@return
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration        //加了这个annotation就能将ioc容器自动装配
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springmvc.xml"})
public class MvcTest {
    //传入SpringMVC的IOC容器
    @Autowired
    WebApplicationContext context;
    //虚拟mvc请求，获得处理结果
    MockMvc mockMvc;
    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }
    @Test
    public void testPage() throws Exception {
        //模拟发送请求并取得返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/users").param("pn", "5"))
                .andReturn(); //现实的当前页码
        //发送请求后,请求域中会有PageInfo,我们可以取出PageInfo进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
        System.out.println("当前页码："+pageInfo.getPageNum());
        System.out.println("总页码："+pageInfo.getPages());
        System.out.println("总记录数："+pageInfo.getTotal());
        System.out.println("连续显示的页码数：");
        int[] nums = pageInfo.getNavigatepageNums();
        for (int num : nums) {
            System.out.println(""+num);
        }
        //获取员工数据
        List<User> list = pageInfo.getList();
        for (User user : list) {
            System.out.println("ID: "+user.getId()+"| name: "+user.getName());
        }
    }
}
