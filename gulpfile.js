var gulp       = require('gulp');
var browserify = require('gulp-browserify');
var rename     = require('gulp-rename');

gulp.task('browserify', function() {
  gulp.src('javascript_src/app.js')
    .pipe(browserify({transform: 'cjsxify'}))
    .pipe(rename('bundle.js'))
    .pipe(gulp.dest('app/assets/javascripts/'));
});

gulp.task('default', ['browserify']);

gulp.task('watch', function() {
  gulp.watch('javascript_src/**/*.*', ['default']);
});
