require 'find'

Gem::Specification.new do |s|
    s.name = 'rbtex'
    s.version = '0.1.5'
    s.date = '2016-03-26'
    s.description = 'The rubylatex gem'
    s.summary = 'RbTeX'
    s.authors = ['Steven Rosendahl']
    s.email = 'fsnewline@gmail.com'
    s.files = ['./lib/rbtex.rb', './rbtex.gemspec']
    s.executables << 'rblatex'
    s.homepage = 'https://github.com/RubyLatex/RbTeX'
    s.license = 'MIT'

    s.add_development_dependency 'colorize', ['>= 0']
    s.add_development_dependency 'table_flipper', ['>= 0']
end
