data "template_file" "openapi_api_definition" {
  template = file("./openapi.yaml")
}
