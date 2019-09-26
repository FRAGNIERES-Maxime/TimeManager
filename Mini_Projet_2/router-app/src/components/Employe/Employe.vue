<template>
 <v-card class="mx-auto" >
  <div id="chrono">
    <div class="timer">
      <span class="hours">{{ hours }}</span>
      <span>:</span>
      <span class="minute">{{ minutes }}</span>
      <span>:</span>
      <span class="seconds">{{ seconds }}</span>
    </div>
    <div class="controls">
      <div class="start" v-if="!timer" @click="startTimer " >start
        <i data-feather="play" ></i>
      </div>
      <div class="stop" v-if="resetButton" @click="resetTimer">stop
        <i data-feather="rotate-cw"></i>
      </div>
    </div>
  </div>
</v-card>

</template>

<script> 

import api from '@/api/api';
import auth from '@/services/auth';

export default {

 

  name: 'Employe',
  data() {
          return {
    timer: null,
    totalTime: (0 * 60 ),
    resetButton: false,
    title: "working hours",
    edit: false
  }
  },
  methods: {
    startTimer: function() {
      this.timer = setInterval(() => this.count(), 1000); //1000ms = 1 second
      this.resetButton = true;
    },
    
    resetTimer: function() {
      this.totalTime = (0 * 60);
      clearInterval(this.timer);
      this.timer = null;
      this.resetButton = false;
    },
    editTimer: function() {
      this.edit = true;
    },
    padTime: function(time){
      return (time < 10 ? '0' : '') + time;
    },
    count: function() {
      this.totalTime++;
    },
     postClock(){
        //  api.postClock()

      },
  },
  computed: {
    hours: function(){
      const hours = Math.floor(this.totalTime / 60);
      return this.padTime(hours);
    },
    minutes: function(){
      const minutes = Math.floor(this.totalTime / 60);
      return this.padTime(minutes);
    },
    seconds: function() {
      const seconds = this.totalTime - (this.minutes * 60);
      return this.padTime(seconds);
    },
  }
}
  </script>

 <style>

.container {
  height: 100vh;
  width: 100%;
  
  display: flex;
  align-items: center;
  justify-content: center;
}

.theme--light.v-card {
    margin-top: 10%;
    background-color: #fff;
    color: rgba(0,0,0,.87);
}
  .chrono {
    display: flex; 
    flex-direction: column;
    align-items: center;
    margin-bottom: 2rem;
   
  }
  .timer {
    font-size:3rem;
    color: black;
  }
  .controls {
    display: flex;
    justify-content: space-evenly;
    width: 100%;
   
  }
  .input {
       background-color: white;
      border: none;
      font-size: 2rem;
      padding: 1em;
      text-align: center;
      color: black;
    
  }
  .mx-auto{
    background-color: white;
    margin: auto;
    width: 30% ;
    padding: 10px;
       border: 0.2px solid black;
  }

  .start{
   font-size:2rem;
  }
   .stop{
   font-size:2rem;
  }
   .pause{
   font-size:2rem;
  }
  </style>