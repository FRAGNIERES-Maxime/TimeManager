<template>
  <!------------------------------------------- NAVBAR ---------------------------------------------->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo01"
            aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
      <router-link :to="{ name: 'login' }" class="navbar-brand text-light">Time Manager</router-link>
      <ul class="navbar-nav mr-auto"></ul>

      <form class="form-inline my-2 my-lg-0">

        <li class="navbar-nav my-2" style="margin-left: 10px">
          <button class="btn btn-danger" v-on:click="deco" v-if="logged">Disconnect</button>
        </li>
      </form>
    </div>
  </nav>
  <!------------------------------------------- NAVBAR ---------------------------------------------->
</template>

<script>
import login from '@/services/login'
    export default {
        name: "Header",
        data() {
            return {
                logged: localStorage.getItem("token-auth") !== null
            }
        },
        methods:{
          deco(){
            login.logOut()
          }
        }
    }
</script>

<style scoped>

</style>
