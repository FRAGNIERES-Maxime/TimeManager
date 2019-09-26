<template>
  <div id="app">
    <!--Header-->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo01"
              aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
        <button v-on:click="goDashboard()">TimeManager</button>
        <ul class="navbar-nav mr-auto"></ul>

        <form class="form-inline my-2 my-lg-0" v-if="checkCo()">
            <li>
              <label v-if="me.id != 0">{{ checkMe() }}</label>
            </li>
            <li class="navbar-nav my-2" style="margin-left: 10px">
              <button class="btn btn-danger" v-on:click="deco" v-if="me.id != 0">Disconnect</button>
            </li>
        </form>
      </div>
    </nav>
    <!---->


    <!--<router-link :to="{ name: 'users' }">users</router-link>-->
    <router-view></router-view>
  </div>
</template>

<script>
    import axios from 'axios';
    import router from './router/';
    import auth from '@/services/auth';
    import login from '@/services/login'

    export default {
        name: 'App',
        name: 'Users',
        data() {
            return {
                msg: 'Loaad',
                me: {},
                list_user: "lala",
                q: "",
                new_user: {
                    username: "",
                    email: ""
                },

                logged: localStorage.getItem("token-auth") !== null,
                error: ""
            }
        },
        created() {

            this.me = login.getMe();
            if (auth.token == null) {
                console.log(this.$router.history.current.path)
                if (this.$router.history.current.path != "/login" && this.$router.history.current.path != "/NewUser") {
                    this.$router.push("/login")
                }

            }
        },
        updated() {
            console.log("he passe ");
            this.me = login.getMe();
            if (auth.token == null) {
                if (this.$router.history.current.path != "/login" && this.$router.history.current.path != "/NewUser") {
                    this.$router.push("/login")
                }
            }
        },
        methods: {
            checkMe() {
                return this.me.username;
            },
            checkCo() {
                console.log(auth.isAuth())
                return auth.isAuth();
            },
            navigate(id) {
                router.push({name: "user", params: {id: id}})
            },
            deco() {
                login.logOut()
            },
            goDashboard() {
                login.goDashboard()
            }
        }
    }
</script>

<style>
  li {
    list-style: none;
  }

  @media screen and (min-width: 640px) {
    #app {
      height: 100%;
      color: #2c3e50;
    }

    .navbar {
      z-index: 5000;
      position: fixed;
      top: 0;
      width: 100%;
    }
  }

  @media screen and (max-width: 990px) {
    #app {
      color: #2c3e50;
    }

    .navbar {
      z-index: 5000;
      top: 0;
      width: 100%;
    }
  }
</style>
