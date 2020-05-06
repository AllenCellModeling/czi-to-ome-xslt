<?xml version="1.0" encoding="UTF-8"?>
<!--
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Comments in this template will generally be pointers from spec to spec
# Example:
#   Get Instrument Info
#   zisraw/Instrument.xsd: 45
#   ome/ome.xsd: 979
#
# This means that for more details on how this section of the template was created
# view line 45 of the zisraw/Instrument.xsd file and view line 979 of the ome/ome.xsd file.
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-->

<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- Output format -->
    <xsl:output method="xml" version="1.0" encoding="UTF-8"/>

    <!-- Includes -->
    <xsl:include href="DocumentUser.xsl"/>
    <xsl:include href="Image.xsl"/>
    <xsl:include href="Plate.xsl"/>
    <xsl:include href="StructuredAnnotations.xsl"/>

<!--    <xsl:param name="subblock_xml" />-->
    <xsl:variable name="subblocks" select="/ImageDocument/Subblocks" />

    <!-- Begin Template -->
    <xsl:template match="/">
        <xsl:element name="OME">
            <xsl:apply-templates select="/ImageDocument/Metadata/Information/Image/Dimensions"/>  <!-- Plate -->
            <xsl:apply-templates select="/ImageDocument/Metadata/Information"/>
            <xsl:apply-templates select="/ImageDocument/Metadata/Information/Image/Dimensions/S/Scenes/Scene"/>  <!-- Image -->
            <xsl:apply-templates select="/ImageDocument/Metadata/Information/Application"/>  <!-- StructuredAnnotations  -->
        </xsl:element>
    </xsl:template>


</xsl:stylesheet>
