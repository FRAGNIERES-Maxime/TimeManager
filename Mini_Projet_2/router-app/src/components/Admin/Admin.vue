<template>
    <div id="adminpage">
        <Users v-on:childToParent="onChildClick"/>
        <button @click="idUser=0; idManager=0">aaaa</button>
        <User v-if="idUser" :test="idUser"/>
        <Manager v-if="idManager" :selector="idManager"/>
    </div>  
</template>

<script>

import Users from '@/components/Admin/ListUsers';
import User from '@/components/Admin/User.vue';
import Manager from '@/components/Managers/Manager.vue';
export default {
    name:'adminpage',
    components: {Users, User, Manager},
    
    data(){
        return {
            idUser: 0,
            idManager: 0
        }
    },
    methods:{
        onChildClick(id){
            console.log("lala")
            this.idManager = 0;
            this.idUser  = 0;
            if (id < 0)
                this.idManager  = id;
            else 
                this.idUser = id;
        },

    }
}
</script>
