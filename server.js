const express=require('express')
const app=express()
const socketio=require('socket.io')
const http=require('http')
const exp = require('constants')


const server=http.createServer(app)
const io=socketio(server)

app.set('view engine','ejs')
app.use(express.static('public'))
const port=3000

io.on('connection',(socket)=>{
    console.log('connected')
    socket.on('send-location',(data)=>{
        io.emit('receive-location',{id:socket.id, ...data})
    })

    socket.on('disconnect',()=>{
        io.emit('user-disconnected',socket.id)
    })
})

app.get('/',(req,res)=>{
    res.render('index')
})

server.listen(port,()=>{
    console.log(`listen port ${port}`);
})
