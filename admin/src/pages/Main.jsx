import React,{Fragment} from 'react';
import {Route} from 'react-router-dom'
import Login from './Login'
import AdminIndex from "./AdminIndex";
import '../static/css/Main.less'
function Main(props) {
    return (
        <Fragment>
            <Route path="/" exact component={Login}></Route>
            <Route path="/index"  component={AdminIndex}></Route>
        </Fragment>
    );
}

export default Main;