<template>
  <v-app id="inspire">
    <v-navigation-drawer v-model="drawer" app clipped>
          
     <br><br><router-link :to="{ name: 'HelloWorld' }"  >Home</router-link><br>
    <router-link :to="{ name: 'users' }">users</router-link><br>
    <router-link :to="{ name: 'report' }">report</router-link>    
       
    </v-navigation-drawer>

    <v-app-bar app clipped-left>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
      <v-toolbar-title>Application</v-toolbar-title>
    </v-app-bar>

    <v-content>
      <v-container class="fill-height" fluid>
         <router-view></router-view>
      </v-container>
    </v-content>

    
  </v-app>
</template>

<script>
  export default {
    name: 'App',
  
  }
  </script>

  <style lang="scss">

  .theme--dark.v-sheet {
    background-color: #000000;
    border-color: #424242;
    color: #fff;
}

.theme--dark.v-navigation-drawer {
    border-right-style: outset;
    background-color: #131313;
    border-color: white;
}

.theme--dark.v-application {
    background: #fff;
    color: #fff;
}

.v-content__wrap {
    flex: 1 1 auto;
    max-width: 100%;
    position: relative;
    background-color: black;
}
  </style>