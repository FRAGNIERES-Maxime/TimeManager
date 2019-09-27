<template>
    <div id="adminpage">
        <Users/>
    </div>    
</template>

<script>

import Users from '@/components/Admin/ListUsers';

export default {
    name:'adminpage',
    components: {Users}
}
</script>
