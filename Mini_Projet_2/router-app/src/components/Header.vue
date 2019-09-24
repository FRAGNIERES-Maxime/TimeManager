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

        <input class="form-control mr-sm-2" type="text" placeholder="Search ..." v-model="q" v-on:keyup="getAllUsers()" v-if="logged"/>
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit" v-if="logged">Search</button>
        <li class="navbar-nav my-2" style="margin-left: 10px">
          <router-link class="btn btn-danger" :to="{ name: 'login' }" v-if="logged">Disconnect</router-link>
        </li>
      </form>
    </div>
  </nav>
  <!------------------------------------------- NAVBAR ---------------------------------------------->
</template>

<script>
    export default {
        name: "Header",
        data() {
            return {
                logged: localStorage.getItem("jwt") !== null
            }
        }
    }
</script>

<style scoped>

</style>
