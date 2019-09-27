
import Vue from 'vue'
import axios from 'axios'
import auth from '@/services/auth'
const client = axios.create({
  baseURL: 'http://localhost:9050/api/',
  json: true
})

export default {
  async execute (method, resource, data) {
    // inject the accessToken for each request
    let accessToken = await Vue.prototype.$auth.getAccessToken()
    return client({
      method,
      url: resource,
      data,
      headers: {
        Authorization: `Bearer ${accessToken}`
      }
    }).then(req => {
      return req.data
    })
  },
  

  //get users of login user
  getAllUsers(){
   return axios.get('http://localhost:9050/api/users', auth.getHeaders())
   },


  deleteUser(id){
    return axios.delete('http://localhost:9050/api/users/'+id, auth.getHeaders())
  
},
getUser(id) {
    return axios.get('http://localhost:9050/api/user/'+id ,auth.getHeaders())
        
},
getClock(id) {
    return axios.get('http://localhost:9050/api/clocks/' +id ,auth.getHeaders())
    
},
postClock(id) {
    return axios.post('http://localhost:9050/api/clocks/' +id ,{}, auth.getHeaders() )      
},
getListWork(id) {
    return axios.get('http://localhost:9050/api/workingtimes/' +id ,auth.getHeaders())
}
    }