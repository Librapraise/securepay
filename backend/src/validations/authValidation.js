const Joi = require('joi');

const signupSchema = Joi.object({
  firstName: Joi.string().trim().min(2).max(50).required(),
  lastName: Joi.string().trim().min(2).max(50).required(),
  email: Joi.string().email().lowercase().trim().required(),
  phoneNumber: Joi.string().trim().min(8).max(20).required(),
  password: Joi.string()
    .min(8)
    .max(128)
    .regex(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]/)
    .message('Password must be at least 8 chars with 1 uppercase, 1 lowercase, 1 digit, and 1 special char')
    .required(),
});

const loginSchema = Joi.object({
  email: Joi.string().email().lowercase().trim().required(),
  password: Joi.string().required(),
});

module.exports = { signupSchema, loginSchema };
