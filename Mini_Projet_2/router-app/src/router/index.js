import Vue from 'vue'
import Router from 'vue-router'
import User from '@/components/Admin/User'
import Users from '@/components/Admin/ListUsers'
import Login from '@/components/Connexion/Login'
import NewUser from '@/components/Connexion/NewUser'
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
