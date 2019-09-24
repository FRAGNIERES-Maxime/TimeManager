<template>
  <div>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
        <router-link :to="{ name: 'HelloWorld' }" class="navbar-brand text-light ">Time Manager</router-link>
        <ul class="navbar-nav mr-auto">
          <!--<li class="nav-item">
            <router-link :to="{ name: 'login' }" class="nav-link my-2">Sign in</router-link>
          </li>
          <li class="navbar-nav">
            <router-link :to="{ name: 'newUser' }" class="nav-link my-2">Sign up</router-link>
          </li>-->
        </ul>

        <form class="form-inline my-2 my-lg-0">
          <input class="form-control mr-sm-2" type="text" placeholder="Search ..." v-model="q"
                 v-on:keyup="getAllUsers()"/>
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
          <li class="navbar-nav my-2" style="margin-left: 10px">
            <button class="btn btn-danger">Disconnect</button>
          </li>
        </form>
      </div>
    </nav>
    <div id='users' class="container">
      <!-- Site: COREUI.IO ------------------------------------------------------------------------------------->
      <div class="row">
        <div class="col-sm-6 col-lg-4" v-for="u in list_user"
             :key="u.id">
          <div class="brand-card" v-on:click="navigate(u.id)">
            <div class="brand-card-header bg-success">
              <h3>00:00:00</h3>
            </div>
            <div class="brand-card-body">
              <div>
                <div class="text-value">Name:</div>
                <div class="text-uppercase text-muted small">{{u.username}}</div>
              </div>
              <div>
                <div class="text-value">Email:</div>
                <div class="text-uppercase text-muted small">{{u.email}}</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
      <!-- Site: COREUI.IO ------------------------------------------------------------------------------------->

        <!--<div v-if="!list_user || !list_user.length">No User</div>
        <div>
            <h3>Create a user</h3>
            <input type="text" placeholder="Username" v-model="new_user.username">
            <br>
            <input type="email" placeholder="Email" v-model="new_user.email">
            <br>
            <div style="color:red" v-if="error">
                <span v-for="(value, key) in error"
                :key="key">
                {{key}} {{value}}
                <br>
                </span>
            </div>
            <button v-on:click="createUser()">submit</button>
        </div>-->
    </div>
</template>

<script>
import axios from 'axios';
import router from '../router/';

export default {
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
      getAllUsers(){
          axios.get('http://localhost:9050/api/users?email=&username='+this.q, {crossOrigine: true})
          .then(result => {
                this.list_user = result.data.data;

          })

      },
      createUser(){
          axios.post('http://localhost:9050/api/users', {user: this.new_user},  {crossOrigine: true})
          .then((result) => {
                this.error = "";
                this.list_user = result.data.data;
                this.getAllUsers();
          })
          .catch((err, data) => {
              this.error = err.response.data.errors;
          });
      },
      deleteUser(id, event){
          if (event) event.preventDefault()
          axios.delete('http://localhost:9050/api/users/'+id ,  {crossOrigine: true})
          .then(result => {
                this.list_user = result.data.data;
                this.getAllUsers()
          })
      },
      navigate(id){
          router.push({name: "user", params: {id: id}})
      }
  }
}
</script>

<style>
  @media screen and (min-width: 640px) {

    .navbar {
      z-index: 5000;
      position: fixed;
      top: 0;
      width: 100%;
    }
  }

  @media screen and (max-width: 990px) {

    .navbar{
      z-index: 5000;
      top: 0;
      width: 100%;
    }
  }

  #users {
    Margin-top: 3%;
  }

  .container {
    background-color: #919191;
    width: 100%;
    box-shadow: -1px 2px 5px 1px rgba(0, 0, 0, 0.7);
    padding: 50px;
  }
</style>
