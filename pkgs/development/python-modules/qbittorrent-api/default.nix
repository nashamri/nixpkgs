{ lib
, buildPythonPackage
, fetchPypi
, requests
, six
, urllib3
, packaging
, setuptools
, wheel
}:

buildPythonPackage rec {
  pname = "qbittorrent-api";
  version = "2023.11.57";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-fmFJW4PDQc7szu0ymE+fV9k6wUDLRHkOriEHDnzDSQg=";
  };

  propagatedBuildInputs = [
    requests
    six
    urllib3
    packaging
  ];

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  # Tests require internet access
  doCheck = false;

  pythonImportsCheck = [
    "qbittorrentapi"
  ];

  meta = with lib; {
    description = "Python client implementation for qBittorrent's Web API";
    homepage = "https://github.com/rmartin16/qbittorrent-api";
    changelog = "https://github.com/rmartin16/qbittorrent-api/blob/v${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ savyajha ];
  };
}
