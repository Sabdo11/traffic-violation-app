# Traffic Violation using PAM

# Build and run

### Prerequisites

You will need:
  - Java 11+ installed
  - Environment variable JAVA_HOME set accordingly
  - Maven 3.8.1+ installed

### Package and Run Local
  <code>
   cd traffic-violation-service && 
   sh launch.sh clean install 
</code>

### OpenAPI (Swagger) documentation
[Specification at swagger.io](https://swagger.io/docs/specification/about/)

You can take a look at the automatically generated swagger UI - to determine all available operations exposed by the service. For easy readability, you can visualize the OpenAPI definition file using a Swagger UI tool to access the swagger UI [(https://localhost:9000/rest/api-docs/?url=https://localhost:9000/rest/server/containers/swagger.json)] after opening the swagger UI add the following URL [(https://localhost:9000/rest/server/containers/swagger.json)] to the search box and click the Explore button

![Traffic violation Swagger UI Screen Capture](/traffic-violation-kjar/global/Swagger_UI.png "Swagger UI screen Capture")


## Example Usage on Postman

Once the service is up and running we can invoke the REST endpoints and examine the logic.

### Submit a request

To make use of this application it is as simple as sending a POST request to `http://localhost:9000/rest/server/containers/traffic-violation-kjar-1_0-SNAPSHOT/dmn` with the appropriate json requests content.


Given data:

```json
{
  "model-namespace": "https://github.com/kiegroup/drools/kie-dmn/_A4BCA8B8-CF08-433F-93B2-A2598F19ECFF",
  "model-name": "Traffic Violation",
  "dmn-context": {
    "Driver": {
      "Points": 15
        }
    }
}
```
Submit the JSON object from above you should see a similar output
```json
 {
    "type": "SUCCESS",
    "msg": "OK from container 'traffic-violation-kjar-1_0-SNAPSHOT'",
    "result": {
        "dmn-evaluation-result": {
            "messages": [],
            "model-namespace": "https://github.com/kiegroup/drools/kie-dmn/_A4BCA8B8-CF08-433F-93B2-A2598F19ECFF",
            "model-name": "Traffic Violation",
            "decision-name": [],
            "dmn-context": {
                "Violation": {
                    "Type": "speed",
                    "Speed Limit": 100,
                    "Actual Speed": 135
                },
                "Driver": {
                    "Points": 15
                },
                "Fine": {
                    "Points": 7,
                    "Amount": 1000
                },
                "Should the driver be suspended?": "Yes"
            },
            "decision-results": {
                "_4055D956-1C47-479C-B3F4-BAEB61F1C929": {
                    "messages": [],
                    "decision-id": "_4055D956-1C47-479C-B3F4-BAEB61F1C929",
                    "decision-name": "Fine",
                    "result": {
                        "Points": 7,
                        "Amount": 1000
                    },
                    "status": "SUCCEEDED"
                },
                "_8A408366-D8E9-4626-ABF3-5F69AA01F880": {
                    "messages": [],
                    "decision-id": "_8A408366-D8E9-4626-ABF3-5F69AA01F880",
                    "decision-name": "Should the driver be suspended?",
                    "result": "Yes",
                    "status": "SUCCEEDED"
                }
            }
        }
    }
```
### Disabling authentication 
- To disable the security kie server auto-configuration, add
<code>
http.authorizeRequests().antMatchers("/**").permitAll().anyRequest().authenticated().and().csrf().disable();
</code> to the DefaultWebSecurityConfig.java file located under traffic-violation-service/java/com/nvs/trafficviolation/service


### To Enable the HTTPS
- Use the following link to set up the SSL for Spring Boot https://www.tutorialspoint.com/spring_boot/spring_boot_enabling_https.htm 
- After generating the self signed certificate add the certificate to traffic-violation-service/src/main/resources folder

