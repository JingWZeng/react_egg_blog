import React from 'react';
import {Avatar,Divider} from 'antd'
import {
    GithubFilled ,
    WechatFilled,
    QqCircleFilled
} from '@ant-design/icons'
import {author_div,author_introduction,account} from '../static/style/components/author.module.css'

const Author = props => {
    return (
        <div className="comm_box">
        <div className={author_div}>
            <div><Avatar size={100} src="https://cdn.jsdelivr.net/gh/JingWZeng/markdownImg/img/202108231635263.jpeg"/></div>
            <div className={author_introduction} style={{ marginBottom: '1rem'}}>
                程序员嘻嘻嘻嘻嘻嘻
                <Divider>社交账号</Divider>
                <Avatar size={28} icon={<GithubFilled />} className={account}/>
                <Avatar size={28} icon={<WechatFilled />} className={account} />
                <Avatar size={28} icon={<QqCircleFilled />} className={account} />
            </div>
        </div>
        </div>
    );
};


export default Author;