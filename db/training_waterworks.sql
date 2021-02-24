-- MySQL dump 10.13  Distrib 5.5.59, for Win64 (AMD64)
--
-- Host: localhost    Database: training_waterworks
-- ------------------------------------------------------
-- Server version	5.5.59

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `training_waterworks`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `training_waterworks` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `training_waterworks`;

--
-- Table structure for table `sys_email_queue`
--

DROP TABLE IF EXISTS `sys_email_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_email_queue` (
  `objid` varchar(50) NOT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `state` int(1) DEFAULT NULL,
  `reportid` varchar(50) DEFAULT NULL,
  `dtsent` datetime DEFAULT NULL,
  `to` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` mediumtext,
  `errmsg` varchar(255) DEFAULT NULL,
  `connection` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_email_queue`
--

LOCK TABLES `sys_email_queue` WRITE;
/*!40000 ALTER TABLE `sys_email_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_email_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_email_template`
--

DROP TABLE IF EXISTS `sys_email_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_email_template` (
  `objid` varchar(50) NOT NULL,
  `message` mediumtext,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_email_template`
--

LOCK TABLES `sys_email_template` WRITE;
/*!40000 ALTER TABLE `sys_email_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_email_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `name` varchar(50) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES ('ADMIN','WATERWORKS'),('APPROVER','WATERWORKS'),('BILLING','WATERWORKS BILLING'),('MASTER','WATERWORKS MASTER'),('READER','WATERWORKS READER'),('REPORT','WATERWORKS REPORT'),('RULE_AUTHOR','WATERWORKS RULE_AUTHOR'),('SHARED','WATERWORKS SHARED');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_permission`
--

DROP TABLE IF EXISTS `sys_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_permission` (
  `objid` varchar(100) NOT NULL,
  `role` varchar(50) DEFAULT NULL,
  `object` varchar(25) DEFAULT NULL,
  `permission` varchar(25) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_sys_role_permission_role` (`role`),
  CONSTRAINT `fk_sys_role_permission_role` FOREIGN KEY (`role`) REFERENCES `sys_role` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_permission`
--

LOCK TABLES `sys_role_permission` WRITE;
/*!40000 ALTER TABLE `sys_role_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule`
--

DROP TABLE IF EXISTS `sys_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(25) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `ruleset` varchar(50) NOT NULL,
  `rulegroup` varchar(50) DEFAULT NULL,
  `title` varchar(250) DEFAULT NULL,
  `description` longtext,
  `salience` int(11) DEFAULT NULL,
  `effectivefrom` date DEFAULT NULL,
  `effectiveto` date DEFAULT NULL,
  `dtfiled` datetime DEFAULT NULL,
  `user_objid` varchar(50) DEFAULT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `noloop` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `ix_rulegroup_ruleset` (`rulegroup`,`ruleset`) USING BTREE,
  KEY `ix_ruleset` (`ruleset`) USING BTREE,
  CONSTRAINT `fk_sys_rule_rulegroup_ruleset` FOREIGN KEY (`rulegroup`, `ruleset`) REFERENCES `sys_rulegroup` (`name`, `ruleset`),
  CONSTRAINT `fk_sys_rule_ruleset` FOREIGN KEY (`ruleset`) REFERENCES `sys_ruleset` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule`
--

LOCK TABLES `sys_rule` WRITE;
/*!40000 ALTER TABLE `sys_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_action`
--

DROP TABLE IF EXISTS `sys_rule_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_action` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `actiondef_objid` varchar(50) DEFAULT NULL,
  `actiondef_name` varchar(50) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `ix_parentid` (`parentid`) USING BTREE,
  KEY `ix_actiondef_objid` (`actiondef_objid`) USING BTREE,
  CONSTRAINT `fk_sys_rule_action_actiondef_objid` FOREIGN KEY (`actiondef_objid`) REFERENCES `sys_rule_actiondef` (`objid`),
  CONSTRAINT `fk_sys_rule_action_parentid` FOREIGN KEY (`parentid`) REFERENCES `sys_rule` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_action`
--

LOCK TABLES `sys_rule_action` WRITE;
/*!40000 ALTER TABLE `sys_rule_action` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_rule_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_action_param`
--

DROP TABLE IF EXISTS `sys_rule_action_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_action_param` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `actiondefparam_objid` varchar(100) DEFAULT NULL,
  `stringvalue` varchar(255) DEFAULT NULL,
  `booleanvalue` int(11) DEFAULT NULL,
  `var_objid` varchar(50) DEFAULT NULL,
  `var_name` varchar(50) DEFAULT NULL,
  `expr` longtext,
  `exprtype` varchar(25) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `obj_key` varchar(50) DEFAULT NULL,
  `obj_value` varchar(255) DEFAULT NULL,
  `listvalue` longtext,
  `lov` varchar(50) DEFAULT NULL,
  `rangeoption` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `ix_parentid` (`parentid`) USING BTREE,
  KEY `ix_var_objid` (`var_objid`) USING BTREE,
  KEY `ix_actiondefparam_objid` (`actiondefparam_objid`) USING BTREE,
  CONSTRAINT `fk_sys_rule_action_param_actiondefparam_objid` FOREIGN KEY (`actiondefparam_objid`) REFERENCES `sys_rule_actiondef_param` (`objid`),
  CONSTRAINT `fk_sys_rule_action_param_parentid` FOREIGN KEY (`parentid`) REFERENCES `sys_rule_action` (`objid`),
  CONSTRAINT `fk_sys_rule_action_param_var_objid` FOREIGN KEY (`var_objid`) REFERENCES `sys_rule_condition_var` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_action_param`
--

LOCK TABLES `sys_rule_action_param` WRITE;
/*!40000 ALTER TABLE `sys_rule_action_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_rule_action_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_actiondef`
--

DROP TABLE IF EXISTS `sys_rule_actiondef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_actiondef` (
  `objid` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(250) DEFAULT NULL,
  `sortorder` int(11) DEFAULT NULL,
  `actionname` varchar(50) DEFAULT NULL,
  `domain` varchar(50) DEFAULT NULL,
  `actionclass` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_actiondef`
--

LOCK TABLES `sys_rule_actiondef` WRITE;
/*!40000 ALTER TABLE `sys_rule_actiondef` DISABLE KEYS */;
INSERT INTO `sys_rule_actiondef` VALUES ('enterprise.actions.AddRequirement','add-requirement','Add Requirement',2,'add-requirement','enterprise','enterprise.actions.AddRequirement'),('enterprise.actions.PrintTest','print-test','Print Test',1,'print-test','ENTERPRISE','enterprise.actions.PrintTest'),('enterprise.actions.ThrowException','throw-exeception','Throw Exception',1,'throw-exeception','ENTERPRISE','enterprise.actions.ThrowException'),('treasury.actions.AddCreditBillItem','add-credit-billitem','Add Credit Bill Item',2,'add-credit-billitem','TREASURY','treasury.actions.AddCreditBillItem'),('treasury.actions.AddDiscountItem','add-discount-item','Add Discount',3,'add-discount-item','TREASURY','treasury.actions.AddDiscountItem'),('treasury.actions.AddVarInteger','add-var-integer','Add Var Integer',1,'add-var-integer','TREASURY','treasury.actions.AddVarInteger'),('treasury.actions.ApplyPayment','apply-payment','Apply Payment',5,'apply-payment','TREASURY','treasury.actions.ApplyPayment'),('treasury.actions.ComputeFee','compute-fee','Compute Fee',0,'compute-fee','treasury','treasury.actions.ComputeFee'),('treasury.actions.SetBillItemAccount','set-billitem-account','Set Bill Item Account',4,'set-billitem-account','TREASURY','treasury.actions.SetBillItemAccount'),('treasury.actions.SetBillItemProperty','set-billitem-property','Set BillItem Property Value',10,'set-billitem-property','TREASURY','treasury.actions.SetBillItemProperty'),('waterworks.actions.AddRecurringWaterBillItem','add-recurring-waterbillitem','Add Recurring Water Bill Item',0,'add-recurring-waterbillitem','waterworks','waterworks.actions.AddRecurringWaterBillItem'),('waterworks.actions.AddWaterBillItem','add-waterbillitem','Add Water Bill Item',0,'add-waterbillitem','waterworks','waterworks.actions.AddWaterBillItem'),('waterworks.actions.ComputeConsumption','compute-consumption','Compute Consumption',0,'compute-consumption','waterworks','waterworks.actions.ComputeConsumption'),('waterworks.actions.SetWaterBillingPeriod','set-waterworks-billing-period','Set Waterworks Billing Period',1,'set-waterworks-billing-period','WATERWORKS','waterworks.actions.SetWaterBillingPeriod'),('waterworks.actions.SetWaterConsumptionProperty','set-waterconsumpotion-property','Set Water Consumption Property Value',10,'set-waterconsumpotion-property','WATERWORKS','waterworks.actions.SetWaterConsumptionProperty');
/*!40000 ALTER TABLE `sys_rule_actiondef` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_actiondef_param`
--

DROP TABLE IF EXISTS `sys_rule_actiondef_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_actiondef_param` (
  `objid` varchar(100) NOT NULL DEFAULT '',
  `parentid` varchar(50) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `sortorder` int(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `datatype` varchar(50) DEFAULT NULL,
  `handler` varchar(50) DEFAULT NULL,
  `lookuphandler` varchar(50) DEFAULT NULL,
  `lookupkey` varchar(50) DEFAULT NULL,
  `lookupvalue` varchar(50) DEFAULT NULL,
  `vardatatype` varchar(50) DEFAULT NULL,
  `lovname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `ix_parentid` (`parentid`) USING BTREE,
  CONSTRAINT `fk_sys_rule_actiondef_param_parentid` FOREIGN KEY (`parentid`) REFERENCES `sys_rule_actiondef` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_actiondef_param`
--

LOCK TABLES `sys_rule_actiondef_param` WRITE;
/*!40000 ALTER TABLE `sys_rule_actiondef_param` DISABLE KEYS */;
INSERT INTO `sys_rule_actiondef_param` VALUES ('enterprise.actions.AddRequirement.message','enterprise.actions.AddRequirement','message',2,'Message',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('enterprise.actions.AddRequirement.reqtype','enterprise.actions.AddRequirement','reqtype',1,'Requirement Type',NULL,'lookup','sys_requirement_type:lookup','code','title','string',NULL),('enterprise.actions.AddRequirement.required','enterprise.actions.AddRequirement','required',4,'Required','boolean','boolean',NULL,NULL,NULL,'boolean',NULL),('enterprise.actions.AddRequirement.sortorder','enterprise.actions.AddRequirement','sortorder',3,'Sort Order','string','string',NULL,NULL,NULL,'string',NULL),('enterprise.actions.PrintTest.message','enterprise.actions.PrintTest','message',1,'Message',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('enterprise.actions.ThrowException.msg','enterprise.actions.ThrowException','msg',1,'Message',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.AddCreditBillItem.account','treasury.actions.AddCreditBillItem','account',1,'Account',NULL,'lookup','revenueitem:lookup','objid','title',NULL,NULL),('treasury.actions.AddCreditBillItem.amount','treasury.actions.AddCreditBillItem','amount',2,'Amount',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.AddCreditBillItem.billcode','treasury.actions.AddCreditBillItem','billcode',1,'Bill code',NULL,'lookup','waterworks_itemaccount:lookup','objid','title','string',NULL),('treasury.actions.AddCreditBillItem.reftype','treasury.actions.AddCreditBillItem','reftype',3,'Ref Type','string','string',NULL,NULL,NULL,'string',NULL),('treasury.actions.AddDiscountItem.account','treasury.actions.AddDiscountItem','account',4,'Account',NULL,'lookup','revenueitem:lookup','objid','title',NULL,NULL),('treasury.actions.AddDiscountItem.amount','treasury.actions.AddDiscountItem','amount',2,'Amount',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.AddDiscountItem.billcode','treasury.actions.AddDiscountItem','billcode',3,'Billcode',NULL,'lookup','waterworks_itemaccount:lookup','objid','title','string',NULL),('treasury.actions.AddDiscountItem.billitem','treasury.actions.AddDiscountItem','billitem',1,'Bill Item',NULL,'var',NULL,NULL,NULL,'treasury.facts.AbstractBillItem',NULL),('treasury.actions.AddVarInteger.tag','treasury.actions.AddVarInteger','tag',2,'Tag','string','string',NULL,NULL,NULL,'string',NULL),('treasury.actions.AddVarInteger.value','treasury.actions.AddVarInteger','value',1,'Value',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.ApplyPayment.payment','treasury.actions.ApplyPayment','payment',1,'Payment',NULL,'var',NULL,NULL,NULL,'treasury.facts.Payment',NULL),('treasury.actions.ComputeFee.account','treasury.actions.ComputeFee','account',1,'Account',NULL,'lookup','revenueitem:lookup','objid','title',NULL,NULL),('treasury.actions.ComputeFee.amount','treasury.actions.ComputeFee','amount',2,'Amount',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.ComputeFee.remarks','treasury.actions.ComputeFee','remarks',3,'Remarks',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.SetBillItemAccount.account','treasury.actions.SetBillItemAccount','account',2,'Account',NULL,'lookup','revenueitem:lookup','objid','title',NULL,NULL),('treasury.actions.SetBillItemAccount.billcode','treasury.actions.SetBillItemAccount','billcode',3,'Billcode',NULL,'lookup','waterworks_itemaccount:lookup','objid','title','string',NULL),('treasury.actions.SetBillItemAccount.billitem','treasury.actions.SetBillItemAccount','billitem',1,'Bill Item',NULL,'var',NULL,NULL,NULL,'treasury.facts.AbstractBillItem',NULL),('treasury.actions.SetBillItemProperty.billitem','treasury.actions.SetBillItemProperty','billitem',1,'Bill Item',NULL,'var',NULL,NULL,NULL,'treasury.facts.AbstractBillItem',NULL),('treasury.actions.SetBillItemProperty.fieldname','treasury.actions.SetBillItemProperty','fieldname',2,'Property Field Name',NULL,'fieldlist',NULL,'billitem',NULL,NULL,NULL),('treasury.actions.SetBillItemProperty.value','treasury.actions.SetBillItemProperty','value',3,'Value',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('waterworks.actions.AddRecurringWaterBillItem.amount','waterworks.actions.AddRecurringWaterBillItem','amount',3,'Amount',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('waterworks.actions.AddRecurringWaterBillItem.month','waterworks.actions.AddRecurringWaterBillItem','month',2,'Month',NULL,'var',NULL,NULL,NULL,'integer',NULL),('waterworks.actions.AddRecurringWaterBillItem.refitem','waterworks.actions.AddRecurringWaterBillItem','refitem',4,'Reference Item',NULL,'var',NULL,NULL,NULL,'waterworks.facts.WaterBillRecurringFee',NULL),('waterworks.actions.AddRecurringWaterBillItem.year','waterworks.actions.AddRecurringWaterBillItem','year',1,'Year',NULL,'var',NULL,NULL,NULL,'integer',NULL),('waterworks.actions.AddWaterBillItem.amount','waterworks.actions.AddWaterBillItem','amount',3,'Amount',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('waterworks.actions.AddWaterBillItem.billcode','waterworks.actions.AddWaterBillItem','billcode',4,'Bill code',NULL,'lookup','waterworks_itemaccount:lookup','objid','title','string',NULL),('waterworks.actions.AddWaterBillItem.month','waterworks.actions.AddWaterBillItem','month',2,'Month',NULL,'var',NULL,NULL,NULL,'integer',NULL),('waterworks.actions.AddWaterBillItem.year','waterworks.actions.AddWaterBillItem','year',1,'Year',NULL,'var',NULL,NULL,NULL,'integer',NULL),('waterworks.actions.ComputeConsumption.amount','waterworks.actions.ComputeConsumption','amount',1,'Amount',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('waterworks.actions.ComputeConsumption.ref','waterworks.actions.ComputeConsumption','ref',2,'Ref',NULL,'var',NULL,NULL,NULL,'waterworks.facts.WaterConsumption',NULL),('waterworks.actions.SetWaterBillingPeriod.billdate','waterworks.actions.SetWaterBillingPeriod','billdate',6,'Bill Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('waterworks.actions.SetWaterBillingPeriod.billexpirydate','waterworks.actions.SetWaterBillingPeriod','billexpirydate',10,'Bill Expiry Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('waterworks.actions.SetWaterBillingPeriod.billingenddate','waterworks.actions.SetWaterBillingPeriod','billingenddate',7,'Billing End Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('waterworks.actions.SetWaterBillingPeriod.billingperiod','waterworks.actions.SetWaterBillingPeriod','billingperiod',1,'Billing Period',NULL,'var',NULL,NULL,NULL,'waterworks.facts.WaterBillingPeriod',NULL),('waterworks.actions.SetWaterBillingPeriod.discdate','waterworks.actions.SetWaterBillingPeriod','discdate',8,'Discount Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('waterworks.actions.SetWaterBillingPeriod.duedate','waterworks.actions.SetWaterBillingPeriod','duedate',9,'Due Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('waterworks.actions.SetWaterBillingPeriod.fromdate','waterworks.actions.SetWaterBillingPeriod','fromdate',2,'From Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('waterworks.actions.SetWaterBillingPeriod.readingdate','waterworks.actions.SetWaterBillingPeriod','readingdate',4,'Reading Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('waterworks.actions.SetWaterBillingPeriod.readingenddate','waterworks.actions.SetWaterBillingPeriod','readingenddate',5,'Reading End Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('waterworks.actions.SetWaterBillingPeriod.todate','waterworks.actions.SetWaterBillingPeriod','todate',3,'To Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('waterworks.actions.SetWaterConsumptionProperty.fieldname','waterworks.actions.SetWaterConsumptionProperty','fieldname',2,'Property Field Name','string','string',NULL,'waterworks.facts.WaterConsumption',NULL,'string',NULL),('waterworks.actions.SetWaterConsumptionProperty.item','waterworks.actions.SetWaterConsumptionProperty','item',1,'Item',NULL,'var',NULL,NULL,NULL,'waterworks.facts.WaterConsumption',NULL),('waterworks.actions.SetWaterConsumptionProperty.value','waterworks.actions.SetWaterConsumptionProperty','value',3,'Value',NULL,'expression',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `sys_rule_actiondef_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_condition`
--

DROP TABLE IF EXISTS `sys_rule_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_condition` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `fact_name` varchar(50) DEFAULT NULL,
  `fact_objid` varchar(50) DEFAULT NULL,
  `varname` varchar(50) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `ruletext` longtext,
  `displaytext` longtext,
  `dynamic_datatype` varchar(50) DEFAULT NULL,
  `dynamic_key` varchar(50) DEFAULT NULL,
  `dynamic_value` varchar(50) DEFAULT NULL,
  `notexist` int(11) NOT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `ix_fact_objid` (`fact_objid`) USING BTREE,
  KEY `ix_parentid` (`parentid`) USING BTREE,
  CONSTRAINT `fk_sys_rule_condition_fact_objid` FOREIGN KEY (`fact_objid`) REFERENCES `sys_rule_fact` (`objid`),
  CONSTRAINT `fk_sys_rule_condition_parentid` FOREIGN KEY (`parentid`) REFERENCES `sys_rule` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_condition`
--

LOCK TABLES `sys_rule_condition` WRITE;
/*!40000 ALTER TABLE `sys_rule_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_rule_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_condition_constraint`
--

DROP TABLE IF EXISTS `sys_rule_condition_constraint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_condition_constraint` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `field_objid` varchar(100) DEFAULT NULL,
  `fieldname` varchar(50) DEFAULT NULL,
  `varname` varchar(50) DEFAULT NULL,
  `operator_caption` varchar(50) DEFAULT NULL,
  `operator_symbol` varchar(50) DEFAULT NULL,
  `usevar` int(11) DEFAULT NULL,
  `var_objid` varchar(50) DEFAULT NULL,
  `var_name` varchar(50) DEFAULT NULL,
  `decimalvalue` decimal(16,2) DEFAULT NULL,
  `intvalue` int(11) DEFAULT NULL,
  `stringvalue` varchar(255) DEFAULT NULL,
  `listvalue` longtext,
  `datevalue` date DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `ix_parentid` (`parentid`) USING BTREE,
  KEY `ix_var_objid` (`var_objid`) USING BTREE,
  KEY `ix_field_objid` (`field_objid`) USING BTREE,
  CONSTRAINT `fk_sys_rule_condition_constraint_field_objid` FOREIGN KEY (`field_objid`) REFERENCES `sys_rule_fact_field` (`objid`),
  CONSTRAINT `fk_sys_rule_condition_constraint_parentid` FOREIGN KEY (`parentid`) REFERENCES `sys_rule_condition` (`objid`),
  CONSTRAINT `fk_sys_rule_condition_constraint_var_objid` FOREIGN KEY (`var_objid`) REFERENCES `sys_rule_condition_var` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_condition_constraint`
--

LOCK TABLES `sys_rule_condition_constraint` WRITE;
/*!40000 ALTER TABLE `sys_rule_condition_constraint` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_rule_condition_constraint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_condition_var`
--

DROP TABLE IF EXISTS `sys_rule_condition_var`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_condition_var` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `ruleid` varchar(50) DEFAULT NULL,
  `varname` varchar(50) DEFAULT NULL,
  `datatype` varchar(50) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `ix_parentid` (`parentid`) USING BTREE,
  CONSTRAINT `fk_sys_rule_condition_var_parentid` FOREIGN KEY (`parentid`) REFERENCES `sys_rule_condition` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_condition_var`
--

LOCK TABLES `sys_rule_condition_var` WRITE;
/*!40000 ALTER TABLE `sys_rule_condition_var` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_rule_condition_var` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_deployed`
--

DROP TABLE IF EXISTS `sys_rule_deployed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_deployed` (
  `objid` varchar(50) NOT NULL,
  `ruletext` longtext,
  PRIMARY KEY (`objid`) USING BTREE,
  CONSTRAINT `fk_sys_rule_deployed_objid` FOREIGN KEY (`objid`) REFERENCES `sys_rule` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_deployed`
--

LOCK TABLES `sys_rule_deployed` WRITE;
/*!40000 ALTER TABLE `sys_rule_deployed` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_rule_deployed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_fact`
--

DROP TABLE IF EXISTS `sys_rule_fact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_fact` (
  `objid` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(160) DEFAULT NULL,
  `factclass` varchar(50) DEFAULT NULL,
  `sortorder` int(11) DEFAULT NULL,
  `handler` varchar(50) DEFAULT NULL,
  `defaultvarname` varchar(25) DEFAULT NULL,
  `dynamic` int(11) DEFAULT NULL,
  `lookuphandler` varchar(50) DEFAULT NULL,
  `lookupkey` varchar(50) DEFAULT NULL,
  `lookupvalue` varchar(50) DEFAULT NULL,
  `lookupdatatype` varchar(50) DEFAULT NULL,
  `dynamicfieldname` varchar(50) DEFAULT NULL,
  `builtinconstraints` varchar(50) DEFAULT NULL,
  `domain` varchar(50) DEFAULT NULL,
  `factsuperclass` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_fact`
--

LOCK TABLES `sys_rule_fact` WRITE;
/*!40000 ALTER TABLE `sys_rule_fact` DISABLE KEYS */;
INSERT INTO `sys_rule_fact` VALUES ('com.rameses.rules.common.CurrentDate','com.rameses.rules.common.CurrentDate','Current Date','com.rameses.rules.common.CurrentDate',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SYSTEM',NULL),('treasury.facts.BillItem','treasury.facts.BillItem','Bill Item','treasury.facts.BillItem',1,NULL,'BILLITEM',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY','treasury.facts.AbstractBillItem'),('treasury.facts.Deposit','treasury.facts.Deposit','Deposit','treasury.facts.Deposit',5,NULL,'PMT',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY',NULL),('treasury.facts.ExcessPayment','treasury.facts.ExcessPayment','Excess Payment','treasury.facts.ExcessPayment',5,NULL,'EXPMT',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY',NULL),('treasury.facts.HolidayFact','treasury.facts.HolidayFact','Holidays','treasury.facts.HolidayFact',1,NULL,'HOLIDAYS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY',NULL),('treasury.facts.Payment','treasury.facts.Payment','Payment','treasury.facts.Payment',5,NULL,'PMT',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY',NULL),('treasury.facts.Requirement','treasury.facts.Requirement','Requirement','treasury.facts.Requirement',2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'treasury',NULL),('treasury.facts.TransactionDate','treasury.facts.TransactionDate','Transaction Date','treasury.facts.TransactionDate',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY',NULL),('treasury.facts.VarInteger','treasury.facts.VarInteger','Var Integer','treasury.facts.VarInteger',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY',NULL),('waterworks.facts.WaterAccount','waterworks.facts.WaterAccount','Water Account','waterworks.facts.WaterAccount',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'waterworks',NULL),('waterworks.facts.WaterBill','waterworks.facts.WaterBill','Water Bill','waterworks.facts.WaterBill',1,NULL,'WB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WATERWORKS',NULL),('waterworks.facts.WaterBillingPeriod','waterworks.facts.WaterBillingPeriod','Water Billing Period','waterworks.facts.WaterBillingPeriod',1,NULL,'BILPRD',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY',NULL),('waterworks.facts.WaterBillItem','waterworks.facts.WaterBillItem','Water Bill Item','waterworks.facts.WaterBillItem',0,NULL,'WBI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WATERWORKS','treasury.facts.AbstractBillItem'),('waterworks.facts.WaterBillRecurringFee','waterworks.facts.WaterBillRecurringFee','Waterworks Bill Recurring Fee','waterworks.facts.WaterBillRecurringFee',1,NULL,'WBR',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WATERWORKS',NULL),('waterworks.facts.WaterConsumption','waterworks.facts.WaterConsumption','Water Consumption','waterworks.facts.WaterConsumption',1,NULL,'WC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WATERWORKS',NULL),('waterworks.facts.WaterMeter','waterworks.facts.WaterMeter','Water Meter','waterworks.facts.WaterMeter',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WATERWORKS',NULL),('waterworks.facts.WaterScheduleGroup','waterworks.facts.WaterScheduleGroup','Water Schedule Group','waterworks.facts.WaterScheduleGroup',1,NULL,'WBS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WATERWORKS',NULL),('waterworks.facts.WaterworksAttribute','waterworks.facts.WaterworksAttribute','Waterworks Attribute','waterworks.facts.WaterworksAttribute',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WATERWORKS',NULL);
/*!40000 ALTER TABLE `sys_rule_fact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_fact_field`
--

DROP TABLE IF EXISTS `sys_rule_fact_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_fact_field` (
  `objid` varchar(100) NOT NULL DEFAULT '',
  `parentid` varchar(50) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(160) DEFAULT NULL,
  `datatype` varchar(50) DEFAULT NULL,
  `sortorder` int(11) DEFAULT NULL,
  `handler` varchar(50) DEFAULT NULL,
  `lookuphandler` varchar(50) DEFAULT NULL,
  `lookupkey` varchar(50) DEFAULT NULL,
  `lookupvalue` varchar(50) DEFAULT NULL,
  `lookupdatatype` varchar(50) DEFAULT NULL,
  `multivalued` int(11) DEFAULT NULL,
  `required` int(11) DEFAULT NULL,
  `vardatatype` varchar(50) DEFAULT NULL,
  `lovname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `ix_parentid` (`parentid`) USING BTREE,
  CONSTRAINT `fk_sys_rule_fact_field_parentid` FOREIGN KEY (`parentid`) REFERENCES `sys_rule_fact` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_fact_field`
--

LOCK TABLES `sys_rule_fact_field` WRITE;
/*!40000 ALTER TABLE `sys_rule_fact_field` DISABLE KEYS */;
INSERT INTO `sys_rule_fact_field` VALUES ('com.rameses.rules.common.CurrentDate.date','com.rameses.rules.common.CurrentDate','date','Date','date',4,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('com.rameses.rules.common.CurrentDate.day','com.rameses.rules.common.CurrentDate','day','Day','integer',5,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('com.rameses.rules.common.CurrentDate.month','com.rameses.rules.common.CurrentDate','month','Month','integer',3,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('com.rameses.rules.common.CurrentDate.qtr','com.rameses.rules.common.CurrentDate','qtr','Qtr','integer',1,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('com.rameses.rules.common.CurrentDate.year','com.rameses.rules.common.CurrentDate','year','Year','integer',2,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('treasury.facts.BillItem.account','treasury.facts.BillItem','account','Account','string',3,'lookup','revenueitem:lookup','objid','title',NULL,NULL,NULL,'object',NULL),('treasury.facts.BillItem.account.objid','treasury.facts.BillItem','account.objid','Account','string',2,'lookup','revenueitem:lookup','objid','title',NULL,NULL,NULL,'string',NULL),('treasury.facts.BillItem.amount','treasury.facts.BillItem','amount','Amount','decimal',1,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('treasury.facts.BillItem.billcode','treasury.facts.BillItem','billcode','Bill code','string',16,'lookup','waterworks_itemaccount:lookup','objid','title',NULL,NULL,NULL,'string',NULL),('treasury.facts.BillItem.billrefid','treasury.facts.BillItem','billrefid','Bill Ref ID','string',7,'var',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('treasury.facts.BillItem.discount','treasury.facts.BillItem','discount','Discount','decimal',8,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('treasury.facts.BillItem.duedate','treasury.facts.BillItem','duedate','Due Date','date',4,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('treasury.facts.BillItem.fromdate','treasury.facts.BillItem','fromdate','From Date','date',14,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('treasury.facts.BillItem.interest','treasury.facts.BillItem','interest','Interest','decimal',11,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('treasury.facts.BillItem.month','treasury.facts.BillItem','month','Month','integer',13,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('treasury.facts.BillItem.org','treasury.facts.BillItem','org','Org','string',10,'var',NULL,NULL,NULL,NULL,NULL,NULL,'enterprise.facts.Org',NULL),('treasury.facts.BillItem.parentaccount','treasury.facts.BillItem','parentaccount','Parent Account','string',9,'lookup','revenueitem:lookup','objid','title',NULL,NULL,NULL,'object',NULL),('treasury.facts.BillItem.paypriority','treasury.facts.BillItem','paypriority','Pay Priority','integer',18,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('treasury.facts.BillItem.refid','treasury.facts.BillItem','refid','Ref ID','string',16,'var',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('treasury.facts.BillItem.remarks','treasury.facts.BillItem','remarks','Remarks','string',17,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('treasury.facts.BillItem.sortorder','treasury.facts.BillItem','sortorder','Sort Order','integer',19,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('treasury.facts.BillItem.surcharge','treasury.facts.BillItem','surcharge','Surcharge','decimal',5,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('treasury.facts.BillItem.tag','treasury.facts.BillItem','tag','Tag','string',20,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('treasury.facts.BillItem.todate','treasury.facts.BillItem','todate','To Date','date',15,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('treasury.facts.BillItem.txntype','treasury.facts.BillItem','txntype','Txn Type','string',6,'lookup','billitem_txntype:lookup','objid','title',NULL,NULL,NULL,'string',NULL),('treasury.facts.BillItem.year','treasury.facts.BillItem','year','Year','integer',12,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('treasury.facts.Deposit.amount','treasury.facts.Deposit','amount','Amount','decimal',1,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('treasury.facts.ExcessPayment.amount','treasury.facts.ExcessPayment','amount','Amount','decimal',1,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('treasury.facts.HolidayFact.id','treasury.facts.HolidayFact','id','ID','string',1,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('treasury.facts.Payment.amount','treasury.facts.Payment','amount','Amount','decimal',1,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('treasury.facts.Requirement.code','treasury.facts.Requirement','code','Code','string',1,'lookup','requirementtype:lookup','code','title',NULL,NULL,NULL,'string',NULL),('treasury.facts.Requirement.completed','treasury.facts.Requirement','completed','Completed','boolean',2,'boolean',NULL,NULL,NULL,NULL,NULL,NULL,'boolean',NULL),('treasury.facts.TransactionDate.date','treasury.facts.TransactionDate','date','Date','date',1,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('treasury.facts.TransactionDate.day','treasury.facts.TransactionDate','day','Day','integer',4,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('treasury.facts.TransactionDate.month','treasury.facts.TransactionDate','month','Month','integer',3,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('treasury.facts.TransactionDate.qtr','treasury.facts.TransactionDate','qtr','Qtr','integer',5,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('treasury.facts.TransactionDate.tag','treasury.facts.TransactionDate','tag','Tag','string',6,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('treasury.facts.TransactionDate.year','treasury.facts.TransactionDate','year','Year','integer',2,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('treasury.facts.VarInteger.tag','treasury.facts.VarInteger','tag','Tag','string',2,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('treasury.facts.VarInteger.value','treasury.facts.VarInteger','value','Value','integer',1,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('waterworks.facts.WaterAccount.barangay','waterworks.facts.WaterAccount','barangay','Barangay','string',3,'lookup','barangay:lookup','objid','name',NULL,NULL,NULL,'string',NULL),('waterworks.facts.WaterAccount.classification','waterworks.facts.WaterAccount','classification','Classification','string',1,'lookup','waterworks_classification:lookup','objid','description',NULL,NULL,NULL,'string',NULL),('waterworks.facts.WaterAccount.hasarrears','waterworks.facts.WaterAccount','hasarrears','Has Arrears','boolean',7,'boolean',NULL,NULL,NULL,NULL,NULL,NULL,'boolean',NULL),('waterworks.facts.WaterAccount.metered','waterworks.facts.WaterAccount','metered','Metered','boolean',6,'boolean',NULL,NULL,NULL,NULL,NULL,NULL,'boolean',NULL),('waterworks.facts.WaterAccount.metersize','waterworks.facts.WaterAccount','metersize','Meter Size','string',2,'lookup','waterworks_metersize:lookup','objid','title',NULL,NULL,NULL,'string',NULL),('waterworks.facts.WaterAccount.state','waterworks.facts.WaterAccount','state','State','string',5,'lov',NULL,NULL,NULL,NULL,NULL,NULL,'string','WATERWORKS_ACCOUNT_STATE'),('waterworks.facts.WaterAccount.units','waterworks.facts.WaterAccount','units','No. of Units','integer',4,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('waterworks.facts.WaterBill.balanceforward','waterworks.facts.WaterBill','balanceforward','Balance Forward','decimal',3,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('waterworks.facts.WaterBill.billdate','waterworks.facts.WaterBill','billdate','Bill Date','date',4,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('waterworks.facts.WaterBill.discdate','waterworks.facts.WaterBill','discdate','Disc. Date','date',7,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('waterworks.facts.WaterBill.duedate','waterworks.facts.WaterBill','duedate','Due Date','date',8,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('waterworks.facts.WaterBill.expirydate','waterworks.facts.WaterBill','expirydate','Expiry Date','date',9,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('waterworks.facts.WaterBill.fromdate','waterworks.facts.WaterBill','fromdate','From Date','date',5,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('waterworks.facts.WaterBill.month','waterworks.facts.WaterBill','month','Month','integer',2,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('waterworks.facts.WaterBill.todate','waterworks.facts.WaterBill','todate','To Date','date',6,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('waterworks.facts.WaterBill.totalunpaid','waterworks.facts.WaterBill','totalunpaid','Total Unpaid','decimal',10,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('waterworks.facts.WaterBill.year','waterworks.facts.WaterBill','year','Year','integer',1,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('waterworks.facts.WaterBill.yearmonth','waterworks.facts.WaterBill','yearmonth','Year Month','integer',11,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('waterworks.facts.WaterBillingPeriod.billdate','waterworks.facts.WaterBillingPeriod','billdate','Bill Date','date',7,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('waterworks.facts.WaterBillingPeriod.billexpirydate','waterworks.facts.WaterBillingPeriod','billexpirydate','Bill Expiry Date','date',11,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('waterworks.facts.WaterBillingPeriod.billingenddate','waterworks.facts.WaterBillingPeriod','billingenddate','Billing End Date','date',8,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('waterworks.facts.WaterBillingPeriod.discdate','waterworks.facts.WaterBillingPeriod','discdate','Discount Date','date',9,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('waterworks.facts.WaterBillingPeriod.duedate','waterworks.facts.WaterBillingPeriod','duedate','Due Date','date',10,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('waterworks.facts.WaterBillingPeriod.fromdate','waterworks.facts.WaterBillingPeriod','fromdate','From Date','date',3,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('waterworks.facts.WaterBillingPeriod.month','waterworks.facts.WaterBillingPeriod','month','Month','integer',1,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('waterworks.facts.WaterBillingPeriod.readingdate','waterworks.facts.WaterBillingPeriod','readingdate','Reading Date','date',5,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('waterworks.facts.WaterBillingPeriod.readingenddate','waterworks.facts.WaterBillingPeriod','readingenddate','Reading End Date','date',6,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('waterworks.facts.WaterBillingPeriod.todate','waterworks.facts.WaterBillingPeriod','todate','To Date','date',4,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('waterworks.facts.WaterBillingPeriod.year','waterworks.facts.WaterBillingPeriod','year','Year','integer',2,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('waterworks.facts.WaterBillItem.amount','waterworks.facts.WaterBillItem','amount','Amount','decimal',2,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('waterworks.facts.WaterBillItem.amtpaid','waterworks.facts.WaterBillItem','amtpaid','Amt Paid','decimal',8,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('waterworks.facts.WaterBillItem.billcode','waterworks.facts.WaterBillItem','billcode','Bill code','string',1,'lookup','waterworks_itemaccount:lookup','objid','title',NULL,NULL,NULL,'string',NULL),('waterworks.facts.WaterBillItem.month','waterworks.facts.WaterBillItem','month','Month','integer',4,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('waterworks.facts.WaterBillItem.principal','waterworks.facts.WaterBillItem','principal','Principal','decimal',7,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('waterworks.facts.WaterBillItem.remarks','waterworks.facts.WaterBillItem','remarks','Remarks','string',6,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('waterworks.facts.WaterBillItem.volume','waterworks.facts.WaterBillItem','volume','Volume','integer',5,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('waterworks.facts.WaterBillItem.year','waterworks.facts.WaterBillItem','year','Year','integer',3,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('waterworks.facts.WaterBillItem.yearmonth','waterworks.facts.WaterBillItem','yearmonth','Year Month','integer',9,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('waterworks.facts.WaterBillRecurringFee.amount','waterworks.facts.WaterBillRecurringFee','amount','Amount','decimal',7,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('waterworks.facts.WaterBillRecurringFee.amtdue','waterworks.facts.WaterBillRecurringFee','amtdue','Amt Due','decimal',8,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('waterworks.facts.WaterBillRecurringFee.billcode','waterworks.facts.WaterBillRecurringFee','billcode','Bill code','string',4,'lookup','waterworks_itemaccount:lookup','objid','title',NULL,NULL,NULL,'string',NULL),('waterworks.facts.WaterBillRecurringFee.installmentamount','waterworks.facts.WaterBillRecurringFee','installmentamount','Installment Amount','decimal',5,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('waterworks.facts.WaterBillRecurringFee.startmonth','waterworks.facts.WaterBillRecurringFee','startmonth','Start Month','integer',2,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('waterworks.facts.WaterBillRecurringFee.startyear','waterworks.facts.WaterBillRecurringFee','startyear','Start Year','integer',1,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('waterworks.facts.WaterBillRecurringFee.term','waterworks.facts.WaterBillRecurringFee','term','Term','integer',6,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('waterworks.facts.WaterBillRecurringFee.type','waterworks.facts.WaterBillRecurringFee','type','Type','string',3,'lov',NULL,NULL,NULL,NULL,NULL,NULL,'string','WATERWORKS_RECURRINGFEE_TYPE'),('waterworks.facts.WaterConsumption.amount','waterworks.facts.WaterConsumption','amount','Amount','decimal',2,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('waterworks.facts.WaterConsumption.hold','waterworks.facts.WaterConsumption','hold','Hold','boolean',3,'boolean',NULL,NULL,NULL,NULL,NULL,NULL,'boolean',NULL),('waterworks.facts.WaterConsumption.volume','waterworks.facts.WaterConsumption','volume','Volume','integer',1,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('waterworks.facts.WaterMeter.capacity','waterworks.facts.WaterMeter','capacity','Capacity','string',3,'var',NULL,NULL,NULL,NULL,NULL,NULL,'WATERWORKS_METER_CAPACITY',NULL),('waterworks.facts.WaterMeter.sizeid','waterworks.facts.WaterMeter','sizeid','Size','string',1,'lookup','waterworks_metersize:lookup','objid','title',NULL,NULL,NULL,'string',NULL),('waterworks.facts.WaterMeter.state','waterworks.facts.WaterMeter','state','Status','string',2,'var',NULL,NULL,NULL,NULL,NULL,NULL,'WATERWORKS_METER_STATE',NULL),('waterworks.facts.WaterScheduleGroup.id','waterworks.facts.WaterScheduleGroup','id','ID','string',1,'lookup','waterworks_schedule_group:lookup','objid','objid',NULL,NULL,NULL,'string',NULL),('waterworks.facts.WaterworksAttribute.name','waterworks.facts.WaterworksAttribute','name','Name','string',1,'lookup','waterworks_attribute:lookup','name','title',NULL,NULL,NULL,'string',NULL);
/*!40000 ALTER TABLE `sys_rule_fact_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rulegroup`
--

DROP TABLE IF EXISTS `sys_rulegroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rulegroup` (
  `name` varchar(50) NOT NULL,
  `ruleset` varchar(50) NOT NULL,
  `title` varchar(160) DEFAULT NULL,
  `sortorder` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`,`ruleset`) USING BTREE,
  KEY `ix_ruleset` (`ruleset`) USING BTREE,
  CONSTRAINT `fk_sys_rulegroup_ruleset` FOREIGN KEY (`ruleset`) REFERENCES `sys_ruleset` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rulegroup`
--

LOCK TABLES `sys_rulegroup` WRITE;
/*!40000 ALTER TABLE `sys_rulegroup` DISABLE KEYS */;
INSERT INTO `sys_rulegroup` VALUES ('account-mapping','waterworkspayment','Account Mapping',4),('billing','waterworksbilling','Billing Initial',1),('computefee','waterworksapplication','Compute Fee',1),('computefee','waterworksbilling','Compute Fee',2),('discount','waterworkspayment','Discount',1),('initial','waterworksapplication','Initial',0),('initial','waterworksbillingschedule','Initial',0),('initial','waterworkscomputation','Initial',0),('interest','waterworksbilling','Compute Interest',4),('payment','waterworkspayment','Payment',2),('post-initial','waterworksbillingschedule','Post Initial',1),('pre-computation','waterworkscomputation','Pre-Computation',0),('requirement','waterworksapplication','Requirements',5),('summary','waterworksbilling','Summary',5),('summary','waterworkspayment','Summary',3),('surcharge','waterworksbilling','Compute Surcharge',3);
/*!40000 ALTER TABLE `sys_rulegroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_ruleset`
--

DROP TABLE IF EXISTS `sys_ruleset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_ruleset` (
  `name` varchar(50) NOT NULL,
  `title` varchar(160) DEFAULT NULL,
  `packagename` varchar(50) DEFAULT NULL,
  `domain` varchar(50) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `permission` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_ruleset`
--

LOCK TABLES `sys_ruleset` WRITE;
/*!40000 ALTER TABLE `sys_ruleset` DISABLE KEYS */;
INSERT INTO `sys_ruleset` VALUES ('waterworksapplication','Water Works Application','waterworksapplication','WATERWORKS','RULE_AUTHOR',NULL),('waterworksbilling','Water Works Billing','waterworksbilling','WATERWORKS','RULE_AUTHOR',NULL),('waterworksbillingschedule','Water Works Billing Schedule','waterworksbillingschedule','WATERWORKS','RULE_AUTHOR',NULL),('waterworkscomputation','Water Works Computation','waterworkscomputation','WATERWORKS','RULE_AUTHOR',NULL),('waterworkspayment','Water Works Payment','waterworkspayment','WATERWORKS','RULE_AUTHOR',NULL);
/*!40000 ALTER TABLE `sys_ruleset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_ruleset_actiondef`
--

DROP TABLE IF EXISTS `sys_ruleset_actiondef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_ruleset_actiondef` (
  `ruleset` varchar(50) NOT NULL,
  `actiondef` varchar(50) NOT NULL,
  PRIMARY KEY (`ruleset`,`actiondef`) USING BTREE,
  KEY `ix_actiondef` (`actiondef`) USING BTREE,
  CONSTRAINT `fk_sys_ruleset_actiondef_actiondef` FOREIGN KEY (`actiondef`) REFERENCES `sys_rule_actiondef` (`objid`),
  CONSTRAINT `fk_sys_ruleset_actiondef_ruleset` FOREIGN KEY (`ruleset`) REFERENCES `sys_ruleset` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_ruleset_actiondef`
--

LOCK TABLES `sys_ruleset_actiondef` WRITE;
/*!40000 ALTER TABLE `sys_ruleset_actiondef` DISABLE KEYS */;
INSERT INTO `sys_ruleset_actiondef` VALUES ('waterworksapplication','enterprise.actions.AddRequirement'),('waterworksbilling','enterprise.actions.PrintTest'),('waterworkscomputation','enterprise.actions.ThrowException'),('waterworkspayment','enterprise.actions.ThrowException'),('waterworksbilling','treasury.actions.AddCreditBillItem'),('waterworkspayment','treasury.actions.AddCreditBillItem'),('waterworkspayment','treasury.actions.AddDiscountItem'),('waterworkscomputation','treasury.actions.AddVarInteger'),('waterworkspayment','treasury.actions.ApplyPayment'),('waterworksapplication','treasury.actions.ComputeFee'),('waterworksapplication','treasury.actions.SetBillItemAccount'),('waterworksbilling','treasury.actions.SetBillItemAccount'),('waterworkspayment','treasury.actions.SetBillItemAccount'),('waterworksbilling','treasury.actions.SetBillItemProperty'),('waterworksbilling','waterworks.actions.AddRecurringWaterBillItem'),('waterworksbilling','waterworks.actions.AddWaterBillItem'),('waterworkscomputation','waterworks.actions.ComputeConsumption'),('waterworksbillingschedule','waterworks.actions.SetWaterBillingPeriod'),('waterworksbilling','waterworks.actions.SetWaterConsumptionProperty'),('waterworkscomputation','waterworks.actions.SetWaterConsumptionProperty');
/*!40000 ALTER TABLE `sys_ruleset_actiondef` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_ruleset_fact`
--

DROP TABLE IF EXISTS `sys_ruleset_fact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_ruleset_fact` (
  `ruleset` varchar(50) NOT NULL,
  `rulefact` varchar(50) NOT NULL,
  PRIMARY KEY (`ruleset`,`rulefact`) USING BTREE,
  KEY `ix_rulefact` (`rulefact`) USING BTREE,
  CONSTRAINT `fk_sys_ruleset_fact_rulefact` FOREIGN KEY (`rulefact`) REFERENCES `sys_rule_fact` (`objid`),
  CONSTRAINT `fk_sys_ruleset_fact_ruleset` FOREIGN KEY (`ruleset`) REFERENCES `sys_ruleset` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_ruleset_fact`
--

LOCK TABLES `sys_ruleset_fact` WRITE;
/*!40000 ALTER TABLE `sys_ruleset_fact` DISABLE KEYS */;
INSERT INTO `sys_ruleset_fact` VALUES ('waterworksbilling','com.rameses.rules.common.CurrentDate'),('waterworkspayment','com.rameses.rules.common.CurrentDate'),('waterworksapplication','treasury.facts.BillItem'),('waterworkspayment','treasury.facts.Deposit'),('waterworkspayment','treasury.facts.ExcessPayment'),('waterworksbillingschedule','treasury.facts.HolidayFact'),('waterworkspayment','treasury.facts.Payment'),('waterworksapplication','treasury.facts.Requirement'),('waterworksbilling','treasury.facts.TransactionDate'),('waterworkspayment','treasury.facts.TransactionDate'),('waterworkscomputation','treasury.facts.VarInteger'),('waterworksbilling','waterworks.facts.WaterAccount'),('waterworkscomputation','waterworks.facts.WaterAccount'),('waterworkspayment','waterworks.facts.WaterAccount'),('waterworksbilling','waterworks.facts.WaterBill'),('waterworkspayment','waterworks.facts.WaterBill'),('waterworksbilling','waterworks.facts.WaterBillingPeriod'),('waterworksbillingschedule','waterworks.facts.WaterBillingPeriod'),('waterworksbilling','waterworks.facts.WaterBillItem'),('waterworkspayment','waterworks.facts.WaterBillItem'),('waterworksbilling','waterworks.facts.WaterBillRecurringFee'),('waterworksbilling','waterworks.facts.WaterConsumption'),('waterworkscomputation','waterworks.facts.WaterConsumption'),('waterworkscomputation','waterworks.facts.WaterMeter'),('waterworksbillingschedule','waterworks.facts.WaterScheduleGroup'),('waterworksbilling','waterworks.facts.WaterworksAttribute'),('waterworkscomputation','waterworks.facts.WaterworksAttribute'),('waterworkspayment','waterworks.facts.WaterworksAttribute');
/*!40000 ALTER TABLE `sys_ruleset_fact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_sequence`
--

DROP TABLE IF EXISTS `sys_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_sequence` (
  `objid` varchar(100) NOT NULL,
  `nextSeries` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_sequence`
--

LOCK TABLES `sys_sequence` WRITE;
/*!40000 ALTER TABLE `sys_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
  `objid` varchar(50) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `middlename` varchar(50) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `jobtitle` varchar(50) DEFAULT NULL,
  `txncode` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_username` (`username`),
  KEY `ix_lastname_firstname` (`lastname`,`firstname`),
  KEY `ix_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_role` (
  `objid` varchar(50) NOT NULL,
  `role` varchar(50) DEFAULT NULL,
  `userid` varchar(50) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `org_objid` varchar(50) DEFAULT NULL,
  `org_name` varchar(50) DEFAULT NULL,
  `securitygroup_objid` varchar(50) DEFAULT NULL,
  `exclude` varchar(255) DEFAULT NULL,
  `uid` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_sys_user_role_uid` (`uid`),
  KEY `fk_sys_user_role_role` (`role`),
  KEY `fk_sys_user_role_userid` (`userid`),
  CONSTRAINT `fk_sys_user_role_role` FOREIGN KEY (`role`) REFERENCES `sys_role` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_usergroup`
--

DROP TABLE IF EXISTS `sys_usergroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_usergroup` (
  `objid` varchar(50) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `domain` varchar(25) DEFAULT NULL,
  `userclass` varchar(25) DEFAULT NULL,
  `orgclass` varchar(50) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_usergroup`
--

LOCK TABLES `sys_usergroup` WRITE;
/*!40000 ALTER TABLE `sys_usergroup` DISABLE KEYS */;
INSERT INTO `sys_usergroup` VALUES ('WATERWORKS.ADMIN','WATERWORKS','WATERWORKS',NULL,NULL,'ADMIN'),('WATERWORKS.APPROVER','WATERWORKS','WATERWORKS',NULL,NULL,'APPROVER'),('WATERWORKS.BILLING','WATERWORKS BILLING','WATERWORKS',NULL,NULL,'BILLING'),('WATERWORKS.MASTER','WATERWORKS MASTER','WATERWORKS',NULL,NULL,'MASTER'),('WATERWORKS.READER','WATERWORKS READER','WATERWORKS',NULL,NULL,'READER'),('WATERWORKS.REPORT','WATERWORKS REPORT','WATERWORKS',NULL,NULL,'REPORT'),('WATERWORKS.RULE_AUTHOR','WATERWORKS RULE_AUTHOR','WATERWORKS',NULL,NULL,'RULE_AUTHOR'),('WATERWORKS.SHARED','WATERWORKS SHARED','WATERWORKS',NULL,NULL,'SHARED');
/*!40000 ALTER TABLE `sys_usergroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_var`
--

DROP TABLE IF EXISTS `sys_var`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_var` (
  `name` varchar(50) NOT NULL,
  `value` longtext,
  `description` varchar(255) DEFAULT NULL,
  `datatype` varchar(15) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_var`
--

LOCK TABLES `sys_var` WRITE;
/*!40000 ALTER TABLE `sys_var` DISABLE KEYS */;
INSERT INTO `sys_var` VALUES ('waterworks_acctno_format','WA-[org]-[%06d]',NULL,NULL,NULL),('waterworks_application_appno_format','WAP-[yyyyMM]-[%05d]',NULL,NULL,NULL),('waterworks_batch_print_size','20',NULL,'integer',NULL),('waterworks_batch_process_size','20',NULL,'integer',NULL),('waterworks_billno_format','WB-[yyyyMM]-[%05d]',NULL,NULL,NULL),('waterworks_bill_barcode_prefix','TCWS',NULL,NULL,NULL),('waterworks_change_request_controlno_format','WCR-[yyyyMM]-[%05d]',NULL,NULL,NULL),('waterworks_disconnection_controlno_format','WDC-[yyyyMM]-[%05d]',NULL,NULL,NULL);
/*!40000 ALTER TABLE `sys_var` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_wf`
--

DROP TABLE IF EXISTS `sys_wf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_wf` (
  `name` varchar(50) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `domain` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_wf`
--

LOCK TABLES `sys_wf` WRITE;
/*!40000 ALTER TABLE `sys_wf` DISABLE KEYS */;
INSERT INTO `sys_wf` VALUES ('waterworks_application','Waterworks Application','WATERWORKS'),('waterworks_batch_billing','Waterworks Batch Billing','WATERWORKS'),('waterworks_change_request','Waterworks Change Request','WATERWORKS'),('waterworks_compromise','Waterworks Compromise','WATERWORKS'),('waterworks_disconnection','Waterworks Disconnection','WATERWORKS'),('waterworks_newconnection','Waterworks New Connection','WATERWORKS'),('waterworks_reconnection','Waterworks Reconnection','WATERWORKS');
/*!40000 ALTER TABLE `sys_wf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_wf_node`
--

DROP TABLE IF EXISTS `sys_wf_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_wf_node` (
  `name` varchar(50) NOT NULL,
  `processname` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(100) DEFAULT NULL,
  `nodetype` varchar(10) DEFAULT NULL,
  `idx` int(11) DEFAULT NULL,
  `salience` int(11) DEFAULT NULL,
  `domain` varchar(50) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `ui` text,
  `properties` text,
  `tracktime` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`,`processname`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_wf_node`
--

LOCK TABLES `sys_wf_node` WRITE;
/*!40000 ALTER TABLE `sys_wf_node` DISABLE KEYS */;
INSERT INTO `sys_wf_node` VALUES ('approval','waterworks_application','Approval','state',4,NULL,NULL,NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[568,73],size:[146,63]]','[:]',1),('approved','waterworks_batch_billing','Approved','state',6,0,'WATERWORKS',NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[748,103],size:[100,50]]','[show_reading:true]',NULL),('assessment','waterworks_application','Assessment','state',3,NULL,NULL,NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[367,69],size:[134,65]]','[:]',1),('billing','waterworks_compromise','Billing','state',6,0,NULL,NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[608,187],size:[108,58]]','[:]',1),('billing','waterworks_newconnection','Billing','state',5,0,NULL,NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[542,157],size:[108,58]]','[:]',1),('draft','waterworks_batch_billing','Draft','state',2,0,'WATERWORKS',NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[177,115],size:[109,53]]','[:]',NULL),('draft','waterworks_change_request','Draft','state',1,0,'WATERWORKS',NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[267,72],size:[87,55]]','[:]',1),('draft','waterworks_compromise','Draft','state',2,0,'WATERWORKS',NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[225,85],size:[87,55]]','[:]',1),('draft','waterworks_disconnection','Draft','state',1,0,'WATERWORKS',NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[267,72],size:[87,55]]','[:]',1),('draft','waterworks_reconnection','Draft','state',1,0,'WATERWORKS',NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[267,72],size:[87,55]]','[:]',1),('end','waterworks_application','Completed','end',7,NULL,NULL,NULL,'[type:\"end\",fillColor:\"#ff0000\",pos:[756,57],size:[32,32]]','[:]',NULL),('end','waterworks_batch_billing','Completed','end',7,0,'WATERWORKS',NULL,'[type:\"end\",fillColor:\"#ff0000\",pos:[923,260],size:[32,32]]','[show_reading:true]',NULL),('end','waterworks_change_request','Completed','end',3,0,NULL,NULL,'[type:\"end\",fillColor:\"#ff0000\",pos:[718,131],size:[32,32]]','[:]',NULL),('end','waterworks_compromise','Completed','end',9,0,NULL,NULL,'[type:\"end\",fillColor:\"#ff0000\",pos:[1027,346],size:[32,32]]','[:]',NULL),('end','waterworks_disconnection','Completed','end',3,0,NULL,NULL,'[type:\"end\",fillColor:\"#ff0000\",pos:[718,131],size:[32,32]]','[:]',NULL),('end','waterworks_newconnection','Completed','end',7,0,NULL,NULL,'[type:\"end\",fillColor:\"#ff0000\",pos:[894,322],size:[32,32]]','[:]',NULL),('end','waterworks_reconnection','Completed','end',3,0,NULL,NULL,'[type:\"end\",fillColor:\"#ff0000\",pos:[718,131],size:[32,32]]','[:]',NULL),('for-approval','waterworks_batch_billing','For Approval','state',5,0,'WATERWORKS',NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[661,222],size:[100,50]]','[show_reading:true]',NULL),('for-approval','waterworks_change_request','For Approval','state',2,0,'WATERWORKS',NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[509,128],size:[104,60]]','[:]',1),('for-approval','waterworks_compromise','For Approval','state',5,0,'WATERWORKS',NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[640,52],size:[104,60]]','[:]',1),('for-approval','waterworks_disconnection','For Approval','state',2,0,'WATERWORKS',NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[509,128],size:[104,60]]','[:]',1),('for-approval','waterworks_newconnection','For Approval','state',4,0,'WATERWORKS',NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[632,53],size:[104,60]]','[:]',1),('for-approval','waterworks_reconnection','For Approval','state',2,0,'WATERWORKS',NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[509,128],size:[104,60]]','[:]',1),('for-reading','waterworks_batch_billing','For Reading','state',3,0,'WATERWORKS',NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[370,153],size:[100,50]]','[show_reading:true]',NULL),('for-reversal','waterworks_newconnection','For Reversal','state',6,0,NULL,NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[364,295],size:[119,57]]','[:]',NULL),('for-review','waterworks_compromise','For Review','state',3,0,NULL,NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[369,13],size:[102,56]]','[:]',1),('for-review','waterworks_newconnection','For Review','state',3,0,NULL,NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[420,21],size:[102,56]]','[:]',1),('initial-payment','waterworks_compromise','Initial Payment','state',4,0,NULL,NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[408,158],size:[119,62]]','[:]',0),('mobile-reading','waterworks_batch_billing','For Mobile Reading','state',4,0,NULL,NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[535,23],size:[156,52]]','[:]',1),('payment','waterworks_application','Payment','state',5,NULL,NULL,NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[340,166],size:[130,67]]','[:]',NULL),('payment','waterworks_compromise','For Payment','state',7,0,NULL,NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[721,282],size:[111,57]]','[:]',NULL),('payment','waterworks_newconnection','For Payment','state',6,0,NULL,NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[581,279],size:[111,57]]','[:]',NULL),('receiving','waterworks_application','Receiving','state',2,0,NULL,NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[146,60],size:[133,60]]','[:]',1),('receiving','waterworks_newconnection','Receiving','state',2,1,NULL,NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[217,90],size:[107,65]]','[:]',1),('releasing','waterworks_application','Releasing','state',6,NULL,NULL,NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[573,165],size:[154,69]]','[:]',NULL),('releasing','waterworks_compromise','Releasing','state',8,0,NULL,NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[864,385],size:[103,53]]','[:]',NULL),('start','waterworks_application','start','start',1,NULL,NULL,NULL,'[type:\"start\",fillColor:\"#00ff00\",pos:[52,22],size:[32,32]]','[:]',NULL),('start','waterworks_batch_billing','Start','start',1,0,'WATERWORKS',NULL,'[type:\"start\",fillColor:\"#00ff00\",pos:[72,60],size:[32,32]]','[:]',NULL),('start','waterworks_change_request','Start','start',0,0,NULL,NULL,'[type:\"start\",fillColor:\"#00ff00\",pos:[174,47],size:[32,32]]','[:]',NULL),('start','waterworks_compromise','Start','start',1,0,NULL,NULL,'[type:\"start\",fillColor:\"#00ff00\",pos:[129,41],size:[32,32]]','[:]',NULL),('start','waterworks_disconnection','Start','start',0,0,NULL,NULL,'[type:\"start\",fillColor:\"#00ff00\",pos:[174,47],size:[32,32]]','[:]',NULL),('start','waterworks_newconnection','Start','start',1,0,NULL,NULL,'[type:\"start\",fillColor:\"#00ff00\",pos:[129,41],size:[32,32]]','[:]',NULL),('start','waterworks_reconnection','Start','start',0,0,NULL,NULL,'[type:\"start\",fillColor:\"#00ff00\",pos:[174,47],size:[32,32]]','[:]',NULL);
/*!40000 ALTER TABLE `sys_wf_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_wf_transition`
--

DROP TABLE IF EXISTS `sys_wf_transition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_wf_transition` (
  `parentid` varchar(50) NOT NULL DEFAULT '',
  `processname` varchar(50) NOT NULL DEFAULT '',
  `action` varchar(50) NOT NULL,
  `to` varchar(50) NOT NULL,
  `idx` int(11) DEFAULT NULL,
  `eval` mediumtext,
  `properties` varchar(255) DEFAULT NULL,
  `permission` varchar(255) DEFAULT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `ui` text,
  PRIMARY KEY (`parentid`,`processname`,`to`,`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_wf_transition`
--

LOCK TABLES `sys_wf_transition` WRITE;
/*!40000 ALTER TABLE `sys_wf_transition` DISABLE KEYS */;
INSERT INTO `sys_wf_transition` VALUES ('approval','waterworks_application','approve','payment',0,NULL,'[showConfirm:true,confirmMessage:\"You are about to approve this for payment. Proceed?\"]',NULL,'Approve for Payment','[points:[568,131,470,169],type:\"arrow\",pos:[470,131],size:[98,38]]'),('approved','waterworks_batch_billing','close-batch','end',0,NULL,'[showConfirm:true,confirmMessage:\"You are about to close this batch. Please confirm\"]',NULL,'Close Batch','[points:[821,153,923,260],type:\"arrow\",pos:[821,153],size:[102,107]]'),('assessment','waterworks_application','send-for-approval','approval',0,NULL,'[:]',NULL,'Send for Approval','[points:[501,100,568,100],type:\"arrow\",pos:[501,100],size:[67,0]]'),('billing','waterworks_compromise','close','end',0,NULL,'[visibleWhen:\"#{ false }\"]',NULL,'Close','[points:[716,227,904,215,903,216,1035,346],type:\"arrow\",pos:[716,215],size:[319,131]]'),('billing','waterworks_compromise','send-for-payment','payment',0,NULL,'[:]',NULL,'Send for Payment','[points:[674,245,766,282],type:\"arrow\",pos:[674,245],size:[92,37]]'),('billing','waterworks_newconnection','close','end',0,NULL,'[visibleWhen:\"#{ false }\"]',NULL,'Close','[points:[650,197,904,215,903,216,902,322],type:\"arrow\",pos:[650,197],size:[254,125]]'),('billing','waterworks_newconnection','send-for-reveral','for-reversal',0,NULL,'[:]',NULL,'Send for Reversal','[points:[564,215,451,295],type:\"arrow\",pos:[451,215],size:[113,80]]'),('billing','waterworks_newconnection','send-for-payment','payment',0,NULL,'[:]',NULL,'Send for Payment','[points:[608,215,626,279],type:\"arrow\",pos:[608,215],size:[18,64]]'),('draft','waterworks_batch_billing','submit-for-reading','for-reading',0,NULL,'[:]',NULL,'Submit for Reading','[points:[286,129,370,191],type:\"arrow\",pos:[286,129],size:[84,62]]'),('draft','waterworks_change_request','send-for-approval','for-approval',0,NULL,'[showConfirm:true,confirmMessage:\"You are about to send this for approval. Proceed?\"]',NULL,'Send for Approval','[points:[354,105,509,139],type:\"arrow\",pos:[354,105],size:[155,34]]'),('draft','waterworks_compromise','send-for-review','for-review',0,NULL,'[:]',NULL,'Submit for Review','[points:[312,101,369,54],type:\"arrow\",pos:[312,54],size:[57,47]]'),('draft','waterworks_disconnection','send-for-approval','for-approval',0,NULL,'[showConfirm:true,confirmMessage:\"You are about to send this for approval. Proceed?\"]',NULL,'Send for Approval','[points:[354,105,509,139],type:\"arrow\",pos:[354,105],size:[155,34]]'),('draft','waterworks_reconnection','send-for-approval','for-approval',0,NULL,'[showConfirm:true,confirmMessage:\"You are about to send this for approval. Proceed?\"]',NULL,'Send for Approval','[points:[354,105,509,139],type:\"arrow\",pos:[354,105],size:[155,34]]'),('for-approval','waterworks_batch_billing','approve','approved',1,NULL,'[:]',NULL,'Approve','[points:[712,224,773,149],type:\"arrow\",pos:[712,149],size:[61,75]]'),('for-approval','waterworks_change_request','approve','end',0,NULL,'[showConfirm:true,confirmMessage:\"You are about to update the account. Proceed?\"]',NULL,'Approve','[points:[613,160,718,146],type:\"arrow\",pos:[613,146],size:[105,14]]'),('for-approval','waterworks_compromise','approve','billing',0,NULL,'[showConfirm:true,confirmMessage:\"You are about to approve and send this for billing. Proceed?\"]',NULL,'Approve','[points:[673,112,680,187],type:\"arrow\",pos:[673,112],size:[7,75]]'),('for-approval','waterworks_compromise','void-payment','initial-payment',0,NULL,'[visibleWhen:\"#{false}\"]',NULL,'Void Payment','[points:[640,83,555,85,493,158],type:\"arrow\",pos:[493,83],size:[147,75]]'),('for-approval','waterworks_disconnection','approve','end',0,NULL,'[showConfirm:true,confirmMessage:\"You are about to update the account. Proceed?\"]',NULL,'Approve','[points:[613,160,718,146],type:\"arrow\",pos:[613,146],size:[105,14]]'),('for-approval','waterworks_newconnection','approve','billing',0,NULL,'[showConfirm:true,confirmMessage:\"You are about to approve and send this for billing. Proceed?\"]',NULL,'Approve','[points:[665,113,614,157],type:\"arrow\",pos:[614,113],size:[51,44]]'),('for-approval','waterworks_reconnection','approve','end',0,NULL,'[showConfirm:true,confirmMessage:\"You are about to update the account. Proceed?\"]',NULL,'Approve','[points:[613,160,718,146],type:\"arrow\",pos:[613,146],size:[105,14]]'),('for-reading','waterworks_batch_billing','submit-for-approval','for-approval',0,NULL,'[showConfirm:true,confirmMessage:\"You are about to send this for approval. Proceed?\"]',NULL,'Submit for Approval','[points:[457,203,520,244,661,246],type:\"arrow\",pos:[457,203],size:[204,43]]'),('for-reading','waterworks_batch_billing','send-for-mobile-reading','mobile-reading',1,NULL,'[:]',NULL,'Send for Mobile Reading','[points:[458,153,577,75],type:\"arrow\",pos:[458,75],size:[119,78]]'),('for-reversal','waterworks_newconnection','approve-reversal','end',0,NULL,'[showConfirm:true,confirmMessage:\"You are about to reverse back the transaction to its original state. Proceed?\"]',NULL,'Approve','[points:[483,343,705,417,894,344],type:\"arrow\",pos:[483,343],size:[411,74]]'),('for-review','waterworks_compromise','send-for-approval','for-approval',0,NULL,'[showConfirm:true,confirmMessage:\"You are about to submit this for approval. Proceed?\"]',NULL,'Send for Approval','[points:[471,47,640,67],type:\"arrow\",pos:[471,47],size:[169,20]]'),('for-review','waterworks_compromise','send-for-initial-payment','initial-payment',0,NULL,'[:]',NULL,'Send for Initial Payment','[points:[429,69,460,158],type:\"arrow\",pos:[429,69],size:[31,89]]'),('for-review','waterworks_newconnection','send-for-approval','for-approval',0,NULL,'[showConfirm:true,confirmMessage:\"You are about to submit this for approval. Proceed?\"]',NULL,'Send for Approval','[points:[522,55,632,68],type:\"arrow\",pos:[522,55],size:[110,13]]'),('initial-payment','waterworks_compromise','post-payment','for-approval',0,NULL,'[visibleWhen:\"#{false}\"]',NULL,'Send for Approval','[points:[527,162,616,147,643,112],type:\"arrow\",pos:[527,112],size:[116,50]]'),('mobile-reading','waterworks_batch_billing','submit-for-approval','for-approval',1,NULL,'[showConfirm:true,confirmMessage:\"You are about to submit this for approval. Continue?\"]',NULL,'Submit for Approval','[points:[626,75,701,222],type:\"arrow\",pos:[626,75],size:[75,147]]'),('mobile-reading','waterworks_batch_billing','revert-mobile-reading','for-reading',0,NULL,'[:]',NULL,'Return for Reading','[points:[538,44,430,64,418,152],type:\"arrow\",pos:[418,44],size:[120,108]]'),('payment','waterworks_application','post-payment','releasing',0,NULL,'[visibleWhen:\"#{ false }\"]',NULL,'Post Payment','[points:[470,200,499,203,573,204],type:\"arrow\",pos:[470,200],size:[103,4]]'),('payment','waterworks_compromise','post-payment','releasing',0,NULL,'[visibleWhen:\"#{false}\"]',NULL,'Post Payment','[points:[813,339,866,345,887,385],type:\"arrow\",pos:[813,339],size:[74,46]]'),('payment','waterworks_newconnection','post-payment','end',0,NULL,'[visibleWhen:\"#{ false }\"]',NULL,'Post Payment','[points:[692,313,788,347,894,335],type:\"arrow\",pos:[692,313],size:[202,34]]'),('receiving','waterworks_application','send-for-assessment','assessment',0,NULL,'[showConfirm:true,confirmMessage:\"You are about to send this for assessment. Proceed?\"]',NULL,'Send for Assessment','[points:[279,93,367,99],type:\"arrow\",pos:[279,93],size:[88,6]]'),('receiving','waterworks_newconnection','send-for-review','for-review',0,NULL,'[:]',NULL,'Send for Review','[points:[324,102,420,68],type:\"arrow\",pos:[324,68],size:[96,34]]'),('releasing','waterworks_application','release','end',0,NULL,'[showConfirm:true,confirmMessage:\"You are about to release this document. Proceed?\"]',NULL,'Release','[points:[684,165,763,89],type:\"arrow\",pos:[684,89],size:[79,76]]'),('releasing','waterworks_compromise','release','end',0,NULL,'[:]',NULL,'Release','[points:[967,390,1027,367],type:\"arrow\",pos:[967,367],size:[60,23]]'),('releasing','waterworks_compromise','void-payment','payment',0,NULL,'[visibleWhen:\"#{false}\"]',NULL,'Void Payment','[points:[864,409,775,407,775,339],type:\"arrow\",pos:[775,339],size:[89,70]]'),('start','waterworks_application','start','receiving',0,NULL,'[:]',NULL,'Start','[points:[84,43,146,66],type:\"arrow\",pos:[84,43],size:[62,23]]'),('start','waterworks_batch_billing','submit','draft',0,NULL,'[autostart:true]',NULL,NULL,'[points:[104,80,214,115],type:\"arrow\",pos:[104,80],size:[110,35]]'),('start','waterworks_change_request','start','draft',0,NULL,'[:]',NULL,'Start','[points:[206,68,267,88],type:\"arrow\",pos:[206,68],size:[61,20]]'),('start','waterworks_compromise','start','draft',0,NULL,'[:]',NULL,'Start','[points:[161,62,225,101],type:\"arrow\",pos:[161,62],size:[64,39]]'),('start','waterworks_disconnection','start','draft',0,NULL,'[:]',NULL,'Start','[points:[206,68,267,88],type:\"arrow\",pos:[206,68],size:[61,20]]'),('start','waterworks_newconnection','start','receiving',0,NULL,'[:]',NULL,'Start','[points:[161,65,217,95],type:\"arrow\",pos:[161,65],size:[56,30]]'),('start','waterworks_reconnection','start','draft',0,NULL,'[:]',NULL,'Start','[points:[206,68,267,88],type:\"arrow\",pos:[206,68],size:[61,20]]');
/*!40000 ALTER TABLE `sys_wf_transition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temp_acctno_110000709_water_payment`
--

DROP TABLE IF EXISTS `temp_acctno_110000709_water_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_acctno_110000709_water_payment` (
  `objid` varchar(50) NOT NULL,
  `refno` varchar(50) DEFAULT NULL,
  `reftype` varchar(50) DEFAULT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `refdate` date DEFAULT NULL,
  `discount` decimal(16,2) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  `txnmode` varchar(50) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `billid` varchar(50) DEFAULT NULL,
  `appid` varchar(50) DEFAULT NULL,
  `compromiseid` varchar(50) DEFAULT NULL,
  `pmttxntype` varchar(50) DEFAULT NULL,
  `txndate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temp_acctno_110000709_water_payment`
--

LOCK TABLES `temp_acctno_110000709_water_payment` WRITE;
/*!40000 ALTER TABLE `temp_acctno_110000709_water_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `temp_acctno_110000709_water_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temp_acctno_240000703_b`
--

DROP TABLE IF EXISTS `temp_acctno_240000703_b`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_acctno_240000703_b` (
  `objid` varchar(50) NOT NULL,
  `batchid` varchar(50) DEFAULT NULL,
  `billid` varchar(50) DEFAULT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  `errmsg` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temp_acctno_240000703_b`
--

LOCK TABLES `temp_acctno_240000703_b` WRITE;
/*!40000 ALTER TABLE `temp_acctno_240000703_b` DISABLE KEYS */;
/*!40000 ALTER TABLE `temp_acctno_240000703_b` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temp_waterworks_consumption_acctno_240000703_b`
--

DROP TABLE IF EXISTS `temp_waterworks_consumption_acctno_240000703_b`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_waterworks_consumption_acctno_240000703_b` (
  `objid` varchar(50) NOT NULL,
  `acctid` varchar(50) NOT NULL,
  `meterid` varchar(50) DEFAULT NULL,
  `year` int(255) NOT NULL,
  `month` int(255) NOT NULL,
  `billid` varchar(50) DEFAULT NULL,
  `txnmode` varchar(50) DEFAULT NULL,
  `reading` int(11) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `state` varchar(32) DEFAULT NULL,
  `hold` int(11) NOT NULL DEFAULT '0',
  `reason` varchar(255) DEFAULT NULL,
  `reader_objid` varchar(50) DEFAULT NULL,
  `reader_name` varchar(255) DEFAULT NULL,
  `readingdate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temp_waterworks_consumption_acctno_240000703_b`
--

LOCK TABLES `temp_waterworks_consumption_acctno_240000703_b` WRITE;
/*!40000 ALTER TABLE `temp_waterworks_consumption_acctno_240000703_b` DISABLE KEYS */;
/*!40000 ALTER TABLE `temp_waterworks_consumption_acctno_240000703_b` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tmp_firstbill`
--

DROP TABLE IF EXISTS `tmp_firstbill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tmp_firstbill` (
  `acctid` varchar(50) NOT NULL,
  `billid` varchar(50) NOT NULL,
  PRIMARY KEY (`acctid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tmp_firstbill`
--

LOCK TABLES `tmp_firstbill` WRITE;
/*!40000 ALTER TABLE `tmp_firstbill` DISABLE KEYS */;
/*!40000 ALTER TABLE `tmp_firstbill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `vw_waterworks_account`
--

DROP TABLE IF EXISTS `vw_waterworks_account`;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_account`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_waterworks_account` (
  `objid` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `acctno` tinyint NOT NULL,
  `acctinfoid` tinyint NOT NULL,
  `dtstarted` tinyint NOT NULL,
  `applicationid` tinyint NOT NULL,
  `remarks` tinyint NOT NULL,
  `ukey` tinyint NOT NULL,
  `seqno` tinyint NOT NULL,
  `billid` tinyint NOT NULL,
  `lng` tinyint NOT NULL,
  `lat` tinyint NOT NULL,
  `excludeinbatch` tinyint NOT NULL,
  `acctname` tinyint NOT NULL,
  `owner_objid` tinyint NOT NULL,
  `owner_name` tinyint NOT NULL,
  `address_type` tinyint NOT NULL,
  `address_text` tinyint NOT NULL,
  `address_barangay_objid` tinyint NOT NULL,
  `address_barangay_name` tinyint NOT NULL,
  `address_city` tinyint NOT NULL,
  `address_province` tinyint NOT NULL,
  `address_municipality` tinyint NOT NULL,
  `address_unitno` tinyint NOT NULL,
  `address_street` tinyint NOT NULL,
  `address_subdivision` tinyint NOT NULL,
  `address_bldgno` tinyint NOT NULL,
  `address_bldgname` tinyint NOT NULL,
  `address_pin` tinyint NOT NULL,
  `stuboutid` tinyint NOT NULL,
  `subareaid` tinyint NOT NULL,
  `meterid` tinyint NOT NULL,
  `classificationid` tinyint NOT NULL,
  `units` tinyint NOT NULL,
  `attributes` tinyint NOT NULL,
  `meterstate` tinyint NOT NULL,
  `mobileno` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `phoneno` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_waterworks_account_info`
--

DROP TABLE IF EXISTS `vw_waterworks_account_info`;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_account_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_waterworks_account_info` (
  `objid` tinyint NOT NULL,
  `acctname` tinyint NOT NULL,
  `owner_objid` tinyint NOT NULL,
  `owner_name` tinyint NOT NULL,
  `address_type` tinyint NOT NULL,
  `address_text` tinyint NOT NULL,
  `address_barangay_objid` tinyint NOT NULL,
  `address_barangay_name` tinyint NOT NULL,
  `address_city` tinyint NOT NULL,
  `address_province` tinyint NOT NULL,
  `address_municipality` tinyint NOT NULL,
  `address_unitno` tinyint NOT NULL,
  `address_street` tinyint NOT NULL,
  `address_subdivision` tinyint NOT NULL,
  `address_bldgno` tinyint NOT NULL,
  `address_bldgname` tinyint NOT NULL,
  `address_pin` tinyint NOT NULL,
  `stuboutid` tinyint NOT NULL,
  `subareaid` tinyint NOT NULL,
  `meterid` tinyint NOT NULL,
  `classification_objid` tinyint NOT NULL,
  `units` tinyint NOT NULL,
  `attributes` tinyint NOT NULL,
  `meterstate` tinyint NOT NULL,
  `mobileno` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `phoneno` tinyint NOT NULL,
  `meter_serialno` tinyint NOT NULL,
  `meter_capacity` tinyint NOT NULL,
  `meter_brand` tinyint NOT NULL,
  `meter_size` tinyint NOT NULL,
  `subarea_code` tinyint NOT NULL,
  `subarea_area_code` tinyint NOT NULL,
  `stubout_code` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_waterworks_application`
--

DROP TABLE IF EXISTS `vw_waterworks_application`;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_application`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_waterworks_application` (
  `objid` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `dtcreated` tinyint NOT NULL,
  `appno` tinyint NOT NULL,
  `apptype` tinyint NOT NULL,
  `acctid` tinyint NOT NULL,
  `acctinfoid` tinyint NOT NULL,
  `taskid` tinyint NOT NULL,
  `acctno` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_waterworks_batch_billing`
--

DROP TABLE IF EXISTS `vw_waterworks_batch_billing`;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_batch_billing`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_waterworks_batch_billing` (
  `objid` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `subareaid` tinyint NOT NULL,
  `dtposted` tinyint NOT NULL,
  `reader_objid` tinyint NOT NULL,
  `reader_name` tinyint NOT NULL,
  `taskid` tinyint NOT NULL,
  `readingdate` tinyint NOT NULL,
  `year` tinyint NOT NULL,
  `month` tinyint NOT NULL,
  `scheduleid` tinyint NOT NULL,
  `batchno` tinyint NOT NULL,
  `monthname` tinyint NOT NULL,
  `subarea_schedulegroupid` tinyint NOT NULL,
  `subarea_code` tinyint NOT NULL,
  `subarea_barangay_name` tinyint NOT NULL,
  `area_code` tinyint NOT NULL,
  `period_fromdate` tinyint NOT NULL,
  `period_todate` tinyint NOT NULL,
  `period_readingdate` tinyint NOT NULL,
  `period_readingenddate` tinyint NOT NULL,
  `period_billdate` tinyint NOT NULL,
  `period_billingenddate` tinyint NOT NULL,
  `period_discdate` tinyint NOT NULL,
  `period_duedate` tinyint NOT NULL,
  `period_billexpirydate` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_waterworks_batch_billing_error`
--

DROP TABLE IF EXISTS `vw_waterworks_batch_billing_error`;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_batch_billing_error`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_waterworks_batch_billing_error` (
  `objid` tinyint NOT NULL,
  `batchid` tinyint NOT NULL,
  `billid` tinyint NOT NULL,
  `acctid` tinyint NOT NULL,
  `action` tinyint NOT NULL,
  `errmsg` tinyint NOT NULL,
  `seqno` tinyint NOT NULL,
  `acctno` tinyint NOT NULL,
  `acctname` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_waterworks_bill`
--

DROP TABLE IF EXISTS `vw_waterworks_bill`;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_bill`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_waterworks_bill` (
  `objid` tinyint NOT NULL,
  `billno` tinyint NOT NULL,
  `billdate` tinyint NOT NULL,
  `acctid` tinyint NOT NULL,
  `acctinfoid` tinyint NOT NULL,
  `batchid` tinyint NOT NULL,
  `txnmode` tinyint NOT NULL,
  `expirydate` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `balanceforward` tinyint NOT NULL,
  `billed` tinyint NOT NULL,
  `billrefno` tinyint NOT NULL,
  `printed` tinyint NOT NULL,
  `remarks` tinyint NOT NULL,
  `createdby_objid` tinyint NOT NULL,
  `createdby_name` tinyint NOT NULL,
  `dtcreated` tinyint NOT NULL,
  `validitydate` tinyint NOT NULL,
  `initial` tinyint NOT NULL,
  `step` tinyint NOT NULL,
  `consumptionid` tinyint NOT NULL,
  `totalcredits` tinyint NOT NULL,
  `totalprevunpaid` tinyint NOT NULL,
  `totalbillunpaid` tinyint NOT NULL,
  `billamount` tinyint NOT NULL,
  `totalsurcharge` tinyint NOT NULL,
  `totalpayment` tinyint NOT NULL,
  `totaldiscount` tinyint NOT NULL,
  `year` tinyint NOT NULL,
  `month` tinyint NOT NULL,
  `scheduleid` tinyint NOT NULL,
  `monthname` tinyint NOT NULL,
  `acctno` tinyint NOT NULL,
  `acctname` tinyint NOT NULL,
  `acctstate` tinyint NOT NULL,
  `seqno` tinyint NOT NULL,
  `subareaid` tinyint NOT NULL,
  `address_text` tinyint NOT NULL,
  `classificationid` tinyint NOT NULL,
  `stuboutid` tinyint NOT NULL,
  `meterid` tinyint NOT NULL,
  `meterstate` tinyint NOT NULL,
  `subarea_schedulegroupid` tinyint NOT NULL,
  `subarea_code` tinyint NOT NULL,
  `subarea_barangay_name` tinyint NOT NULL,
  `area_code` tinyint NOT NULL,
  `period_fromdate` tinyint NOT NULL,
  `period_todate` tinyint NOT NULL,
  `period_readingdate` tinyint NOT NULL,
  `period_readingenddate` tinyint NOT NULL,
  `period_billdate` tinyint NOT NULL,
  `period_billingenddate` tinyint NOT NULL,
  `period_discdate` tinyint NOT NULL,
  `period_duedate` tinyint NOT NULL,
  `period_billexpirydate` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_waterworks_bill_consumption`
--

DROP TABLE IF EXISTS `vw_waterworks_bill_consumption`;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_bill_consumption`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_waterworks_bill_consumption` (
  `objid` tinyint NOT NULL,
  `billid` tinyint NOT NULL,
  `reading` tinyint NOT NULL,
  `volume` tinyint NOT NULL,
  `amount` tinyint NOT NULL,
  `hold` tinyint NOT NULL,
  `reason` tinyint NOT NULL,
  `readingdate` tinyint NOT NULL,
  `reader_objid` tinyint NOT NULL,
  `reader_name` tinyint NOT NULL,
  `prev_reading` tinyint NOT NULL,
  `batchid` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_waterworks_change_request`
--

DROP TABLE IF EXISTS `vw_waterworks_change_request`;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_change_request`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_waterworks_change_request` (
  `objid` tinyint NOT NULL,
  `controlno` tinyint NOT NULL,
  `apptype` tinyint NOT NULL,
  `dtcreated` tinyint NOT NULL,
  `acctid` tinyint NOT NULL,
  `acctinfoid` tinyint NOT NULL,
  `newacctinfoid` tinyint NOT NULL,
  `reason` tinyint NOT NULL,
  `taskid` tinyint NOT NULL,
  `account_acctno` tinyint NOT NULL,
  `task_state` tinyint NOT NULL,
  `task_startdate` tinyint NOT NULL,
  `task_enddate` tinyint NOT NULL,
  `task_assignee_objid` tinyint NOT NULL,
  `task_assignee_name` tinyint NOT NULL,
  `task_actor_objid` tinyint NOT NULL,
  `task_actor_name` tinyint NOT NULL,
  `task_title` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_waterworks_compromise`
--

DROP TABLE IF EXISTS `vw_waterworks_compromise`;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_compromise`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_waterworks_compromise` (
  `objid` tinyint NOT NULL,
  `controlno` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `dtcreated` tinyint NOT NULL,
  `acctid` tinyint NOT NULL,
  `acctinfoid` tinyint NOT NULL,
  `particulars` tinyint NOT NULL,
  `taskid` tinyint NOT NULL,
  `amount` tinyint NOT NULL,
  `downpaymentrate` tinyint NOT NULL,
  `downpayment` tinyint NOT NULL,
  `term` tinyint NOT NULL,
  `startduedate` tinyint NOT NULL,
  `balance` tinyint NOT NULL,
  `acctno` tinyint NOT NULL,
  `task_state` tinyint NOT NULL,
  `task_startdate` tinyint NOT NULL,
  `task_enddate` tinyint NOT NULL,
  `task_assignee_objid` tinyint NOT NULL,
  `task_assignee_name` tinyint NOT NULL,
  `task_actor_objid` tinyint NOT NULL,
  `task_actor_name` tinyint NOT NULL,
  `task_title` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_waterworks_compromise_billitem`
--

DROP TABLE IF EXISTS `vw_waterworks_compromise_billitem`;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_compromise_billitem`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_waterworks_compromise_billitem` (
  `objid` tinyint NOT NULL,
  `parentid` tinyint NOT NULL,
  `billitemid` tinyint NOT NULL,
  `amount` tinyint NOT NULL,
  `amtpaid` tinyint NOT NULL,
  `year` tinyint NOT NULL,
  `month` tinyint NOT NULL,
  `item_title` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_waterworks_consumption`
--

DROP TABLE IF EXISTS `vw_waterworks_consumption`;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_consumption`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_waterworks_consumption` (
  `objid` tinyint NOT NULL,
  `acctid` tinyint NOT NULL,
  `meterid` tinyint NOT NULL,
  `year` tinyint NOT NULL,
  `month` tinyint NOT NULL,
  `billid` tinyint NOT NULL,
  `txnmode` tinyint NOT NULL,
  `reading` tinyint NOT NULL,
  `volume` tinyint NOT NULL,
  `amount` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `hold` tinyint NOT NULL,
  `reason` tinyint NOT NULL,
  `reader_objid` tinyint NOT NULL,
  `reader_name` tinyint NOT NULL,
  `readingdate` tinyint NOT NULL,
  `prev_reading` tinyint NOT NULL,
  `prev_month` tinyint NOT NULL,
  `prev_year` tinyint NOT NULL,
  `batchid` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_waterworks_disconnection`
--

DROP TABLE IF EXISTS `vw_waterworks_disconnection`;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_disconnection`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_waterworks_disconnection` (
  `objid` tinyint NOT NULL,
  `controlno` tinyint NOT NULL,
  `dtcreated` tinyint NOT NULL,
  `acctid` tinyint NOT NULL,
  `acctinfoid` tinyint NOT NULL,
  `reason` tinyint NOT NULL,
  `taskid` tinyint NOT NULL,
  `amountdue` tinyint NOT NULL,
  `account_acctno` tinyint NOT NULL,
  `task_state` tinyint NOT NULL,
  `task_startdate` tinyint NOT NULL,
  `task_enddate` tinyint NOT NULL,
  `task_assignee_objid` tinyint NOT NULL,
  `task_assignee_name` tinyint NOT NULL,
  `task_actor_objid` tinyint NOT NULL,
  `task_actor_name` tinyint NOT NULL,
  `task_title` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `waterworks_account`
--

DROP TABLE IF EXISTS `waterworks_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_account` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `acctno` varchar(50) DEFAULT NULL,
  `acctinfoid` varchar(50) DEFAULT NULL,
  `dtstarted` date DEFAULT NULL,
  `applicationid` varchar(50) DEFAULT NULL,
  `remarks` text,
  `ukey` varchar(50) NOT NULL DEFAULT '',
  `seqno` int(11) DEFAULT NULL,
  `billid` varchar(50) DEFAULT NULL,
  `lng` float(255,0) DEFAULT NULL,
  `lat` float(255,0) DEFAULT NULL,
  `excludeinbatch` int(10) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_acctno` (`acctno`,`ukey`) USING BTREE,
  KEY `ix_acctno` (`acctno`) USING BTREE,
  KEY `ix_applicationid` (`applicationid`) USING BTREE,
  KEY `fk_waterworks_account_acctinfoid` (`acctinfoid`) USING BTREE,
  KEY `fk_waterworks_account_billid` (`billid`) USING BTREE,
  CONSTRAINT `fk_waterworks_account_acctinfoid` FOREIGN KEY (`acctinfoid`) REFERENCES `waterworks_account_info` (`objid`),
  CONSTRAINT `fk_waterworks_account_applicationid` FOREIGN KEY (`applicationid`) REFERENCES `waterworks_application` (`objid`),
  CONSTRAINT `fk_waterworks_account_billid` FOREIGN KEY (`billid`) REFERENCES `waterworks_bill` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_account`
--

LOCK TABLES `waterworks_account` WRITE;
/*!40000 ALTER TABLE `waterworks_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_account_attribute`
--

DROP TABLE IF EXISTS `waterworks_account_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_account_attribute` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `attribute_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_account_attribute`
--

LOCK TABLES `waterworks_account_attribute` WRITE;
/*!40000 ALTER TABLE `waterworks_account_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_account_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_account_info`
--

DROP TABLE IF EXISTS `waterworks_account_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_account_info` (
  `objid` varchar(50) NOT NULL,
  `acctname` varchar(255) DEFAULT NULL,
  `owner_objid` varchar(50) DEFAULT NULL,
  `owner_name` varchar(255) DEFAULT NULL,
  `address_type` varchar(50) DEFAULT NULL,
  `address_barangay_objid` varchar(50) DEFAULT NULL,
  `address_barangay_name` varchar(50) DEFAULT NULL,
  `address_text` varchar(255) DEFAULT NULL,
  `address_city` varchar(50) DEFAULT NULL,
  `address_province` varchar(50) DEFAULT NULL,
  `address_municipality` varchar(50) DEFAULT NULL,
  `address_unitno` varchar(50) DEFAULT NULL,
  `address_street` varchar(50) DEFAULT NULL,
  `address_subdivision` varchar(50) DEFAULT NULL,
  `address_bldgno` varchar(50) DEFAULT NULL,
  `address_bldgname` varchar(50) DEFAULT NULL,
  `address_pin` varchar(50) DEFAULT NULL,
  `meterid` varchar(50) DEFAULT NULL,
  `classificationid` varchar(50) DEFAULT NULL,
  `units` int(11) DEFAULT NULL,
  `stuboutid` varchar(50) DEFAULT NULL,
  `subareaid` varchar(50) DEFAULT NULL,
  `attributes` varchar(500) DEFAULT NULL,
  `meterstate` varchar(50) DEFAULT NULL,
  `mobileno` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phoneno` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_waterworks_account_classification` (`classificationid`) USING BTREE,
  KEY `ix_acctname` (`acctname`) USING BTREE,
  KEY `ix_owner_objid` (`owner_objid`) USING BTREE,
  KEY `ix_meterid` (`meterid`) USING BTREE,
  KEY `fk_waterworks_account_stuboutid` (`stuboutid`) USING BTREE,
  KEY `fk_waterworks_account_subareaid` (`subareaid`) USING BTREE,
  KEY `fk_waterworks_account_meter` (`meterid`) USING BTREE,
  CONSTRAINT `waterworks_account_info_ibfk_2` FOREIGN KEY (`classificationid`) REFERENCES `waterworks_classification` (`objid`),
  CONSTRAINT `waterworks_account_info_ibfk_3` FOREIGN KEY (`meterid`) REFERENCES `waterworks_meter` (`objid`),
  CONSTRAINT `waterworks_account_info_ibfk_4` FOREIGN KEY (`stuboutid`) REFERENCES `waterworks_stubout` (`objid`),
  CONSTRAINT `waterworks_account_info_ibfk_5` FOREIGN KEY (`subareaid`) REFERENCES `waterworks_subarea` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_account_info`
--

LOCK TABLES `waterworks_account_info` WRITE;
/*!40000 ALTER TABLE `waterworks_account_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_account_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_application`
--

DROP TABLE IF EXISTS `waterworks_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_application` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `dtcreated` date DEFAULT NULL,
  `appno` varchar(50) DEFAULT NULL,
  `apptype` varchar(50) DEFAULT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `acctinfoid` varchar(50) DEFAULT NULL,
  `taskid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_waterworks_newconnection_taskid` (`taskid`) USING BTREE,
  KEY `fk_waterworks_newconnection_acctid` (`acctid`) USING BTREE,
  KEY `fk_waterworks_newconnection_acctinfoid` (`acctinfoid`) USING BTREE,
  CONSTRAINT `fk_waterworks_application_acctid` FOREIGN KEY (`acctid`) REFERENCES `waterworks_account` (`objid`),
  CONSTRAINT `fk_waterworks_application_acctinfoid` FOREIGN KEY (`acctinfoid`) REFERENCES `waterworks_account_info` (`objid`),
  CONSTRAINT `fk_waterworks_application_taskid` FOREIGN KEY (`taskid`) REFERENCES `waterworks_application_task` (`taskid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_application`
--

LOCK TABLES `waterworks_application` WRITE;
/*!40000 ALTER TABLE `waterworks_application` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_application_fee`
--

DROP TABLE IF EXISTS `waterworks_application_fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_application_fee` (
  `objid` varchar(50) NOT NULL,
  `appid` varchar(50) DEFAULT NULL,
  `itemid` varchar(50) DEFAULT NULL,
  `particulars` varchar(255) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `amtpaid` decimal(16,2) DEFAULT NULL,
  `installmentid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_application_fee_application` (`appid`) USING BTREE,
  KEY `fk_waterworks_application_fee_itemid` (`itemid`),
  CONSTRAINT `fk_waterworks_application_fee_appid` FOREIGN KEY (`appid`) REFERENCES `waterworks_application` (`objid`),
  CONSTRAINT `fk_waterworks_application_fee_itemid` FOREIGN KEY (`itemid`) REFERENCES `waterworks_itemaccount` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_application_fee`
--

LOCK TABLES `waterworks_application_fee` WRITE;
/*!40000 ALTER TABLE `waterworks_application_fee` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_application_fee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_application_task`
--

DROP TABLE IF EXISTS `waterworks_application_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_application_task` (
  `taskid` varchar(50) NOT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `parentprocessid` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `assignee_objid` varchar(50) DEFAULT NULL,
  `assignee_name` varchar(100) DEFAULT NULL,
  `actor_objid` varchar(50) DEFAULT NULL,
  `actor_name` varchar(100) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `prevtaskid` varchar(50) DEFAULT NULL,
  `dtcreated` datetime DEFAULT NULL,
  PRIMARY KEY (`taskid`) USING BTREE,
  KEY `ix_refid` (`refid`) USING BTREE,
  CONSTRAINT `fk_waterworks_newconnection_task_refid` FOREIGN KEY (`refid`) REFERENCES `waterworks_application` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_application_task`
--

LOCK TABLES `waterworks_application_task` WRITE;
/*!40000 ALTER TABLE `waterworks_application_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_application_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_area`
--

DROP TABLE IF EXISTS `waterworks_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_area` (
  `objid` varchar(50) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_code` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_area`
--

LOCK TABLES `waterworks_area` WRITE;
/*!40000 ALTER TABLE `waterworks_area` DISABLE KEYS */;
INSERT INTO `waterworks_area` VALUES ('001','001');
/*!40000 ALTER TABLE `waterworks_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_attribute`
--

DROP TABLE IF EXISTS `waterworks_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_attribute` (
  `name` varchar(50) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_attribute`
--

LOCK TABLES `waterworks_attribute` WRITE;
/*!40000 ALTER TABLE `waterworks_attribute` DISABLE KEYS */;
INSERT INTO `waterworks_attribute` VALUES ('LOT_DONOR','LOT DONOR'),('SENIOR','SENIOR CITIZEN'),('SUBDIVISION','SUBDIVISION');
/*!40000 ALTER TABLE `waterworks_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_batch_billing`
--

DROP TABLE IF EXISTS `waterworks_batch_billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_batch_billing` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `subareaid` varchar(50) DEFAULT NULL,
  `dtposted` datetime DEFAULT NULL,
  `reader_objid` varchar(50) DEFAULT NULL,
  `reader_name` varchar(255) DEFAULT NULL,
  `taskid` varchar(50) DEFAULT NULL,
  `readingdate` date DEFAULT NULL,
  `year` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `scheduleid` varchar(50) NOT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_subareaid_periodid` (`subareaid`,`year`,`month`) USING BTREE,
  KEY `ix_zoneid` (`subareaid`) USING BTREE,
  KEY `ix_dtposted` (`dtposted`) USING BTREE,
  KEY `ix_reader_objid` (`reader_objid`) USING BTREE,
  KEY `ix_taskid` (`taskid`) USING BTREE,
  KEY `ix_readingdate` (`readingdate`) USING BTREE,
  CONSTRAINT `fk_waterworks_batch_billing_subareaid` FOREIGN KEY (`subareaid`) REFERENCES `waterworks_subarea` (`objid`),
  CONSTRAINT `fk_waterworks_batch_billing_taskid` FOREIGN KEY (`taskid`) REFERENCES `waterworks_batch_billing_task` (`taskid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_batch_billing`
--

LOCK TABLES `waterworks_batch_billing` WRITE;
/*!40000 ALTER TABLE `waterworks_batch_billing` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_batch_billing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_batch_billing_error`
--

DROP TABLE IF EXISTS `waterworks_batch_billing_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_batch_billing_error` (
  `objid` varchar(50) NOT NULL,
  `batchid` varchar(50) DEFAULT NULL,
  `billid` varchar(50) DEFAULT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  `errmsg` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_waterworks_batch_blling_error_batchid` (`batchid`) USING BTREE,
  KEY `fk_waterworks_batch_billing_error_acctid` (`acctid`) USING BTREE,
  KEY `fk_waterworks_batch_billing_error_billid` (`billid`) USING BTREE,
  CONSTRAINT `fk_waterworks_batch_billing_error_acctid` FOREIGN KEY (`acctid`) REFERENCES `waterworks_account` (`objid`),
  CONSTRAINT `fk_waterworks_batch_billing_error_billid` FOREIGN KEY (`billid`) REFERENCES `waterworks_bill` (`objid`),
  CONSTRAINT `fk_waterworks_batch_blling_error_batchid` FOREIGN KEY (`batchid`) REFERENCES `waterworks_batch_billing` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_batch_billing_error`
--

LOCK TABLES `waterworks_batch_billing_error` WRITE;
/*!40000 ALTER TABLE `waterworks_batch_billing_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_batch_billing_error` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_batch_billing_task`
--

DROP TABLE IF EXISTS `waterworks_batch_billing_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_batch_billing_task` (
  `taskid` varchar(50) NOT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `parentprocessid` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `assignee_objid` varchar(50) DEFAULT NULL,
  `assignee_name` varchar(100) DEFAULT NULL,
  `actor_objid` varchar(50) DEFAULT NULL,
  `actor_name` varchar(100) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `dtcreated` datetime DEFAULT NULL,
  `prevtaskid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`taskid`) USING BTREE,
  KEY `ix_refid` (`refid`) USING BTREE,
  CONSTRAINT `fk_waterworks_batch_billing_task_refid` FOREIGN KEY (`refid`) REFERENCES `waterworks_batch_billing` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_batch_billing_task`
--

LOCK TABLES `waterworks_batch_billing_task` WRITE;
/*!40000 ALTER TABLE `waterworks_batch_billing_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_batch_billing_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_bill`
--

DROP TABLE IF EXISTS `waterworks_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_bill` (
  `objid` varchar(50) NOT NULL,
  `billno` varchar(50) DEFAULT NULL,
  `billdate` date DEFAULT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `acctinfoid` varchar(50) DEFAULT NULL,
  `batchid` varchar(50) DEFAULT NULL,
  `txnmode` varchar(10) DEFAULT NULL,
  `expirydate` date DEFAULT NULL,
  `state` varchar(32) DEFAULT NULL,
  `balanceforward` decimal(16,2) DEFAULT NULL,
  `billed` int(11) DEFAULT NULL,
  `billrefno` varchar(50) DEFAULT NULL,
  `printed` int(11) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `createdby_objid` varchar(50) DEFAULT NULL,
  `createdby_name` varchar(255) DEFAULT NULL,
  `dtcreated` datetime DEFAULT NULL,
  `validitydate` date DEFAULT NULL,
  `initial` int(255) DEFAULT NULL,
  `step` int(10) DEFAULT NULL,
  `consumptionid` varchar(50) DEFAULT NULL,
  `totalcredits` decimal(16,2) DEFAULT '0.00',
  `totalprevunpaid` decimal(16,2) DEFAULT '0.00',
  `totalbillunpaid` decimal(16,2) DEFAULT '0.00',
  `billamount` decimal(16,2) DEFAULT '0.00',
  `totalsurcharge` decimal(16,2) DEFAULT '0.00',
  `totalpayment` decimal(16,2) DEFAULT '0.00',
  `totaldiscount` decimal(16,2) DEFAULT '0.00',
  `year` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `scheduleid` varchar(50) NOT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_waterworks_bill_acctid_year_month` (`acctid`,`year`,`month`) USING BTREE,
  KEY `ix_batchid` (`batchid`) USING BTREE,
  KEY `fk_waterworks_bill_acctid` (`acctid`) USING BTREE,
  KEY `fk_waterworks_bill_acctinfoid` (`acctinfoid`) USING BTREE,
  KEY `fk_waterworks_bill_consumptionid` (`consumptionid`) USING BTREE,
  CONSTRAINT `fk_waterworks_bill_acctid` FOREIGN KEY (`acctid`) REFERENCES `waterworks_account` (`objid`),
  CONSTRAINT `fk_waterworks_bill_acctinfoid` FOREIGN KEY (`acctinfoid`) REFERENCES `waterworks_account_info` (`objid`),
  CONSTRAINT `fk_waterworks_bill_batchid` FOREIGN KEY (`batchid`) REFERENCES `waterworks_batch_billing` (`objid`),
  CONSTRAINT `fk_waterworks_bill_consumptionid` FOREIGN KEY (`consumptionid`) REFERENCES `waterworks_consumption` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_bill`
--

LOCK TABLES `waterworks_bill` WRITE;
/*!40000 ALTER TABLE `waterworks_bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_billing_period`
--

DROP TABLE IF EXISTS `waterworks_billing_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_billing_period` (
  `objid` varchar(50) NOT NULL,
  `scheduleid` varchar(50) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `month` int(11) DEFAULT NULL,
  `fromdate` date DEFAULT NULL,
  `todate` date DEFAULT NULL,
  `readingdate` date DEFAULT NULL,
  `readingenddate` date DEFAULT NULL,
  `billdate` date DEFAULT NULL,
  `billingenddate` date DEFAULT NULL,
  `discdate` date DEFAULT NULL,
  `duedate` date DEFAULT NULL,
  `billexpirydate` date DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_scheduleid_year_month` (`scheduleid`,`year`,`month`) USING BTREE,
  KEY `ix_schedule_objid` (`scheduleid`) USING BTREE,
  KEY `ix_year` (`year`) USING BTREE,
  KEY `ix_month` (`month`) USING BTREE,
  KEY `ix_readingdate` (`readingdate`) USING BTREE,
  KEY `objid` (`objid`,`scheduleid`) USING BTREE,
  CONSTRAINT `fk_waterworks_billing_period_scheduleid` FOREIGN KEY (`scheduleid`) REFERENCES `waterworks_schedule_group` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_billing_period`
--

LOCK TABLES `waterworks_billing_period` WRITE;
/*!40000 ALTER TABLE `waterworks_billing_period` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_billing_period` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_billitem`
--

DROP TABLE IF EXISTS `waterworks_billitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_billitem` (
  `objid` varchar(50) NOT NULL,
  `acctid` varchar(50) NOT NULL,
  `year` int(4) NOT NULL,
  `month` int(2) NOT NULL,
  `itemid` varchar(50) NOT NULL,
  `billid` varchar(50) DEFAULT NULL,
  `particulars` varchar(255) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `amtpaid` decimal(16,2) DEFAULT NULL,
  `discount` decimal(16,2) DEFAULT NULL,
  `system` int(255) DEFAULT NULL,
  `consumptionid` varchar(50) DEFAULT NULL,
  `billed` int(255) DEFAULT NULL,
  `txndate` date DEFAULT NULL,
  `recurringfeeid` varchar(50) DEFAULT NULL,
  `refbillid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_waterworks_billitem_mindex` (`billid`,`itemid`,`year`,`month`) USING BTREE,
  KEY `fk_waterworks_billitem_consumptionid` (`consumptionid`) USING BTREE,
  KEY `fk_waterworks_billitem_itemid` (`itemid`) USING BTREE,
  KEY `idx_waterworks_billitem_year` (`year`) USING BTREE,
  KEY `idx_waterworks_billitem_month` (`month`) USING BTREE,
  KEY `fk_waterworks_billitem_acctid` (`acctid`) USING BTREE,
  KEY `fk_waterworks_billitem_recurringfeeid` (`recurringfeeid`) USING BTREE,
  KEY `fk_waterworks_billitem_refbillid` (`refbillid`),
  CONSTRAINT `fk_waterworks_billitem_acctid` FOREIGN KEY (`acctid`) REFERENCES `waterworks_account` (`objid`),
  CONSTRAINT `fk_waterworks_billitem_billid` FOREIGN KEY (`billid`) REFERENCES `waterworks_bill` (`objid`),
  CONSTRAINT `fk_waterworks_billitem_consumptionid` FOREIGN KEY (`consumptionid`) REFERENCES `waterworks_consumption` (`objid`),
  CONSTRAINT `fk_waterworks_billitem_itemid` FOREIGN KEY (`itemid`) REFERENCES `waterworks_itemaccount` (`objid`),
  CONSTRAINT `fk_waterworks_billitem_recurringfeeid` FOREIGN KEY (`recurringfeeid`) REFERENCES `waterworks_recurringfee` (`objid`),
  CONSTRAINT `fk_waterworks_billitem_refbillid` FOREIGN KEY (`refbillid`) REFERENCES `waterworks_bill` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_billitem`
--

LOCK TABLES `waterworks_billitem` WRITE;
/*!40000 ALTER TABLE `waterworks_billitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_billitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_change_request`
--

DROP TABLE IF EXISTS `waterworks_change_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_change_request` (
  `objid` varchar(50) NOT NULL,
  `controlno` varchar(50) DEFAULT NULL,
  `apptype` varchar(50) DEFAULT NULL,
  `dtcreated` date DEFAULT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `acctinfoid` varchar(50) DEFAULT NULL,
  `newacctinfoid` varchar(50) DEFAULT NULL,
  `reason` varchar(50) DEFAULT NULL,
  `taskid` varchar(50) DEFAULT NULL,
  UNIQUE KEY `uix_waterworks_change_request_controlno` (`controlno`) USING BTREE,
  KEY `objid` (`objid`) USING BTREE,
  KEY `fk_waterworks_change_request_newacctinfoid` (`newacctinfoid`) USING BTREE,
  KEY `fk_waterworks_change_request_acctid` (`acctid`) USING BTREE,
  KEY `fk_waterworks_change_request_taskid` (`taskid`) USING BTREE,
  KEY `fk_waterworks_change_request_oldacctinfoid` (`acctinfoid`) USING BTREE,
  CONSTRAINT `fk_waterworks_change_request_acctid` FOREIGN KEY (`acctid`) REFERENCES `waterworks_account` (`objid`),
  CONSTRAINT `fk_waterworks_change_request_newacctinfoid` FOREIGN KEY (`newacctinfoid`) REFERENCES `waterworks_account_info` (`objid`),
  CONSTRAINT `fk_waterworks_change_request_oldacctinfoid` FOREIGN KEY (`acctinfoid`) REFERENCES `waterworks_account_info` (`objid`),
  CONSTRAINT `fk_waterworks_change_request_taskid` FOREIGN KEY (`taskid`) REFERENCES `waterworks_change_request_task` (`taskid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_change_request`
--

LOCK TABLES `waterworks_change_request` WRITE;
/*!40000 ALTER TABLE `waterworks_change_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_change_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_change_request_task`
--

DROP TABLE IF EXISTS `waterworks_change_request_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_change_request_task` (
  `taskid` varchar(50) NOT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `parentprocessid` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `assignee_objid` varchar(50) DEFAULT NULL,
  `assignee_name` varchar(100) DEFAULT NULL,
  `actor_objid` varchar(50) DEFAULT NULL,
  `actor_name` varchar(100) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `dtcreated` datetime DEFAULT NULL,
  `prevtaskid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`taskid`) USING BTREE,
  KEY `ix_refid` (`refid`) USING BTREE,
  CONSTRAINT `waterworks_change_request_task_refid` FOREIGN KEY (`refid`) REFERENCES `waterworks_change_request` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_change_request_task`
--

LOCK TABLES `waterworks_change_request_task` WRITE;
/*!40000 ALTER TABLE `waterworks_change_request_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_change_request_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_classification`
--

DROP TABLE IF EXISTS `waterworks_classification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_classification` (
  `objid` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_classification`
--

LOCK TABLES `waterworks_classification` WRITE;
/*!40000 ALTER TABLE `waterworks_classification` DISABLE KEYS */;
INSERT INTO `waterworks_classification` VALUES ('BULK','BULK'),('COMMERCIAL','COMMERCIAL'),('GOVERNMENT','GOVERNMENT'),('INDUSTRIAL','INDUSTRIAL'),('RESIDENTIAL','RESIDENTIAL');
/*!40000 ALTER TABLE `waterworks_classification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_compromise`
--

DROP TABLE IF EXISTS `waterworks_compromise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_compromise` (
  `objid` varchar(50) NOT NULL,
  `controlno` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `dtcreated` date DEFAULT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `acctinfoid` varchar(50) DEFAULT NULL,
  `particulars` varchar(255) DEFAULT NULL,
  `taskid` varchar(50) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `downpaymentrate` decimal(16,2) DEFAULT NULL,
  `downpayment` decimal(16,2) DEFAULT NULL,
  `term` int(255) DEFAULT NULL,
  `startduedate` date DEFAULT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_waterworks_change_request_controlno` (`controlno`),
  KEY `objid` (`objid`) USING BTREE,
  KEY `fk_waterworks_change_request_acctid` (`acctid`),
  KEY `fk_waterworks_change_request_taskid` (`taskid`),
  KEY `fk_waterworks_change_request_oldacctinfoid` (`acctinfoid`),
  CONSTRAINT `waterworks_compromise_acctid` FOREIGN KEY (`acctid`) REFERENCES `waterworks_account` (`objid`),
  CONSTRAINT `waterworks_compromise_acctinfoid` FOREIGN KEY (`acctinfoid`) REFERENCES `waterworks_account_info` (`objid`),
  CONSTRAINT `waterworks_compromise_taskid` FOREIGN KEY (`taskid`) REFERENCES `waterworks_compromise_task` (`taskid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_compromise`
--

LOCK TABLES `waterworks_compromise` WRITE;
/*!40000 ALTER TABLE `waterworks_compromise` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_compromise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_compromise_billitem`
--

DROP TABLE IF EXISTS `waterworks_compromise_billitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_compromise_billitem` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `billitemid` varchar(50) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `amtpaid` decimal(16,2) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_waterworks_compromise_billitem_billitemid` (`billitemid`),
  KEY `fk_waterworks_compromise_billitem_parentid` (`parentid`),
  CONSTRAINT `fk_waterworks_compromise_billitem_billitemid` FOREIGN KEY (`billitemid`) REFERENCES `waterworks_billitem` (`objid`),
  CONSTRAINT `fk_waterworks_compromise_billitem_parentid` FOREIGN KEY (`parentid`) REFERENCES `waterworks_compromise` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_compromise_billitem`
--

LOCK TABLES `waterworks_compromise_billitem` WRITE;
/*!40000 ALTER TABLE `waterworks_compromise_billitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_compromise_billitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_compromise_fee`
--

DROP TABLE IF EXISTS `waterworks_compromise_fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_compromise_fee` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `itemid` varchar(50) DEFAULT NULL,
  `particulars` varchar(255) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `amtpaid` decimal(16,2) DEFAULT NULL,
  `duedate` date DEFAULT NULL,
  `itemtype` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_application_fee_application` (`parentid`),
  KEY `waterworks_compromise_fee_itemid` (`itemid`),
  CONSTRAINT `waterworks_compromise_fee_itemid` FOREIGN KEY (`itemid`) REFERENCES `waterworks_itemaccount` (`objid`),
  CONSTRAINT `waterworks_compromise_fee_parentid` FOREIGN KEY (`parentid`) REFERENCES `waterworks_compromise` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_compromise_fee`
--

LOCK TABLES `waterworks_compromise_fee` WRITE;
/*!40000 ALTER TABLE `waterworks_compromise_fee` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_compromise_fee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_compromise_task`
--

DROP TABLE IF EXISTS `waterworks_compromise_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_compromise_task` (
  `taskid` varchar(50) NOT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `parentprocessid` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `assignee_objid` varchar(50) DEFAULT NULL,
  `assignee_name` varchar(100) DEFAULT NULL,
  `actor_objid` varchar(50) DEFAULT NULL,
  `actor_name` varchar(100) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `dtcreated` datetime DEFAULT NULL,
  `prevtaskid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`taskid`),
  KEY `ix_refid` (`refid`),
  CONSTRAINT `waterworks_compromise_task_refid` FOREIGN KEY (`refid`) REFERENCES `waterworks_compromise` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_compromise_task`
--

LOCK TABLES `waterworks_compromise_task` WRITE;
/*!40000 ALTER TABLE `waterworks_compromise_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_compromise_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_consumption`
--

DROP TABLE IF EXISTS `waterworks_consumption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_consumption` (
  `objid` varchar(50) NOT NULL,
  `acctid` varchar(50) NOT NULL,
  `meterid` varchar(50) DEFAULT NULL,
  `year` int(255) NOT NULL,
  `month` int(255) NOT NULL,
  `billid` varchar(50) DEFAULT NULL,
  `txnmode` varchar(50) DEFAULT NULL,
  `reading` int(11) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `state` varchar(32) DEFAULT NULL,
  `hold` int(11) NOT NULL DEFAULT '0',
  `reason` varchar(255) DEFAULT NULL,
  `reader_objid` varchar(50) DEFAULT NULL,
  `reader_name` varchar(255) DEFAULT NULL,
  `readingdate` date DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_acctid_year_month` (`acctid`,`year`,`month`,`meterid`),
  KEY `fk_waterworks_consumption_meterid` (`meterid`) USING BTREE,
  KEY `fk_waterworks_consumption_billid` (`billid`) USING BTREE,
  CONSTRAINT `fk_waterworks_consumption_acctid` FOREIGN KEY (`acctid`) REFERENCES `waterworks_account` (`objid`),
  CONSTRAINT `fk_waterworks_consumption_billid` FOREIGN KEY (`billid`) REFERENCES `waterworks_bill` (`objid`),
  CONSTRAINT `fk_waterworks_consumption_meterid` FOREIGN KEY (`meterid`) REFERENCES `waterworks_meter` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_consumption`
--

LOCK TABLES `waterworks_consumption` WRITE;
/*!40000 ALTER TABLE `waterworks_consumption` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_consumption` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_credit`
--

DROP TABLE IF EXISTS `waterworks_credit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_credit` (
  `objid` varchar(50) NOT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `paymentrefid` varchar(50) DEFAULT NULL,
  `dr` decimal(16,2) DEFAULT NULL,
  `cr` decimal(16,2) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `ix_acctid` (`acctid`) USING BTREE,
  KEY `fk_waterworks_credit_paymentrefid` (`paymentrefid`) USING BTREE,
  CONSTRAINT `fk_waterworks_credit_acctid` FOREIGN KEY (`acctid`) REFERENCES `waterworks_account` (`objid`),
  CONSTRAINT `fk_waterworks_credit_paymentrefid` FOREIGN KEY (`paymentrefid`) REFERENCES `waterworks_payment` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_credit`
--

LOCK TABLES `waterworks_credit` WRITE;
/*!40000 ALTER TABLE `waterworks_credit` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_credit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_disconnection`
--

DROP TABLE IF EXISTS `waterworks_disconnection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_disconnection` (
  `objid` varchar(50) NOT NULL,
  `controlno` varchar(50) DEFAULT NULL,
  `dtcreated` date DEFAULT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `acctinfoid` varchar(50) DEFAULT NULL,
  `reason` varchar(50) DEFAULT NULL,
  `taskid` varchar(50) DEFAULT NULL,
  `amountdue` decimal(16,2) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_waterworks_change_request_controlno` (`controlno`) USING BTREE,
  KEY `fk_waterworks_disconnection_acctid` (`acctid`) USING BTREE,
  KEY `fk_waterworks_disconnection_taskid` (`taskid`) USING BTREE,
  KEY `fk_waterworks_disconnection_acctinfoid` (`acctinfoid`) USING BTREE,
  CONSTRAINT `fk_waterworks_disconnection_acctid` FOREIGN KEY (`acctid`) REFERENCES `waterworks_account` (`objid`),
  CONSTRAINT `fk_waterworks_disconnection_acctinfoid` FOREIGN KEY (`acctinfoid`) REFERENCES `waterworks_account_info` (`objid`),
  CONSTRAINT `fk_waterworks_disconnection_taskid` FOREIGN KEY (`taskid`) REFERENCES `waterworks_disconnection_task` (`taskid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_disconnection`
--

LOCK TABLES `waterworks_disconnection` WRITE;
/*!40000 ALTER TABLE `waterworks_disconnection` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_disconnection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_disconnection_notice`
--

DROP TABLE IF EXISTS `waterworks_disconnection_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_disconnection_notice` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `acctinfoid` varchar(50) DEFAULT NULL,
  `dtcreated` date DEFAULT NULL,
  `createdby_objid` varchar(50) DEFAULT NULL,
  `createdby_name` varchar(255) DEFAULT NULL,
  `dtfiled` date DEFAULT NULL,
  `startyear` int(255) DEFAULT NULL,
  `startmonth` int(255) DEFAULT NULL,
  `endyear` int(255) DEFAULT NULL,
  `endmonth` int(255) DEFAULT NULL,
  `amtdue` decimal(16,2) DEFAULT NULL,
  `duedate` date DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_disconnection_notice`
--

LOCK TABLES `waterworks_disconnection_notice` WRITE;
/*!40000 ALTER TABLE `waterworks_disconnection_notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_disconnection_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_disconnection_task`
--

DROP TABLE IF EXISTS `waterworks_disconnection_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_disconnection_task` (
  `taskid` varchar(50) NOT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `parentprocessid` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `assignee_objid` varchar(50) DEFAULT NULL,
  `assignee_name` varchar(100) DEFAULT NULL,
  `actor_objid` varchar(50) DEFAULT NULL,
  `actor_name` varchar(100) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `dtcreated` datetime DEFAULT NULL,
  `prevtaskid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`taskid`) USING BTREE,
  KEY `ix_refid` (`refid`) USING BTREE,
  CONSTRAINT `waterworks_disconnection_task_refid` FOREIGN KEY (`refid`) REFERENCES `waterworks_disconnection` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_disconnection_task`
--

LOCK TABLES `waterworks_disconnection_task` WRITE;
/*!40000 ALTER TABLE `waterworks_disconnection_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_disconnection_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_itemaccount`
--

DROP TABLE IF EXISTS `waterworks_itemaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_itemaccount` (
  `objid` varchar(50) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `sortorder` int(10) DEFAULT NULL,
  `itemtype` varchar(50) DEFAULT NULL,
  `system` int(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_itemaccount`
--

LOCK TABLES `waterworks_itemaccount` WRITE;
/*!40000 ALTER TABLE `waterworks_itemaccount` DISABLE KEYS */;
INSERT INTO `waterworks_itemaccount` VALUES ('WATERFEE_ADV','WATER FEE ADVANCE PAYMENT',100,NULL,NULL),('WATER_FEE','WATER FEE',100,'WATER_FEE',1),('WATER_FEE_SURCHARGE','WATER SURCHARGE',300,'SURCHARGE',1);
/*!40000 ALTER TABLE `waterworks_itemaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_itemaccount_mapping`
--

DROP TABLE IF EXISTS `waterworks_itemaccount_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_itemaccount_mapping` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(255) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `fund_objid` varchar(50) DEFAULT NULL,
  `fund_title` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_waterworks_itemaccount_mapping_parentid` (`parentid`) USING BTREE,
  CONSTRAINT `fk_waterworks_itemaccount_mapping_parentid` FOREIGN KEY (`parentid`) REFERENCES `waterworks_itemaccount` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_itemaccount_mapping`
--

LOCK TABLES `waterworks_itemaccount_mapping` WRITE;
/*!40000 ALTER TABLE `waterworks_itemaccount_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_itemaccount_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_meter`
--

DROP TABLE IF EXISTS `waterworks_meter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_meter` (
  `objid` varchar(50) NOT NULL,
  `serialno` varchar(50) DEFAULT NULL,
  `brand` varchar(50) DEFAULT NULL,
  `sizeid` varchar(50) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `stocktype` varchar(50) DEFAULT NULL,
  `state` varchar(32) NOT NULL,
  `currentacctid` varchar(50) DEFAULT NULL,
  `ukey` varchar(50) NOT NULL DEFAULT '',
  `reading` int(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_serialno` (`serialno`,`ukey`) USING BTREE,
  KEY `ix_brand` (`brand`) USING BTREE,
  KEY `ix_sizeid` (`sizeid`) USING BTREE,
  KEY `ix_state` (`state`) USING BTREE,
  KEY `ix_currentacctid` (`currentacctid`) USING BTREE,
  CONSTRAINT `fk_waterworks_meter_currentacctid` FOREIGN KEY (`currentacctid`) REFERENCES `waterworks_account` (`objid`),
  CONSTRAINT `fk_waterworks_meter_sizeid` FOREIGN KEY (`sizeid`) REFERENCES `waterworks_metersize` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_meter`
--

LOCK TABLES `waterworks_meter` WRITE;
/*!40000 ALTER TABLE `waterworks_meter` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_meter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_metersize`
--

DROP TABLE IF EXISTS `waterworks_metersize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_metersize` (
  `objid` varchar(50) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_metersize`
--

LOCK TABLES `waterworks_metersize` WRITE;
/*!40000 ALTER TABLE `waterworks_metersize` DISABLE KEYS */;
INSERT INTO `waterworks_metersize` VALUES ('FOUR_INCH','4\"'),('ONE_AND_HALF_INCH','1 1/2\"'),('ONE_HALF','1/2\"'),('ONE_INCH','1\"'),('SIX_INCH','6\"'),('THREE_FOURTH_INCH','3/4\"'),('THREE_INCH','3\"'),('TWO_INCH','2\"');
/*!40000 ALTER TABLE `waterworks_metersize` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_mobile_reading`
--

DROP TABLE IF EXISTS `waterworks_mobile_reading`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_mobile_reading` (
  `objid` varchar(50) NOT NULL,
  `billid` varchar(50) DEFAULT NULL,
  `state` int(255) DEFAULT NULL,
  `readingdate` datetime DEFAULT NULL,
  `billprintdate` date DEFAULT NULL,
  `lng` float(255,0) DEFAULT NULL,
  `lat` float(255,0) DEFAULT NULL,
  `photo` mediumblob,
  `remarks` varchar(255) DEFAULT NULL,
  `reading` int(25) DEFAULT NULL,
  `volume` int(10) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `dtuploaded` date DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_waterworks_mobile_reading` (`billid`) USING BTREE,
  CONSTRAINT `fk_waterworks_mobile_reading` FOREIGN KEY (`billid`) REFERENCES `waterworks_bill` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_mobile_reading`
--

LOCK TABLES `waterworks_mobile_reading` WRITE;
/*!40000 ALTER TABLE `waterworks_mobile_reading` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_mobile_reading` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_payment`
--

DROP TABLE IF EXISTS `waterworks_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_payment` (
  `objid` varchar(50) NOT NULL,
  `refno` varchar(50) DEFAULT NULL,
  `reftype` varchar(50) DEFAULT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `refdate` date DEFAULT NULL,
  `discount` decimal(16,2) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  `txnmode` varchar(50) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `billid` varchar(50) DEFAULT NULL,
  `appid` varchar(50) DEFAULT NULL,
  `compromiseid` varchar(50) DEFAULT NULL,
  `pmttxntype` varchar(50) DEFAULT NULL,
  `txndate` datetime DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `ix_refid` (`refid`) USING BTREE,
  KEY `ix_refno` (`refno`) USING BTREE,
  KEY `ix_refdate` (`refdate`) USING BTREE,
  KEY `fk_waterworks_payment_acctid` (`acctid`) USING BTREE,
  KEY `fk_waterworks_payment_billid` (`billid`) USING BTREE,
  KEY `fk_waterworks_payment_appid` (`appid`),
  KEY `fk_waterworks_payment_compromiseid` (`compromiseid`),
  CONSTRAINT `fk_waterworks_payment_acctid` FOREIGN KEY (`acctid`) REFERENCES `waterworks_account` (`objid`),
  CONSTRAINT `fk_waterworks_payment_appid` FOREIGN KEY (`appid`) REFERENCES `waterworks_application` (`objid`),
  CONSTRAINT `fk_waterworks_payment_billid` FOREIGN KEY (`billid`) REFERENCES `waterworks_bill` (`objid`),
  CONSTRAINT `fk_waterworks_payment_compromiseid` FOREIGN KEY (`compromiseid`) REFERENCES `waterworks_compromise` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_payment`
--

LOCK TABLES `waterworks_payment` WRITE;
/*!40000 ALTER TABLE `waterworks_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_payment_item`
--

DROP TABLE IF EXISTS `waterworks_payment_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_payment_item` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `discount` decimal(10,2) DEFAULT NULL,
  `remarks` varchar(50) DEFAULT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `reftype` varchar(50) DEFAULT NULL,
  `billitemid` varchar(50) DEFAULT NULL,
  `compromisefeeid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `ix_parentid` (`parentid`) USING BTREE,
  KEY `ix_refid` (`refid`) USING BTREE,
  KEY `ix_reftype` (`reftype`) USING BTREE,
  KEY `fk_waterworks_payment_item_billitemid` (`billitemid`),
  KEY `fk_waterworks_payment_item_compromisefeeid` (`compromisefeeid`),
  CONSTRAINT `fk_waterworks_payment_item_billitemid` FOREIGN KEY (`billitemid`) REFERENCES `waterworks_billitem` (`objid`),
  CONSTRAINT `fk_waterworks_payment_item_compromisefeeid` FOREIGN KEY (`compromisefeeid`) REFERENCES `waterworks_compromise_fee` (`objid`),
  CONSTRAINT `fk_waterworks_payment_item_parentid` FOREIGN KEY (`parentid`) REFERENCES `waterworks_payment` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_payment_item`
--

LOCK TABLES `waterworks_payment_item` WRITE;
/*!40000 ALTER TABLE `waterworks_payment_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_payment_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_recurringfee`
--

DROP TABLE IF EXISTS `waterworks_recurringfee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_recurringfee` (
  `objid` varchar(50) NOT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `itemid` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `startyear` int(5) DEFAULT NULL,
  `startmonth` int(5) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `amtbilled` decimal(16,2) DEFAULT NULL,
  `system` int(255) DEFAULT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `reftype` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `installmentamount` decimal(16,2) DEFAULT NULL,
  `term` int(10) DEFAULT NULL,
  `particulars` varchar(255) DEFAULT NULL,
  `principal` decimal(16,2) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_waterworks_recurringfee_acctid` (`acctid`) USING BTREE,
  CONSTRAINT `fk_waterworks_recurringfee_acctid` FOREIGN KEY (`acctid`) REFERENCES `waterworks_account` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_recurringfee`
--

LOCK TABLES `waterworks_recurringfee` WRITE;
/*!40000 ALTER TABLE `waterworks_recurringfee` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_recurringfee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_schedule_group`
--

DROP TABLE IF EXISTS `waterworks_schedule_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_schedule_group` (
  `objid` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_schedule_group`
--

LOCK TABLES `waterworks_schedule_group` WRITE;
/*!40000 ALTER TABLE `waterworks_schedule_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_schedule_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_stubout`
--

DROP TABLE IF EXISTS `waterworks_stubout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_stubout` (
  `objid` varchar(50) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `subareaid` varchar(50) NOT NULL,
  `barangay_objid` varchar(50) DEFAULT NULL,
  `barangay_name` varchar(100) DEFAULT NULL,
  `lng` float(255,0) DEFAULT NULL,
  `lat` float(255,0) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `ix_zoneid` (`subareaid`) USING BTREE,
  KEY `ix_barangay_objid` (`barangay_objid`) USING BTREE,
  CONSTRAINT `fk_waterworks_stubout_subareaid` FOREIGN KEY (`subareaid`) REFERENCES `waterworks_subarea` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_stubout`
--

LOCK TABLES `waterworks_stubout` WRITE;
/*!40000 ALTER TABLE `waterworks_stubout` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_stubout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waterworks_subarea`
--

DROP TABLE IF EXISTS `waterworks_subarea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waterworks_subarea` (
  `objid` varchar(50) NOT NULL,
  `areaid` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `schedulegroupid` varchar(50) NOT NULL,
  `barangay_objid` varchar(50) DEFAULT NULL,
  `barangay_name` varchar(150) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `month` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_waterworks_subarea_areaid` (`areaid`) USING BTREE,
  KEY `fk_waterworks_subarea_nextperiodid_schedulegroupid` (`schedulegroupid`) USING BTREE,
  KEY `fk_waterworks_subarea_schedulegroupid` (`schedulegroupid`) USING BTREE,
  CONSTRAINT `fk_waterworks_subarea_areaid` FOREIGN KEY (`areaid`) REFERENCES `waterworks_area` (`objid`),
  CONSTRAINT `fk_waterworks_subarea_schedulegroupid` FOREIGN KEY (`schedulegroupid`) REFERENCES `waterworks_schedule_group` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waterworks_subarea`
--

LOCK TABLES `waterworks_subarea` WRITE;
/*!40000 ALTER TABLE `waterworks_subarea` DISABLE KEYS */;
/*!40000 ALTER TABLE `waterworks_subarea` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `training_waterworks`
--

USE `training_waterworks`;

--
-- Final view structure for view `vw_waterworks_account`
--

/*!50001 DROP TABLE IF EXISTS `vw_waterworks_account`*/;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_account`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_waterworks_account` AS select `wa`.`objid` AS `objid`,`wa`.`state` AS `state`,`wa`.`acctno` AS `acctno`,`wa`.`acctinfoid` AS `acctinfoid`,`wa`.`dtstarted` AS `dtstarted`,`wa`.`applicationid` AS `applicationid`,`wa`.`remarks` AS `remarks`,`wa`.`ukey` AS `ukey`,`wa`.`seqno` AS `seqno`,`wa`.`billid` AS `billid`,`wa`.`lng` AS `lng`,`wa`.`lat` AS `lat`,`wa`.`excludeinbatch` AS `excludeinbatch`,`ai`.`acctname` AS `acctname`,`ai`.`owner_objid` AS `owner_objid`,`ai`.`owner_name` AS `owner_name`,`ai`.`address_type` AS `address_type`,`ai`.`address_text` AS `address_text`,`ai`.`address_barangay_objid` AS `address_barangay_objid`,`ai`.`address_barangay_name` AS `address_barangay_name`,`ai`.`address_city` AS `address_city`,`ai`.`address_province` AS `address_province`,`ai`.`address_municipality` AS `address_municipality`,`ai`.`address_unitno` AS `address_unitno`,`ai`.`address_street` AS `address_street`,`ai`.`address_subdivision` AS `address_subdivision`,`ai`.`address_bldgno` AS `address_bldgno`,`ai`.`address_bldgname` AS `address_bldgname`,`ai`.`address_pin` AS `address_pin`,`ai`.`stuboutid` AS `stuboutid`,`ai`.`subareaid` AS `subareaid`,`ai`.`meterid` AS `meterid`,`ai`.`classificationid` AS `classificationid`,`ai`.`units` AS `units`,`ai`.`attributes` AS `attributes`,`ai`.`meterstate` AS `meterstate`,`ai`.`mobileno` AS `mobileno`,`ai`.`email` AS `email`,`ai`.`phoneno` AS `phoneno` from ((`waterworks_account` `wa` join `waterworks_account_info` `ai` on((`wa`.`acctinfoid` = `ai`.`objid`))) left join `waterworks_meter` `wm` on((`ai`.`meterid` = `wm`.`objid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_waterworks_account_info`
--

/*!50001 DROP TABLE IF EXISTS `vw_waterworks_account_info`*/;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_account_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_waterworks_account_info` AS select `ai`.`objid` AS `objid`,`ai`.`acctname` AS `acctname`,`ai`.`owner_objid` AS `owner_objid`,`ai`.`owner_name` AS `owner_name`,`ai`.`address_type` AS `address_type`,`ai`.`address_text` AS `address_text`,`ai`.`address_barangay_objid` AS `address_barangay_objid`,`ai`.`address_barangay_name` AS `address_barangay_name`,`ai`.`address_city` AS `address_city`,`ai`.`address_province` AS `address_province`,`ai`.`address_municipality` AS `address_municipality`,`ai`.`address_unitno` AS `address_unitno`,`ai`.`address_street` AS `address_street`,`ai`.`address_subdivision` AS `address_subdivision`,`ai`.`address_bldgno` AS `address_bldgno`,`ai`.`address_bldgname` AS `address_bldgname`,`ai`.`address_pin` AS `address_pin`,`ai`.`stuboutid` AS `stuboutid`,`ai`.`subareaid` AS `subareaid`,`ai`.`meterid` AS `meterid`,`ai`.`classificationid` AS `classification_objid`,`ai`.`units` AS `units`,`ai`.`attributes` AS `attributes`,`ai`.`meterstate` AS `meterstate`,`ai`.`mobileno` AS `mobileno`,`ai`.`email` AS `email`,`ai`.`phoneno` AS `phoneno`,`wm`.`serialno` AS `meter_serialno`,`wm`.`capacity` AS `meter_capacity`,`wm`.`brand` AS `meter_brand`,`wms`.`title` AS `meter_size`,`sa`.`code` AS `subarea_code`,`a`.`code` AS `subarea_area_code`,`so`.`code` AS `stubout_code` from (((((`waterworks_account_info` `ai` left join `waterworks_subarea` `sa` on((`ai`.`subareaid` = `sa`.`objid`))) left join `waterworks_area` `a` on((`sa`.`areaid` = `a`.`objid`))) left join `waterworks_stubout` `so` on((`ai`.`stuboutid` = `so`.`objid`))) left join `waterworks_meter` `wm` on((`ai`.`meterid` = `wm`.`objid`))) left join `waterworks_metersize` `wms` on((`wm`.`sizeid` = `wms`.`objid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_waterworks_application`
--

/*!50001 DROP TABLE IF EXISTS `vw_waterworks_application`*/;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_application`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_waterworks_application` AS select `app`.`objid` AS `objid`,`app`.`state` AS `state`,`app`.`dtcreated` AS `dtcreated`,`app`.`appno` AS `appno`,`app`.`apptype` AS `apptype`,`app`.`acctid` AS `acctid`,`app`.`acctinfoid` AS `acctinfoid`,`app`.`taskid` AS `taskid`,`wa`.`acctno` AS `acctno` from (`waterworks_application` `app` left join `waterworks_account` `wa` on((`app`.`acctid` = `wa`.`objid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_waterworks_batch_billing`
--

/*!50001 DROP TABLE IF EXISTS `vw_waterworks_batch_billing`*/;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_batch_billing`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_waterworks_batch_billing` AS select `wb`.`objid` AS `objid`,`wb`.`state` AS `state`,`wb`.`subareaid` AS `subareaid`,`wb`.`dtposted` AS `dtposted`,`wb`.`reader_objid` AS `reader_objid`,`wb`.`reader_name` AS `reader_name`,`wb`.`taskid` AS `taskid`,`wb`.`readingdate` AS `readingdate`,`wb`.`year` AS `year`,`wb`.`month` AS `month`,`wb`.`scheduleid` AS `scheduleid`,`wb`.`objid` AS `batchno`,(case `wb`.`month` when 1 then 'JAN' when 2 then 'FEB' when 3 then 'MAR' when 4 then 'APR' when 5 then 'MAY' when 6 then 'JUN' when 7 then 'JUL' when 8 then 'AUG' when 9 then 'SEP' when 10 then 'OCT' when 11 then 'NOV' when 12 then 'DEC' end) AS `monthname`,`sarea`.`schedulegroupid` AS `subarea_schedulegroupid`,`sarea`.`code` AS `subarea_code`,`sarea`.`barangay_name` AS `subarea_barangay_name`,`area`.`code` AS `area_code`,`p`.`fromdate` AS `period_fromdate`,`p`.`todate` AS `period_todate`,`p`.`readingdate` AS `period_readingdate`,`p`.`readingenddate` AS `period_readingenddate`,`p`.`billdate` AS `period_billdate`,`p`.`billingenddate` AS `period_billingenddate`,`p`.`discdate` AS `period_discdate`,`p`.`duedate` AS `period_duedate`,`p`.`billexpirydate` AS `period_billexpirydate` from (((`waterworks_batch_billing` `wb` join `waterworks_subarea` `sarea` on((`wb`.`subareaid` = `sarea`.`objid`))) join `waterworks_area` `area` on((`sarea`.`areaid` = `area`.`objid`))) left join `waterworks_billing_period` `p` on(((`wb`.`year` = `p`.`year`) and (`wb`.`month` = `p`.`month`) and (`wb`.`scheduleid` = `p`.`scheduleid`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_waterworks_batch_billing_error`
--

/*!50001 DROP TABLE IF EXISTS `vw_waterworks_batch_billing_error`*/;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_batch_billing_error`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_waterworks_batch_billing_error` AS select `err`.`objid` AS `objid`,`err`.`batchid` AS `batchid`,`err`.`billid` AS `billid`,`err`.`acctid` AS `acctid`,`err`.`action` AS `action`,`err`.`errmsg` AS `errmsg`,`wa`.`seqno` AS `seqno`,`wa`.`acctno` AS `acctno`,`wai`.`acctname` AS `acctname` from ((`waterworks_batch_billing_error` `err` join `waterworks_account` `wa` on((`wa`.`objid` = `err`.`acctid`))) join `waterworks_account_info` `wai` on((`wai`.`objid` = `wa`.`acctinfoid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_waterworks_bill`
--

/*!50001 DROP TABLE IF EXISTS `vw_waterworks_bill`*/;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_bill`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_waterworks_bill` AS select `wb`.`objid` AS `objid`,`wb`.`billno` AS `billno`,`wb`.`billdate` AS `billdate`,`wb`.`acctid` AS `acctid`,`wb`.`acctinfoid` AS `acctinfoid`,`wb`.`batchid` AS `batchid`,`wb`.`txnmode` AS `txnmode`,`wb`.`expirydate` AS `expirydate`,`wb`.`state` AS `state`,`wb`.`balanceforward` AS `balanceforward`,`wb`.`billed` AS `billed`,`wb`.`billrefno` AS `billrefno`,`wb`.`printed` AS `printed`,`wb`.`remarks` AS `remarks`,`wb`.`createdby_objid` AS `createdby_objid`,`wb`.`createdby_name` AS `createdby_name`,`wb`.`dtcreated` AS `dtcreated`,`wb`.`validitydate` AS `validitydate`,`wb`.`initial` AS `initial`,`wb`.`step` AS `step`,`wb`.`consumptionid` AS `consumptionid`,`wb`.`totalcredits` AS `totalcredits`,`wb`.`totalprevunpaid` AS `totalprevunpaid`,`wb`.`totalbillunpaid` AS `totalbillunpaid`,`wb`.`billamount` AS `billamount`,`wb`.`totalsurcharge` AS `totalsurcharge`,`wb`.`totalpayment` AS `totalpayment`,`wb`.`totaldiscount` AS `totaldiscount`,`wb`.`year` AS `year`,`wb`.`month` AS `month`,`wb`.`scheduleid` AS `scheduleid`,(case `wb`.`month` when 1 then 'JAN' when 2 then 'FEB' when 3 then 'MAR' when 4 then 'APR' when 5 then 'MAY' when 6 then 'JUN' when 7 then 'JUL' when 8 then 'AUG' when 9 then 'SEP' when 10 then 'OCT' when 11 then 'NOV' when 12 then 'DEC' end) AS `monthname`,`a`.`acctno` AS `acctno`,`ai`.`acctname` AS `acctname`,`a`.`state` AS `acctstate`,`a`.`seqno` AS `seqno`,`ai`.`subareaid` AS `subareaid`,`ai`.`address_text` AS `address_text`,`ai`.`classificationid` AS `classificationid`,`ai`.`stuboutid` AS `stuboutid`,`ai`.`meterid` AS `meterid`,`ai`.`meterstate` AS `meterstate`,`sarea`.`schedulegroupid` AS `subarea_schedulegroupid`,`sarea`.`code` AS `subarea_code`,`sarea`.`barangay_name` AS `subarea_barangay_name`,`area`.`code` AS `area_code`,`p`.`fromdate` AS `period_fromdate`,`p`.`todate` AS `period_todate`,`p`.`readingdate` AS `period_readingdate`,`p`.`readingenddate` AS `period_readingenddate`,`p`.`billdate` AS `period_billdate`,`p`.`billingenddate` AS `period_billingenddate`,`p`.`discdate` AS `period_discdate`,`p`.`duedate` AS `period_duedate`,`p`.`billexpirydate` AS `period_billexpirydate` from (((((`waterworks_bill` `wb` join `waterworks_account` `a` on((`a`.`objid` = `wb`.`acctid`))) join `waterworks_account_info` `ai` on((`wb`.`acctinfoid` = `ai`.`objid`))) join `waterworks_subarea` `sarea` on((`ai`.`subareaid` = `sarea`.`objid`))) join `waterworks_area` `area` on((`sarea`.`areaid` = `area`.`objid`))) left join `waterworks_billing_period` `p` on(((`wb`.`year` = `p`.`year`) and (`wb`.`month` = `p`.`month`) and (`wb`.`scheduleid` = `p`.`scheduleid`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_waterworks_bill_consumption`
--

/*!50001 DROP TABLE IF EXISTS `vw_waterworks_bill_consumption`*/;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_bill_consumption`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_waterworks_bill_consumption` AS select `wc`.`objid` AS `objid`,`wc`.`billid` AS `billid`,`wc`.`reading` AS `reading`,`wc`.`volume` AS `volume`,`wc`.`amount` AS `amount`,`wc`.`hold` AS `hold`,`wc`.`reason` AS `reason`,`wc`.`readingdate` AS `readingdate`,`wc`.`reader_objid` AS `reader_objid`,`wc`.`reader_name` AS `reader_name`,`prev`.`reading` AS `prev_reading`,`wb`.`batchid` AS `batchid` from ((`waterworks_consumption` `wc` left join `waterworks_bill` `wb` on((`wc`.`billid` = `wb`.`objid`))) left join `waterworks_consumption` `prev` on(((`prev`.`acctid` = `wc`.`acctid`) and (`prev`.`meterid` = `wc`.`meterid`) and (((`prev`.`year` * 12) + `prev`.`month`) = (((`wc`.`year` * 12) + `wc`.`month`) - 1))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_waterworks_change_request`
--

/*!50001 DROP TABLE IF EXISTS `vw_waterworks_change_request`*/;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_change_request`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_waterworks_change_request` AS select `wcr`.`objid` AS `objid`,`wcr`.`controlno` AS `controlno`,`wcr`.`apptype` AS `apptype`,`wcr`.`dtcreated` AS `dtcreated`,`wcr`.`acctid` AS `acctid`,`wcr`.`acctinfoid` AS `acctinfoid`,`wcr`.`newacctinfoid` AS `newacctinfoid`,`wcr`.`reason` AS `reason`,`wcr`.`taskid` AS `taskid`,`wa`.`acctno` AS `account_acctno`,`t`.`state` AS `task_state`,`t`.`startdate` AS `task_startdate`,`t`.`enddate` AS `task_enddate`,`t`.`assignee_objid` AS `task_assignee_objid`,`t`.`assignee_name` AS `task_assignee_name`,`t`.`actor_objid` AS `task_actor_objid`,`t`.`actor_name` AS `task_actor_name`,(select `sys_wf_node`.`title` from `sys_wf_node` where ((`sys_wf_node`.`processname` = 'waterworks_change_request') and (`sys_wf_node`.`name` = `t`.`state`))) AS `task_title` from ((`waterworks_change_request` `wcr` join `waterworks_change_request_task` `t` on((`wcr`.`taskid` = `t`.`taskid`))) join `waterworks_account` `wa` on((`wcr`.`acctid` = `wa`.`objid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_waterworks_compromise`
--

/*!50001 DROP TABLE IF EXISTS `vw_waterworks_compromise`*/;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_compromise`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_waterworks_compromise` AS select `wcr`.`objid` AS `objid`,`wcr`.`controlno` AS `controlno`,`wcr`.`state` AS `state`,`wcr`.`dtcreated` AS `dtcreated`,`wcr`.`acctid` AS `acctid`,`wcr`.`acctinfoid` AS `acctinfoid`,`wcr`.`particulars` AS `particulars`,`wcr`.`taskid` AS `taskid`,`wcr`.`amount` AS `amount`,`wcr`.`downpaymentrate` AS `downpaymentrate`,`wcr`.`downpayment` AS `downpayment`,`wcr`.`term` AS `term`,`wcr`.`startduedate` AS `startduedate`,(`wcr`.`amount` - `wcr`.`downpayment`) AS `balance`,`wa`.`acctno` AS `acctno`,`t`.`state` AS `task_state`,`t`.`startdate` AS `task_startdate`,`t`.`enddate` AS `task_enddate`,`t`.`assignee_objid` AS `task_assignee_objid`,`t`.`assignee_name` AS `task_assignee_name`,`t`.`actor_objid` AS `task_actor_objid`,`t`.`actor_name` AS `task_actor_name`,(select `sys_wf_node`.`title` from `sys_wf_node` where ((`sys_wf_node`.`processname` = 'waterworks_compromise') and (`sys_wf_node`.`name` = `t`.`state`))) AS `task_title` from ((`waterworks_compromise` `wcr` join `waterworks_compromise_task` `t` on((`wcr`.`taskid` = `t`.`taskid`))) join `waterworks_account` `wa` on((`wcr`.`acctid` = `wa`.`objid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_waterworks_compromise_billitem`
--

/*!50001 DROP TABLE IF EXISTS `vw_waterworks_compromise_billitem`*/;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_compromise_billitem`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_waterworks_compromise_billitem` AS select `wcb`.`objid` AS `objid`,`wcb`.`parentid` AS `parentid`,`wcb`.`billitemid` AS `billitemid`,`wcb`.`amount` AS `amount`,`wcb`.`amtpaid` AS `amtpaid`,`bi`.`year` AS `year`,`bi`.`month` AS `month`,`ia`.`title` AS `item_title` from ((`waterworks_compromise_billitem` `wcb` join `waterworks_billitem` `bi` on((`wcb`.`billitemid` = `bi`.`objid`))) join `waterworks_itemaccount` `ia` on((`bi`.`itemid` = `ia`.`objid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_waterworks_consumption`
--

/*!50001 DROP TABLE IF EXISTS `vw_waterworks_consumption`*/;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_consumption`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_waterworks_consumption` AS select `wc`.`objid` AS `objid`,`wc`.`acctid` AS `acctid`,`wc`.`meterid` AS `meterid`,`wc`.`year` AS `year`,`wc`.`month` AS `month`,`wc`.`billid` AS `billid`,`wc`.`txnmode` AS `txnmode`,`wc`.`reading` AS `reading`,`wc`.`volume` AS `volume`,`wc`.`amount` AS `amount`,`wc`.`state` AS `state`,`wc`.`hold` AS `hold`,`wc`.`reason` AS `reason`,`wc`.`reader_objid` AS `reader_objid`,`wc`.`reader_name` AS `reader_name`,`wc`.`readingdate` AS `readingdate`,`prev`.`reading` AS `prev_reading`,`prev`.`month` AS `prev_month`,`prev`.`year` AS `prev_year`,`wb`.`batchid` AS `batchid` from ((`waterworks_consumption` `wc` left join `waterworks_bill` `wb` on((`wb`.`objid` = `wc`.`billid`))) left join `waterworks_consumption` `prev` on(((`prev`.`acctid` = `wc`.`acctid`) and (`prev`.`meterid` = `wc`.`meterid`) and (((`prev`.`year` * 12) + `prev`.`month`) = (((`wc`.`year` * 12) + `wc`.`month`) - 1))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_waterworks_disconnection`
--

/*!50001 DROP TABLE IF EXISTS `vw_waterworks_disconnection`*/;
/*!50001 DROP VIEW IF EXISTS `vw_waterworks_disconnection`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_waterworks_disconnection` AS select `wcr`.`objid` AS `objid`,`wcr`.`controlno` AS `controlno`,`wcr`.`dtcreated` AS `dtcreated`,`wcr`.`acctid` AS `acctid`,`wcr`.`acctinfoid` AS `acctinfoid`,`wcr`.`reason` AS `reason`,`wcr`.`taskid` AS `taskid`,`wcr`.`amountdue` AS `amountdue`,`wa`.`acctno` AS `account_acctno`,`t`.`state` AS `task_state`,`t`.`startdate` AS `task_startdate`,`t`.`enddate` AS `task_enddate`,`t`.`assignee_objid` AS `task_assignee_objid`,`t`.`assignee_name` AS `task_assignee_name`,`t`.`actor_objid` AS `task_actor_objid`,`t`.`actor_name` AS `task_actor_name`,(select `sys_wf_node`.`title` from `sys_wf_node` where ((`sys_wf_node`.`processname` = 'waterworks_disconnection') and (`sys_wf_node`.`name` = `t`.`state`))) AS `task_title` from ((`waterworks_disconnection` `wcr` join `waterworks_disconnection_task` `t` on((`wcr`.`taskid` = `t`.`taskid`))) join `waterworks_account` `wa` on((`wcr`.`acctid` = `wa`.`objid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-23 11:02:41
