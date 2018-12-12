/**
 * Require the following router and controllers.
 */

const router = require('express').Router()
const concertController = require('../controllers/concert.controller')
const authController = require('../controllers/auth.controller')

/**
 * Set the following routes in controllers.
 */

router.get('/concerts', authController.validateJWT, concertController.getAll)
router.get('/concerts/:concertId', authController.validateJWT, concertController.getById)
router.post('/concerts', authController.validateJWT, concertController.addConcert)
router.delete('/concerts/delete/:id', authController.validateJWT, concertController.deleteConcertById)
router.put('/concerts/update/:id', authController.validateJWT, concertController.updateConcertById) 
router.post('/register', authController.register)
router.post('/login', authController.login)

/**
 * Export routes.
 */

module.exports = router