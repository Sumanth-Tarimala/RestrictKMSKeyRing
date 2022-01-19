resource "google_access_context_manager_access_level" "access-level" {
  parent = "accessPolicies/${google_access_context_manager_access_policy.access-policy.name}"
  name   = "accessPolicies/${google_access_context_manager_access_policy.access-policy.name}/accessLevels/secure_data_exchange"
  title  = "secure_data_exchange"
  basic {
    conditions {
      device_policy {
        require_screen_lock = false
        os_constraints {
          os_type = "DESKTOP_CHROME_OS"
        }
      }
      regions = [
        "CH",
        "IT",
        "US",
      ]
    }
  }
}

resource "google_access_context_manager_access_policy" "access-policy" {
  parent = "organizations/123456789"
  title  = "my policy"
}

resource "google_access_context_manager_service_perimeters" "service-perimeter" {
  parent = "accessPolicies/${google_access_context_manager_access_policy.access-policy.name}"

  service_perimeters {
    name   = "accessPolicies/${google_access_context_manager_access_policy.access-policy.name}/servicePerimeters/"
    title  = "service-perimeter-1"
    status {
      restricted_services = ["bigquery.googleapis.com", "storage.googleapis.com","cloudkms.googleapis.com"]
      access_levels       = [google_access_context_manager_access_level.access-level.name]

      ingress_policies {
          ingress_from {
              sources {
                  access_level = google_access_context_manager_access_level.access-level.name
              }
              identity_type = "IDENTITY_TYPE_UNSPECIFIED"
          }
          ingress_to {
            resources = [ "*" ]
            operations {
                service_name = "bigquery.googleapis.com"
                method_selectors {
                    method = "BigQueryStorage.ReadRows"
                }
                method_selectors {
                    method = "TableService.ListTables"
                }
                method_selectors {
                    permission = "bigquery.jobs.get"
                }
            }
            operations {
                service_name = "storage.googleapis.com"
                method_selectors {
                    method = "google.storage.objects.create"
                }
            }
        }
      }

      egress_policies {
          egress_from {
              identity_type = "IDENTITY_TYPE_UNSPECIFIED"
          }
          egress_to {
              resources = [ "*" ]
              operations {
                  service_name = "bigquery.googleapis.com"
                  method_selectors {
                      method = "BigQueryStorage.ReadRows"
                  }
                  method_selectors {
                      method = "TableService.ListTables"
                  }
            
              }
          }
      }
    }
  }

  service_perimeters {
    name   = "accessPolicies/${google_access_context_manager_access_policy.access-policy.name}/servicePerimeters/"
    title  = "service-perimeter-1"
    status {
      restricted_services = ["bigquery.googleapis.com", "storage.googleapis.com","cloudkms.googleapis.com"]
      access_levels       = [google_access_context_manager_access_level.access-level.name]

      ingress_policies {
          ingress_from {
              sources {
                  access_level = google_access_context_manager_access_level.access-level.name
              }
              identity_type = "IDENTITY_TYPE_UNSPECIFIED"
          }
      }

      egress_policies {
          egress_from {
              identity_type = "IDENTITY_TYPE_UNSPECIFIED"
          }
      }
    }
  }
}

