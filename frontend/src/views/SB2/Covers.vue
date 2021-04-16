<template>
<div class="container-fluid">
                    
    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 @click="handlClick" class="h3 mb-0 text-gray-800">Cover</h1>
        <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
                class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
    </div>

    <!-- Content Row -->
    <div class="row">
        <Section id="Covers" class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6" :key="cover.index" v-for="cover in covers">
                    <div class="coverCard card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary"> {{ cover.title }} </h6>
                        </div>
                        <div class="card-body">
                            <div class="text-center imgWrapper">
                                <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 25rem;" :src="cover.icon" :alt="cover.title">
                            </div>
                            <p>{{ cover.description }}</p>
                            <a target="_blank" rel="nofollow" href="https://undraw.co/">Browse Illustrations on
                                unDraw →</a>
                        </div>
                    </div>
                </div>
            </div>
        </Section>
    </div>

</div>
</template>
<script>
import laptop from "../../assets/SVGs/undraw_noted_pc9f.svg";

export default {
    name : "Covers",
    setup() {
        
    },
    data(){
        return{
            svgBaseDit : '../../assets/SVGs/',
            covers:[
                {
                    title           : "Laptop Covers",
                    icon            : require('../../assets/SVGs/undraw_noted_pc9f.svg'),
                    description     : "Progressively develop optimal partnerships with reliable architectures. Conveniently disseminate customized scenarios rather than wireless intellectual capital. Interactively syndicate frictionless."
                },
                {
                    title           : "Smartphone Covers",
                    icon            : require('../../assets/SVGs/undraw_calling_kpbp.svg'),
                    description     : "Progressively develop optimal partnerships with reliable architectures. Conveniently disseminate customized scenarios rather than wireless intellectual capital. Interactively syndicate frictionless."
                },
                {
                    title           : "Camera Covers",
                    icon            : "undraw_Camera_re_cnp4.svg",
                    description     : "Progressively develop optimal partnerships with reliable architectures. Conveniently disseminate customized scenarios rather than wireless intellectual capital. Interactively syndicate frictionless."
                },
                {
                    title           : "Laptop Covers",
                    icon            : "undraw_Camera_re_cnp4.svg",
                    description     : "Progressively develop optimal partnerships with reliable architectures. Conveniently disseminate customized scenarios rather than wireless intellectual capital. Interactively syndicate frictionless."
                },
                {
                    title           : "Gaming Controller",
                    icon            : "undraw_gaming_6oy3.svg",
                    description     : "Progressively develop optimal partnerships with reliable architectures. Conveniently disseminate customized scenarios rather than wireless intellectual capital. Interactively syndicate frictionless."
                },
                {
                    title           : "Laptop Covers",
                    icon            : "laptop",
                    description     : "Progressively develop optimal partnerships with reliable architectures. Conveniently disseminate customized scenarios rather than wireless intellectual capital. Interactively syndicate frictionless."
                },
            ]
        }
    }
}
</script>
<style lang="scss">
    .coverCard{
        .imgWrapper{
            
            
        }
    }
</style>