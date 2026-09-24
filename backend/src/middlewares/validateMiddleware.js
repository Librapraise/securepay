const validate = (schema) => (req, res, next) => {
  const { error, value } = schema.validate(req.body, { abortEarly: false, stripUnknown: true });
  if (error) {
    const errorDetails = error.details.map((d) => ({
      field: d.path.join('.'),
      message: d.message,
    }));
    return res.status(400).json({
      success: false,
      message: 'Validation failed',
      errors: errorDetails,
    });
  }
  req.body = value;
  next();
};

module.exports = validate;
