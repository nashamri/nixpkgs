{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,
  setuptools,
  versioneer,
  wheel,
  dask,
  pandas,
  pyarrow,
  distributed,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "dask-expr";
  version = "1.1.1";
  pyproject = true;

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "dask";
    repo = "dask-expr";
    rev = "refs/tags/v${version}";
    hash = "sha256-ltsRKbb/p+qHeNiX0oeZUKbbjPoPxSM4uFnWUFqoqhc=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail "versioneer[toml]==0.28" "versioneer[toml]"
  '';

  build-system = [
    setuptools
    versioneer
    wheel
  ];

  dependencies = [
    dask
    pandas
    pyarrow
  ];

  pythonImportsCheck = [ "dask_expr" ];

  nativeCheckInputs = [
    distributed
    pytestCheckHook
  ];

  __darwinAllowLocalNetworking = true;

  meta = {
    description = "A rewrite of Dask DataFrame that includes query optimization and generally improved organization";
    homepage = "https://github.com/dask/dask-expr";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ GaetanLepage ];
  };
}
