
@rem Build the data file.
pushd ..
python "%EMSCRIPTEN%/tools/file_packager.py" Emscripten/data.data --preload Data --js-output=Emscripten/data.js
popd

@rem Launch the default web browser.
start MyEngine.html
