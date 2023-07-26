enum Explorer {
  Hange(model: "gpt-4-0613"),

  ///FInalment no he pogut utilitzar el model gpt3.5 turbo, ja que difícilment donava els resultats esperats
  Jinn(model: "gpt-4-0613");

  const Explorer({
    required this.model
  });

  final String model;
}