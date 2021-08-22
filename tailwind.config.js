module.exports = {
  purge: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
  ],
  darkMode: false, // or 'media' or 'class'
  mode: 'jit',  
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
