<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:include href="Instrument.xsl"/>

    <!-- /Metadata/Information/Document/UserName => /OME/Experimenter@UserName -->
    <xsl:template match="UserName">
        <xsl:attribute name="UserName">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="Document">
        <xsl:element name="Experimenter">
            <xsl:apply-templates select="UserName"/>
        </xsl:element>
    </xsl:template>


    <xsl:template match="Information">
        <xsl:apply-templates select="Document"/>
        <xsl:apply-templates select="Instrument"/>
    </xsl:template>

</xsl:stylesheet>
