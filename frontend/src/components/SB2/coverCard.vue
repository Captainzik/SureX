<template>
    <div class="coverCard card shadow mb-4">
        <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold coverTitle">
            {{ cover.title }}
        </h6>
        </div>
        <div class="card-body">
        <div class="text-center imgWrapper">
            <img
            class="img-fluid px-3 px-sm-4 mt-3 mb-4"
            style="width: 25rem"
            :src="cover.icon"
            :alt="cover.title"
            />
        </div>
        <p class="coverDescription">{{ cover.description }}</p>
        <a class="coverLink" @click="policyClicked(cover.id)"
            >Click to view policy</a
        >
        </div>
    </div>
</template>

<script>
export default {
    name: "Cover Card",
    props:{
        cover: Object
    },
    setup() {
        
    },
    methods:{
        policyClicked( policyID ){
            this.$parent.viewCover( policyID );
        }
    }
}
</script>