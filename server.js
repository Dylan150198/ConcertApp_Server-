/*
 * Requires to packages I will use in this server.
 */

const express = require('express')
const morgan = require('morgan')
const bodyParser = require('body-parser')

/*
 * Requires to files that have the routing described.
 */

const concertRoutes = require('./src/routes/concert.routes')
const authRoutes = require('./src/routes/auth.routes')

/*
 * Requires to files that have the errorhandling routing described.
 */

const authController = require('./src/controllers/auth.controller')

/*
 * Requires to files that have the errorhandling model.
 */

const ApiError = require('./src/domain/models/apierror.model')

/**
* Tell express to use morgan and bodyparser.
*/

var app = express()
app.use(morgan('dev'))
app.use(bodyParser.json())

/*
* Port the server will run on
*/

const port = process.env.PORT || 3000

/*
 * Routing
 */

app.use('/api', authRoutes)

app.all('*', authController.validateJWT)

app.use('/api', concertRoutes)

//Handler for non existing endpoints.
app.use('*', (req, res, next) => {
	next(new ApiError('404 Not Found.', 404))
})

//Handler voor errors
app.use('*', (err, req, res, next) => {
	console.dir(err)
	res.status(err.code).json({ error: err }).end()
})

/**
 * Tell the server to listen to incoming requests.
 */
app.listen(port, () => console.log(`Concert app listening on port ${port}!`))

// For testing purposes.
module.exports = app