{
  description = "vosk-pkg";

  outputs = _: {
    dcModules = {
      vosk = import ./vosk;
    };
  };
}
