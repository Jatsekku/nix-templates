{ stdenv, cmake }:
stdenv.mkDerivation {
    pname = "cLib";
    version = "0.1.0";

    # Point to project root
    src = ../.;

    nativeBuildInputs = [
        cmake
    ];

    cmakeFlags = [
        "-DBUILD_TESTING=OFF"
        "-DBUILD_EXAMPLES=OFF"
        "-DBUILD_SHARED_LIBS=OFF"
    ];
}
