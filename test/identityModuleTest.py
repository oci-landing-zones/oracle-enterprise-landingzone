#!/usr/bin/env python

import oci
from oci.config import from_file
import pytest
import sys

REGION = 'us-ashburn-1'

def get_config():
    if REGION != '':
        return {"region": REGION}
    return {}


def getAllUserCompartment(compartmentId):
    getUserTree = identity_client.list_users(compartment_id=compartmentId)
    return getUserTree.data

def checkUserInData (userOcid, allUserData):
    thisUser=[user for user in allUserData if user.id==userOcid][0]
    return "True" if thisUser else "False"

def findUserOcid(userName, allUserData):
    thisUser=[user for user in allUserData if user.name==userName][0]
    return thisUser.id

def getGroupMembershipIdComp(compartmentId,userId):
    getUserGroup = identity_client.list_user_group_memberships(
        compartment_id=compartmentId,
        user_id=userId
    )
    print (getUserGroup.data)
    return getUserGroup.data[0].group_id

def createUserComp(compartmentId,userName,userDesc,userEmail):
    create_user_response = identity_client.create_user(
    create_user_details=oci.identity.models.CreateUserDetails(
        compartment_id=compartmentId,
        name=userName,
        description=userDesc,
        email=userEmail
    ))
    return create_user_response.data.id

def deleteUser(userOcid):
    deleteUserData = identity_client.delete_user(user_id=userOcid)
    print (deleteUserData.data)
    #return getUserTree.data

def getGroupInfo(userDomainId):
    getGroupInfo = identity_client.get_group(
        group_id=userDomainId
    )
    print (getGroupInfo.data)

def getDomainInfoFromGroup(groupId):
    getDomainInfo = identity_client.get_domain(
        domain_id=groupId,
        opc_request_id="VK8CHLJIWPURR3FHDDIB"
    )
    print (getDomainInfo.data)

def listGroupCompartmentInfo(compartmentOcid):
    getGroupInfo = identity_client.list_groups(compartment_id = compartmentOcid)    
    return getGroupInfo.data

def getGroupOcidFromName (groupName, groupData):
    groupInfo=[grp for grp in groupData if grp.name==groupName][0]
    return groupInfo.id 

def listPolicyInCompartment(compartmentOcid):
    getPolicyInfo = identity_client.list_policies(compartment_id = compartmentOcid)
    return getPolicyInfo.data

def getPolicyOcidFromData(policyName, policyData):
    policyInfo = [ policy for policy in policyData if policy.name==policyName][0]
    return policyInfo.id

def policyInfoFromOcid(policyOcid):
    getPolicyInfo = identity_client.get_policy(policy_id = policyOcid)
    return getPolicyInfo.data.statements

def listUserCompartment(compartmentOcid):
    listUserData = identity_client.list_users(
        compartment_id = compartmentOcid
    )
    return listUserData.data

def getUserDetails (userOcid):
    getUserDetail = identity_client.get_user(
        user_id = userOcid
    )
    print (getUserDetail.data)

def getTenancyInfo(compartmentOcid):
    getUserDetail = identity_client.get_tenancy(
        tenancy_id = compartmentOcid
    )
    print (getUserDetail.data)


config = from_file()  

rootCompId="ocid1.tenancy.oc1..aaaaaaaaxbchsnzhdxyoewmoqiqzvltba2ri7gijhbd2z5ybpgorv7yhxeeq" # root compartment OCID


#config_with_key_file = {
#    "user": ,
#    "key_file": ,
#    "fingerprint": ,
#    "tenancy": ,
#    "region":
#}

oci.config.validate_config(config_with_key_file)
identity_client = oci.identity.IdentityClient(config)


# Identity Varible 
"""
networkProdCompartmentName     = 
networkProdGroupName           = 
networkProdPolicyName          = 
securityProdCompartmentName    =
securityProdGroupName          = 
securityProdPolicyName          = 
networkNonProdCompartmentName  =
networkNonProdGroupName        =
securityNonProdCompartmentName = 
securityNonProdGroupName       = 
breakUserName                  = 
"""

#Network Admin Test
getGroupInfoData = listGroupCompartmentInfo(rootCompId)
groupOcidNetworkProd = getGroupOcidFromName(networkProdGroupName,getGroupInfoData)
getGroupInfo(groupOcidNetworkProd)
#Verify the Policy
policyDataProd = listPolicyInCompartment(rootCompId)
policyOcidProd = getPolicyOcidFromData(networkProdPolicyName,policyData)
policyStatementProd = policyInfoFromOcid(policyOcid)
verfiyNetworkPolicy(policyStatementProd)

#Create the User Inside Network Compartment and Verify it Accessiblity to other Compartment
l4ProdNetworkOcid = getOcidFromCompName(networkProdCompartmentName)
l4ProdSecurityOcid = getOcidFromCompName(securityProdCompartmentName)
newUserNetworkOcid = createUserComp(l4ProdNetworkOcid,"UserApiNetwork","Network User Created By OCI API", "abc@email.com")
allUserSecurityUser = getAllUserCompartment(securityProdCompartmentName)
returnFlag = checkUserInData(l4ProdNetworkOcid,allUserSecurityUser)
if returnFlag == "True":
    deleteUser(newUserNetworkOcid)
    sys.exit("Error::Created user Inside Network Compartment has access to security Comp")
deleteUser(newUserNetworkOcid)


#Security Admin Test
groupOcidSecurityProd = getGroupOcidFromName(securityProdGroupName,getGroupInfoData)
getGroupInfo(groupOcidSecurityProd)

#Verify the Policy
policyOcidProdSecurity      = getPolicyOcidFromData(securityProdPolicyName,policyData)
policyStatementProdSecurity = policyInfoFromOcid(policyOcid)
verfiySecurityPolicy(policyStatementProd)

#Create the User Inside Security Compartment and Verify it Accessiblity to other Compartment

newUserSecurityOcid = createUserComp(l4ProdSecurityOcid,"UserApiSecurity","Security User Created By OCI API", "abc@email.com")
allUserNetworkUser = getAllUserCompartment(networkProdCompartmentName)
returnFlag = checkUserInData(newUserSecurityOcid,allUserNetworkUser)
if returnFlag == "True":
    deleteUser(newUserSecurityOcid)
    sys.exit("Error::Created user Inside Security Compartment has access to Network Comp")
deleteUser(newUserSecurityOcid)


#Verify Break User Name

allUserData = listUserCompartment(rootCompId)
breakUserOcid = findUserOcid(breakUserName, allUserData)
getUserDetails(breakUserOcid)

