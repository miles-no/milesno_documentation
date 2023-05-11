workspace {
    !constant https "HTTPS"
    !constant rest  "JSON/HTTPS"

    model {
        user = person "User" "Potential or existing customer of Miles, potential candidate, or employee of miles"
        milesno = softwareSystem "Miles.no" "Allows users to view information about Miles and it's consultants, and projects" {
            mileswp = container "Miles.no wordpress" "Delivers static and dynamic content to the browser" "Wordpress"
            limes = container "Limes" "Provides integration to cvpartner and simployer with hot cache" "Java and Quarkus"
        }
        cvpartner = softwareSystem "cvpartner" "System for making and managing consultant cvs" {
            tags "secondary"
        }
        simployer = softwareSystem "Simployer" "HR-system for Miles" {
            tags "secondary"
        }
        s3 = softwareSystem "AWS S3" "cvpartner's image hosting service" {
            tags "secondary"
        }

        // system context
        user -> milesno "Views miles.no webpage(s) with browser"
        milesno -> cvpartner "Gets list of consultants with image urls"
        milesno -> simployer "Gets employment details of consultants"
        milesno -> s3 "Gets images of consultants"
        user -> s3 "Gets images of consultants"

        // container context
        user -> mileswp "Visits miles.no" "${https}"
        mileswp -> limes "Gets list of consultants" "${rest}"
        limes -> cvpartner "Makes API calls to" "${rest}"
        limes -> simployer "Makes API calls to" "${rest}"

    }

    views {
        systemContext milesno "milesno-system-view" {
            include *
        }

        container milesno "milesno-container-view" {
            include *
        }

        theme default

        styles {
            element "secondary" {
                background #aaaaaa
            }
        }
    }
}