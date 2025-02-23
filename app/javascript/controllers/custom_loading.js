function registerControllerFromPath(path, under, application) {
  let name = path
  .replace(new RegExp(`^${under}/`), "")
  .replace("controller", "")
  .replace(/\//g, "--")
  .replace(/_/g, "-");

  if (name.endsWith("--")) name = name.slice(0, -2)
  if (name.endsWith("-")) name = name.slice(0, -1)

  if (canRegisterController(name, application)) {
    import(path)
    .then(module => registerController(name, module, application))
    .catch(error => console.error(`Failed to register controller: ${name} (${path})`, error))
  }
}
