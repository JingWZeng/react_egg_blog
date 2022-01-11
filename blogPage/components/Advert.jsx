import React from 'react';
import style from '../static/style/components/advert.module.css'

const Advert = props => {
    return (
        <div className={style.ad_div}>
            <div className={style.item}><img src="1.png"  alt="广告" width="100%"/></div>
            <div className={style.item}><img src="2.png"  alt="广告" width="100%"/></div>
        </div>
    )
}

export default Advert;