import oci
from oci.config import from_file
import pytest
import sys

# Get Ocid From the Compartment Name
def getOcidFromCompName (compartmentName, compartmentData):
    thiscompartment=[comp for comp in compartmentData if comp.name==compartmentName][0]
    return thiscompartment.id    

# Get all the Children Compartment Inside the Compartment 
def getCompTree (compartmentId):
    list_compartments_response = identity_client.list_compartments(
    compartment_id=compartmentId,
    compartment_id_in_subtree=True)
    return list_compartments_response.data

# Check the Compartment Name Exist the Compartment Tree 
def checkCompInData (compartmentName, compartmentData):
    thiscompartment=[comp for comp in compartmentData if comp.name==compartmentName][0]
    return "True" if thiscompartment else "False"

# Create Compartment
def createCompartment (rootCompartmentOcid, compartmentName, compartmentDescription):
    createCompartmentOcidResponse = identity_client.CreateCompartmentDetails(
        compartment_id = rootCompartmentOcid,
        name = compartmentName,
        description = compartmentDescription
    )
    return createCompartmentOcidResponse.data.id 

# Delete Compartment
def deleteCompartment (compartmentOcid):
    deleteCompartmentOcidResponse = identity_client.delete_compartment(
        compartment_id=compartmentId
    )

def checkL1CompName:
    compartmentlist = getCompTree(rootCompId)
    returnFlag = checkCompInData("L1CompName", compartmentlist)
    if returnFlag:
        print ("Found L1 Compartment Inside the Root compartment")
    else:
        print ("Not Found L1 Compartment Inside the Root compartment")
        sys.exit() 

def checkL2ProdCompName:
    compartmentlist = getCompTree(l1OcidValue)
    returnFlag = checkCompInData("L2CompProdName", compartmentlist)
    if returnFlag:
        print ("Found L2 Prod Compartment Inside the L1 compartment")
    else:
        print ("Not Found L2 Prod Compartment Inside the L1 compartment")
        sys.exit()

def checkL2NonProdCompName:   
    compartmentlist = getCompTree(l1OcidValue)
    returnFlag = checkCompInData("L2CompNonProdName", compartmentlist)
    if returnFlag:
        print ("Found L2 Non Prod Compartment Inside the L1 compartment")
    else:
        print ("Not Found L2 Non Prod Compartment Inside the L1 compartment")
        sys.exit()

def checkL2Prodcheck(compartmentName):
    compartmentlist = getCompTree(l2ProdOcidValue)
    returnFlag = checkCompInData(compartmentName, compartmentlist)
    if returnFlag:
        print ("Found New L3 Network Compartment Inside the L2 Prod compartment")
    else:
        print ("Not Found New L3 Network Compartment Inside the L2 Prod compartment")
        sys.exit()

def checkCompInsideProdEnv:
    compartmentlist = getCompTree(l2ProdOcidValue)
    returnFlag = checkCompInData("L3CompNameProd", compartmentlist)
    if returnFlag:
        print ("Found L3 Compartment Inside the L2 Prod compartment")
    else:
        print ("Not Found L3 Compartment Inside the L2 Prod compartment")
        sys.exit()

    returnFlag = checkCompInData("L4CompNameProd", compartmentlist)
    if returnFlag:
        print ("Found L4 Compartment Inside the L2 Prod compartment")
    else:
        print ("Not Found L4 Compartment Inside the L2 Prod compartment")
        sys.exit()

def checkCompInsideNonProdEnv:
    compartmentlist = getCompTree(l2NonProdOcidValue)
    returnFlag = checkCompInData("L3CompNameNonProd", compartmentlist)
    if returnFlag:
        print ("Found L3 Compartment Inside the L2 Non Prod compartment")
    else:
        print ("Not Found L3 Compartment Inside the L2 Non Prod compartment")
        sys.exit()

    returnFlag = checkCompInData("L4CompNameNonProd", compartmentlist)
    
    if returnFlag:
        print ("Found L4 Compartment Inside the L2 Non Prod compartment")
    else:
        print ("Not Found L4 Compartment Inside the L2 Non Prod compartment")
        sys.exit()

# Config file is read from user's home location i.e., ~/.oci/config
config = from_file()  

rootCompId="ocid1.tenancy.oc1..aaaaaaaaxbchsnzhdxyoewmoqiqzvltba2ri7gijhbd2z5ybpgorv7yhxeeq" # root compartment OCID

#L1CompName         = 
#L2CompProdName     =
#L2CompNonProdName 
#L3CompNameProdSharedInfra= 
#L4CompNameProdNetwork =
#L4CompNameProdSecurity = 
#L3CompNameNonProd = 
#L4CompNameNonProdNetwork =
#L4CompNameNonProdSecurity =  

# Please fill up the following Information
#config_with_key_file = {
#    "user": ,
#    "key_file": ,
#    "fingerprint": ,
#    "tenancy": ,
#    "region": 
#}

oci.config.validate_config(config_with_key_file)
identity_client = oci.identity.IdentityClient(config)

# Get the list of compartments including child compartments except root compartment
compartmentlist = getCompTree(rootCompId)

# Get the OCID From the Compartment Name
l1OcidValue     = getOcidFromCompName(L1CompName)
l2ProdOcidValue = getOcidFromCompName(L2CompProdName)

l2NonProdOcidValue = getOcidFromCompName(L2CompNonProdName)
l4ProdNetworkOcid = getOcidFromCompName(L4CompNameProdNetwork)
l2ProdSharedInfraOcid = getOcidFromCompName(L3CompNameProdSharedInfra)

# Check the Compartment Module Usecase
checkL1CompName()
checkL2ProdCompName()
checkL2NonProdCompName()
checkCompInsideProdEnv()
checkCompInsideNonProdEnv()

# LANZ-902 : Delete the previous compartment and create new with different Name 

deleteCompartment(l4ProdNetworkOcid)
newL3NetworkCompName = "L3ProdSharedNetwork"
newl4ProdNetworkOcid = createCompartment(l2ProdSharedInfraOcid, newL3NetworkCompName, "L3 Prod Shared Network Compartment")
checkL2Prodcheck(newL3NetworkCompName)





