BUILD_MARCH_NATIVE=0 python setup.py bdist_wheel --plat-name=manylinux2014_x86_64
cd dist && pip install --force-reinstall *.whl 