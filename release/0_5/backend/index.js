const express = require('express')
const app = express()
const exec = require('child_process').exec
const bodyparser = require('body-parser')
const mongodb = require('mongodb')
const cors = require('cors')
const uri = 'mongodb+srv://User:yGU1zydDXiTmaCbX@Cluster0.s1ici.mongodb.net/sample_parsingdata?retryWrites=true&w=majority'
const MongodbClient = mongodb.MongoClient

const port = 30000

async function run(){
    const client = MongodbClient.connect(uri, function(err, db){
        var dbo = db.db('sample_parsingdata')
        var collection = dbo.collection('pgstrom_datasets')
        var changeStream = collection.watch()

        changeStream.on("change", (next) => {
            // console.log(next.fullDocument)

            let SF = next.fullDocument.DB_Size
            let Qnum = next.fullDocument.Q_Set[0]
            let Count = next.fullDocument.Number_Of_Q_Execution
        
            exec(`./macro_log ${SF} ${Qnum} ${Count}`,function(code, stdout, stderr){
                let result = JSON.parse(stdout)
                console.log(result)
                collection.insertOne({
                    totalcounts: result.TotalCounts,
                    gpupagefaultsgroups: result.GpupageFaultsGroups,
                    gpupagefaults: result.GpupageFaults,
                    kerneltime : result.KernelTime,
                    dtohtime : result.DtoHTime,
                    htodtime: result.HtoDTime
                })
            })


            // exec(`java ${__dirname}/Parsing.java`,function(code, stdout, stderr){
            //     let result = JSON.parse(stdout)
            //     collection.insertOne({
            //         totalcounts: result.TotalCounts,
            //         gpupagefaultsgroups: result.GpupageFaultsGroups,
            //         gpupagefaults: result.GpupageFaults,
            //         kerneltime : result.KernelTime,
            //         dtohtime : result.DtoHTime,
            //         htodtime: result.HtoDTime
            //     })
            // })
        })
    })
}
run().catch(console.dir)

app.listen(port,() => {
    console.log(`${port} is open`)
})