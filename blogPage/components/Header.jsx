import React,{useState,useEffect} from 'react';
import Router from 'next/router'
import Link from 'next/link'
import servicePath from "../config/apiUrl";
import axios from "axios";
import {Col, Row,Menu} from "antd";
import * as Icon from '@ant-design/icons'
import style from '../static/style/components/header.module.css'

const Header = (props) => {

    const [navArr,setNavArr] = useState([])
    const HomeIcon = Icon['HomeOutlined']
    useEffect(()=>{
        const fetchData = async ()=>{
            const result= await axios(servicePath.getTypeInfo).then(
                (res)=>{
                    return res.data.data
                }
            )
            setNavArr(result)
        }
        fetchData()
    },[])


//跳转到列表页
    const handleClick = (e)=>{
        e.key==0
            ?Router.push('/')
            :Router.push('/list?id='+e.key)
    }
    return(
            <div className={style.header}>
                <Row type="flex" justify="center">
                    <Col  xs={24} sm={24} md={10} lg={15} xl={12}>
                        <span className={style.header_logo}>ZengXpang</span>
                        <span className={style.header_txt}>前端搞笑师</span>
                    </Col>
                    <Col className="memu-div" xs={0} sm={0} md={14} lg={8} xl={6}>
                        <Menu  mode="horizontal" onClick={handleClick}>
                            <Menu.Item key="0">
                                <HomeIcon/>&nbsp;
                                首页
                            </Menu.Item>

                            {
                                navArr.map((item)=>{
                                    const TagIcon = Icon[item.icon]
                                    return(
                                        <Menu.Item key={item.Id}>
                                            <TagIcon/>
                                            {item.typeName}
                                        </Menu.Item>
                                    )
                                })
                            }
                        </Menu>
                    </Col>
                </Row>
            </div>
    )

}

export default Header;