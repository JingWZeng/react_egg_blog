import React,{useState} from 'react';
import {Card ,Input,Button,Spin,message} from "antd";
import {
MehTwoTone,
SmileTwoTone
} from '@ant-design/icons'
import '../static/css/Login.css'
import servicePath from "../config/apiUrl";
import axios from "axios";

const Login = (props)=> {

    const [userName,setUserName] = useState('')
    const [password,setPassword] = useState('')
    const [isLoading,setIsLoading]  = useState(false)

    const checkLogin = ()=>{
        setIsLoading(true)

        if(!userName){
            message.error('用户名不能为空')
            return false
        }else if(!password){
            message.error('密码不能为空')
            return false
        }
        axios({
            method:'post',
            url:servicePath.checkLogin,
            data:{
            'userName':userName,
            'password':password
            },
            withCredentials: true
        }).then(
            res=>{
                setIsLoading(false)
                if(res.data.data==='登录成功'){
                    localStorage.setItem('token',res.data.token)
                    props.history.push('/index')
                }else{
                    message.error('用户名密码错误')
                }
            }
        )

        setTimeout(()=>{
            setIsLoading(false)
        },1000)
    }
    return (
        <div className="login-div">
            <Spin tip="Loading..." spinning={isLoading}>
                <Card title="My Blog System" bordered={true} style={{width:400}}>
                    <Input
                        id="username"
                        placeholder="Enter your userName"
                        size="large"
                        prefix={<MehTwoTone />}
                        onChange={(e)=>{setUserName(e.target.value)}}
                    />
                    <br/>
                    <Input.Password
                        id="password"
                        placeholder="Enter your password"
                        size="large"
                        prefix={<SmileTwoTone />}
                        onChange={(e)=>{setPassword(e.target.value)}}
                    />
                    <br/>
                    <Button type="primary" size="large" block onClick={checkLogin} className="login-btn"> Login in </Button>
                </Card>
            </Spin>

        </div>
    );
}

export default Login;