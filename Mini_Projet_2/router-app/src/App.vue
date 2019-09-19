<template>
    <div id="app">
      <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <router-link :to="{ name: 'HelloWorld' }" class="navbar-brand text-light ">Time Manager</router-link>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item">
              <router-link :to="{ name: 'login' }" class="nav-link my-2">Sign in</router-link>
            </li>
            <li>
              <router-link :to="{ name: 'newUser' }" class="nav-link my-2">Sign up</router-link>
            </li>
          </ul>
          <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="text" placeholder="Search ..." v-model="q" v-on:keyup="getAllUsers()"/>
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
          </form>
        </div>
      </nav>

      <!--<router-link :to="{ name: 'users' }">users</router-link>-->
      <router-view></router-view>
    </div>
</template>

<script>
import axios from 'axios'
import router from './router/'
export default {
  name: 'App' ,
  name: 'Users',
  data () {
    return {
            msg: 'Loaad',
            list_user: "lala",
            q: "",
            new_user:{
                username: "",
                email:""
            },
            error: ""
        }
    },
    watch: {
        '$route': 'getAllUsers'
    },
    created() {
        this.getAllUsers()
    },
    methods: {
        getAllUsers() {
            axios.get('http://localhost:4000/api/users?email=&username=' + this.q, {crossOrigine: true})
                .then(result => {
                    this.list_user = result.data.data;

                })

        },
        navigate(id){
            router.push({name: "user", params: {id: id}})
        }
    }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  height: 100%;
  text-align: center;
  color: #2c3e50;
}

  .navbar{
    z-index: 5000;
    position: fixed;
    top: 0;
    width: 100%;
  }
</style>