resource "google_access_context_manager_service_perimeters" "service-perimeter1" {
  parent = "accessPolicies/${google_access_context_manager_access_policy.access-policy.name}"

  service_perimeters {
    name   = "accessPolicies/${google_access_context_manager_access_policy.access-policy.name}/servicePerimeters/"
    title  = "service-perimeter-3"
    status {
      restricted_services = ["bigquery.googleapis.com", "storage.googleapis.com","cloudkms.googleapis.com"]
      access_levels       = [google_access_context_manager_access_level.access-level.name]

      ingress_policies {
          ingress_from {
              sources {
                  access_level = google_access_context_manager_access_level.access-level.name
              }
              identity_type = "IDENTITY_TYPE_UNSPECIFIED"
          }
          ingress_to {
            resources = [ "*" ]
            operations {
                service_name = "bigquery.googleapis.com"
                method_selectors {
                    method = "BigQueryStorage.ReadRows"
                }
                method_selectors {
                    method = "TableService.ListTables"
                }
                method_selectors {
                    permission = "bigquery.jobs.get"
                }
            }
            operations {
                service_name = "storage.googleapis.com"
                method_selectors {
                    method = "google.storage.objects.create"
                }
            }
        }
      }

      egress_policies {
          egress_from {
              identity_type = "IDENTITY_TYPE_UNSPECIFIED"
          }
          egress_to {
              resources = [ "*" ]
              operations {
                  service_name = "bigquery.googleapis.com"
                  method_selectors {
                      method = "BigQueryStorage.ReadRows"
                  }
                  method_selectors {
                      method = "TableService.ListTables"
                  }
            
              }
          }
      }
    }
  }

  service_perimeters {
    name   = "accessPolicies/${google_access_context_manager_access_policy.access-policy.name}/servicePerimeters/"
    title  = "service-perimeter-1"
    status {
      restricted_services = ["bigquery.googleapis.com", "storage.googleapis.com","cloudkms.googleapis.com"]
      access_levels       = [google_access_context_manager_access_level.access-level.name]

      ingress_policies {
          ingress_from {
              sources {
                  access_level = google_access_context_manager_access_level.access-level.name
              }
              identity_type = "IDENTITY_TYPE_UNSPECIFIED"
          }
      }

      egress_policies {
          egress_from {
              identity_type = "IDENTITY_TYPE_UNSPECIFIED"
          }
      }
    }
  }
}


resource "google_access_context_manager_service_perimeter" "test-access" {
  parent         = "accessPolicies/${google_access_context_manager_access_policy.access-policy.name}"
  name           = "accessPolicies/${google_access_context_manager_access_policy.access-policy.name}/servicePerimeters/%s"
  title          = "%s"
  perimeter_type = "PERIMETER_TYPE_REGULAR"
  status {
    restricted_services = ["bigquery.googleapis.com", "storage.googleapis.com"]
        access_levels       = [google_access_context_manager_access_level.access-level.name]

        vpc_accessible_services {
            enable_restriction = true
            allowed_services   = ["bigquery.googleapis.com", "storage.googleapis.com","cloudkms.googleapis.com"]
        }

        ingress_policies {
            ingress_from {
                sources {
                    access_level = google_access_context_manager_access_level.access-level.name
                }
                identity_type = "IDENTITY_TYPE_UNSPECIFIED"
            }

            ingress_to {
                resources = [ "*" ]
                operations {
                    service_name = "bigquery.googleapis.com"

                    method_selectors {
                        method = "BigQueryStorage.ReadRows"
                    }

                    method_selectors {
                        method = "TableService.ListTables"
                    }

                    method_selectors {
                        permission = "bigquery.jobs.get"
                    }
                }

                operations {
                    service_name = "storage.googleapis.com"

                    method_selectors {
                        method = "google.storage.objects.create"
                    }
                }
            }
        }

        egress_policies {
            egress_from {
                identity_type = "IDENTITY_TYPE_UNSPECIFIED"
            }
            egress_to {
              operations {
                    service_name = "bigquery.googleapis.com"

                    method_selectors {
                        method = "BigQueryStorage.ReadRows"
                    }

                    method_selectors {
                        method = "TableService.ListTables"
                    }

                    method_selectors {
                        permission = "bigquery.jobs.get"
                    }
                }

                operations {
                    service_name = "bigquery.googleapis.com"

                    method_selectors {
                        method = "BigQueryStorage.ReadRows"
                    }

                    method_selectors {
                        method = "TableService.ListTables"
                    }

                    method_selectors {
                        permission = "bigquery.jobs.get"
                    }
                }
              
            }
        }
  }
}