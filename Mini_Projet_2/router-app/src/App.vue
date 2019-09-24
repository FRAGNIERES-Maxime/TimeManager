<template>
  <div id="app">
    <!--<router-link :to="{ name: 'users' }">users</router-link>-->
    <router-view></router-view>
  </div>
</template>

<script>
    import axios from 'axios'
    import router from './router/'

    export default {
        name: 'App',
        name: 'Users',
        data() {
            return {
                msg: 'Loaad',
                list_user: "lala",
                q: "",
                new_user: {
                    username: "",
                    email: ""
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
                axios.get('http://localhost:9050/api/users?email=&username=' + this.q, {crossOrigine: true})
                    .then(result => {
                        this.list_user = result.data.data;

                    })

            },
            navigate(id) {
                router.push({name: "user", params: {id: id}})
            }
        }
    }
</script>

<style>
  @media screen and (min-width: 640px) {
    #app {
      height: 100%;
      color: #2c3e50;
    }
  }

  @media screen and (max-width: 990px) {
    #app {
      color: #2c3e50;
    }

  }
</style>
