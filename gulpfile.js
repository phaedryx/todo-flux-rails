var gulp       = require('gulp');
var browserify = require('browserify');
var mocha      = require('gulp-mocha');
var concat     = require('gulp-concat');
var sequence   = require('run-sequence');
var stream     = require('vinyl-source-stream');

var PATH       = './app/assets/javascripts'

gulp.task('default', ['browserify']);

gulp.task('browserify', function() {
  return browserify(PATH + '/src/app.js')
    .bundle()
    .pipe(stream('bundle.js'))
    .pipe(gulp.dest(PATH));
});

gulp.task('watch', function() {
  return gulp.watch(PATH + '/src/**/*.*', ['default']);
});

gulp.task('test-build', function() {
  return gulp.src([PATH + '/test/test_helper.coffee', PATH + '/test/**/*_test.coffee'])
    .pipe(concat('test_build.coffee'))
    .pipe(gulp.dest(PATH + '/test'))
});

gulp.task('test-run', function() {
  return browserify(PATH + '/test/test_build.coffee')
    .bundle()
    .pipe(stream('test_run.js'))
    .pipe(gulp.dest(PATH + '/test'))
    .pipe(mocha({reporter: 'dot'}))
    .on('error', function(err) {
      // add logging
      this.emit('end');
    });
});

gulp.task('test', function() {
  sequence('test-build', 'test-run')
});
