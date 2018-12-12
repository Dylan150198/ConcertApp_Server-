class ApiError {

	constructor(message, code) {
		this.message = message;
		this.code = code;
		this.date = new Date();
	}
}

module.exports = ApiError