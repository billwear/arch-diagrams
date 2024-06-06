workspace "Analyticsv1.0"{

    model {
    
        # user persona
        user = person "User"
        targetUser = person "Data scientists, ML engineers"
        
        analytics = softwareSystem "Analytics Platform"
        juju = softwareSystem "Juju"
        snap = softwareSystem "Snapcraft"
        microk8s = softwareSystem "MicroK8s"
        ckf = element "Charmed Kubeflow" 
        dss = element "Data Science Stack" 
        mlf = element "Charmed MLflow" 
        
        # RELATIONSHIPS
        user -> analytics "Uses"
        analytics -> ckf "Provides a cloud-based scalable solution"
        analytics -> dss "Offers a ready-to-run environment"
        analytics -> mlf "Manages end-to-end machine learning lifecycle"
        analytics -> targetUser "Developed for"
        
        ckf -> microk8s "Is built on"
        dss -> microk8s "Is built on"
        dss -> mlf "Is built on"
        mlf -> microk8s "Is built on"
        
        juju -> ckf "Deploys"
        juju -> mlf "Deploys"
        snap -> dss "Builds"
    }

    views {
        systemContext analytics "SystemContext" {
            include *
            autoLayout
        }
        
        systemLandscape "AnalyticsLandscape" {
            include *
            autoLayout lr
        }

        styles {
            element "Software System" {
                metadata false
                background #1168bd
                color #ffffff
            }
            element "Person" {
                metadata false
                shape person
                background #08427b
                color #ffffff
            }
        }
    }
    
}

