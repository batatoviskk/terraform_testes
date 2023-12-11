



#----------------------------------------------------------------------------------------------------------------
# SKU Clusters
#----------------------------------------------------------------------------------------------------------------

locals {
  legend = {
    tag_clusters = var.env.name == "dev" ? "Develop" : var.env.name == "qas" ? "Homolog" : "Production"

  }


  clusters = {

    "ClusterSmallSizeDevelop" : {
      cluster_name   = title("${var.project.team} - Cluster Small Size - ${local.legend.tag_clusters}")
      node_type      = "Standard_D4ads_v5"
      min_workers    = 1
      max_workers    = 4
      runtime_engine = "PHOTON"
      spark_version  = "12.2.x-scala2.12"
    },


    "ClusterDataFactory" : {
      cluster_name   = title("${var.project.team} - Cluster - Data Factory")
      node_type      = "Standard_D32ads_v5"
      min_workers    = 1
      max_workers    = 4
      runtime_engine = "PHOTON"
      spark_version  = "12.2.x-scala2.12"
    },


    "ClusterDevelop" : {
      cluster_name   = title("${var.project.team} - Cluster - ${local.legend.tag_clusters}")
      node_type      = "Standard_D32ads_v5"
      min_workers    = 1
      max_workers    = 4
      runtime_engine = "PHOTON"
      spark_version  = "12.2.x-scala2.12"
    },


    # "ClusterDs" : {
    #   cluster_name   = title("${var.project.team} - Cluster Data Science - ${local.legend.tag_clusters}")
    #   node_type      = "Standard_L32s_v2"
    #   min_workers    = 1
    #   max_workers    = 3
    #   runtime_engine = "PHOTON"
    #   spark_version  = "12.2.x-scala2.12"
    # },




    # "AnaliseDados" : {
    #   cluster_name = "AnaliseDados"
    #   node_type    = "Standard_DS3_v2"
    #   min_workers  = 1
    #   max_workers  = 3
    #   runtime_engine = "STANDARD"
    # },

    # "BasicBatchETL" : {
    #   cluster_name   = "BasicBatchETL"
    #   node_type      = "Standard_DS3_v2"
    #   min_workers    = 1
    #   max_workers    = 2
    #   runtime_engine = "STANDARD"
    #   spark_version  = "10.4.x-cpu-ml-scala2.12"
    # },

    # "ComplexBatchETL" : {
    #   cluster_name   = "ComplexBatchETL"
    #   node_type      = "Standard_D4ads_v5"
    #   min_workers    = 1
    #   max_workers    = 8
    #   runtime_engine = "PHOTON"
    #   spark_version  = "11.3.x-scala2.12"
    # },


    # "SqlDwPHOTON" : {
    #   cluster_name   = "SqlDwPHOTON"
    #   node_type      = "Standard_D4ads_v5"
    #   min_workers    = 1
    #   max_workers    = 4
    #   runtime_engine = "PHOTON"
    #   spark_version  = "11.3.x-scala2.12"
    # },


    # "machineLearning" : {
    #   cluster_name = "machineLearning"
    #   node_type    = "Standard_DS3_v2"
    #   min_workers  = 1
    #   max_workers  = 4
    #   spark_version  = "11.3.x-scala2.12"
    #   runtime_engine = "STANDARD"
    # },

    # "Streamming" : {
    #   cluster_name = "Streamming"
    #   node_type    = "Standard_E8_v3"
    #   min_workers  = 1
    #   max_workers  = 4
    #   spark_version  = "11.3.x-scala2.12"
    #   runtime_engine = "STANDARD"
    # },

  }
}


#----------------------------------------------------------------------------------------------------------------
# Create clusters on databricks workspace
#----------------------------------------------------------------------------------------------------------------

resource "databricks_cluster" "team" {

  for_each = local.clusters

  spark_version  = each.value.spark_version
  spark_env_vars = module.spark.common.variables
  spark_conf     = module.spark.engineering.config

  cluster_name   = each.value.cluster_name
  node_type_id   = each.value.node_type
  runtime_engine = each.value.runtime_engine

  autotermination_minutes = 15
  is_pinned               = true

  autoscale {
    min_workers = each.value.min_workers
    max_workers = each.value.max_workers
  }

  azure_attributes {
    availability       = module.spark.common.availability
    first_on_demand    = 1
    spot_bid_max_price = -1
  }

  dynamic "library" {
    for_each = module.spark.common.maven_library
    content {
      maven {
        coordinates = library.value
      }
    }
  }

  custom_tags = {
    "ResourceClass" = "Serverless"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    module.spark,
    data.azurerm_databricks_workspace.dbw,
    null_resource.obtem_token
  ]
}
