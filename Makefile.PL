use inc::Module::Install;
name 'Data-Generator';
all_from 'lib/Data/Generator.pm';
readme_from 'lib/Data/Generator.pm';

githubmeta;

# requires '';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
