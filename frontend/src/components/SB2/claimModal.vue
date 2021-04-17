<template>
    <!-- Modal -->
    <div class="modal fade" id="claimModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-primary" id="exampleModalLabel">Buy {{ title }} Cover</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="my-2">
                    <label for="" class="font-weight-bold">Loss Type</label>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <label class="input-group-text" for="inputGroupSelect01">Loss Type</label>
                        </div>
                        <select v-model="claimData.policyType" v-if="losses" class="custom-select" id="inputGroupSelect01">
                            <!-- <option selected>Choose...</option> -->
                            <option :key="loss.index" v-for="loss in losses" :value="loss">{{ loss }} </option>
                        </select>
                    </div>
                </div>
                
                <div class="my-2">
                    <label for="" class="font-weight-bold">Decribe the Loss Event</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Description</span>
                        </div>
                        <textarea v-model="claimData.description" class="form-control" aria-label="With textarea" rows=5></textarea>
                    </div>
                </div>

                <div class="my-2">
                    <label for="dateofEvent" class="font-weight-bold">Date:</label>
                    <div class="input-group">
                        <input v-model="claimData.date" class="form-control" type="datetime-local" id="dateofEvent" name="dateofEvent">                    
                    </div>
                </div>

                <div class="my-2">
                    <label for="dateofEvent" class="font-weight-bold">Claims Stake</label>
                    <div class="input-group mb-3">
                        <input type="number" v-model="claimData.claimStake" class="form-control" placeholder="Stake SRX" aria-label="Recipient's username" aria-describedby="basic-addon2">
                        <div class="input-group-append">
                            <span class="input-group-text text-success" id="basic-addon2">SRX</span>
                        </div>
                    </div>
                </div>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success">Submit Claim</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
            </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "ClaimModal",
    // props: [ 'pID', 'title', 'losses' ],
    props:{ 
        pID    : Number,
        title  : String,
        losses : Array,

    },
    setup() {
        
    },

    data(){
        return{
            claimData : {
                addr        : null,
                policyType  : null,
                description : null,
                date        : null,
                claimStake       : null,
            }
        }
    },

    methods:{

        // Call Smart contract Function and pass data for claims
        submitClaim(){
            confirm("Claim Submitted")
        },

        // Get from smart contract
        getStakeLimit(){
            let stakeLimit = 5;
            this.claimData.claimStake = Number(stakeLimit);
        }
    },

    mounted(){
        //Get Stake Limit
        this.getStakeLimit()        
    }
}
</script>
<style lang="scss">
    @import "/src/assets/variables.scss";
    label{
        color: $gray-800;
    }
</style>