module.exports = options => {
  return async function adminauth(ctx, next) {
    const token = ctx.request.header.authorization;
    const res = ctx.app.jwt.verify(token, ctx.app.config.jwt.secret);
    if (res) {
      await next();
    } else {
      ctx.body = { data: '没有登录' };
    }
  };
};
