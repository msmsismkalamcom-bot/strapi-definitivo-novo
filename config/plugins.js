module.exports = ({ env }) => ({
  upload: {
    config: {
      provider: "local",
      sizeLimit: 1000000,
      providerOptions: {},
    },
  },
});
