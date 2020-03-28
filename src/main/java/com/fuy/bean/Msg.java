package com.fuy.bean;

import java.util.HashMap;
import java.util.Map;

/*
 *浏览器返回类
 *@return
 */
public class Msg  {

    //状态码
    private int code;
    //提示信息
    private String msg;
    //用户要返回给浏览器的
    private Map<String,Object> extend = new HashMap<String, Object>();

    /*
     *成功信息
     *@return
     */
    public static Msg success(){
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("操作成功");
        return result;
    }
    /*
     *失败信息
     *@return
     */
    public static Msg fail(){
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("操作失败");
        return result;
    }

    /*
     *添加json字符串数据
     *@return
     */
    public Msg add(String key,Object value){
        this.getExtend().put(key, value);
        return this;    //返回本体
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
