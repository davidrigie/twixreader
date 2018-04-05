
# Always prefer setuptools over distutils
from setuptools import setup, find_packages
# To use a consistent encoding
from codecs import open
from os import path

here = path.abspath(path.dirname(__file__))

# Get the long description from the README file
with open(path.join(here, 'README.md'), encoding='utf-8') as f:
    long_description = f.read()

setup(
    name='twixreader',  
    version='0.1.1', 
    description='reads Siemens MRI raw data',
    long_description=long_description, 
    #url='', 
    author='David Rigie',
    author_email='daverigie@gmail.com',  
    packages=find_packages(exclude=['contrib', 'docs', 'tests']),  # Required
    include_package_data = True,
    entry_points = {
                  'console_scripts': ['twix2html=twixreader.command_line:main'],
            },
    python_requires='>=3.0',
    install_requires=[
        'numpy',
        'antlr4-python3-runtime',
        'pyyaml'
        ]
)