import Vue from 'vue'
import Router from 'vue-router'
import User from '@/components/User'
import Users from '@/components/ListUsers'
import Login from '@/components/Login'
import NewUser from '@/components/NewUser'
import HelloWorld from '@/components/HelloWorld'

Vue.use(Router)

export default new Router({
  mode: "history",
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld
    },
    {
      path: '/users',
      name: "users",
      component: Users
    },
    {
      path: '/NewUser',
      name: "newUser",
      component: NewUser
    },
    {
      path: '/login',
      name: "login",
      component: Login
    },
    {
      path: '/user/:id',
      name: "user",
      component: User
    },
  ]
})
