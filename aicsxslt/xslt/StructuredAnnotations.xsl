<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="Application">
        <xsl:element name="StructuredAnnotations">
            <xsl:element name="XMLAnnotations">
                <xsl:attribute name="Id">
                    <xsl:text>Original Acquisition Software</xsl:text>
                </xsl:attribute>
                <xsl:element name="AcquisitionSoftwareName">
                    <xsl:value-of select="Name"/>
                </xsl:element>
                <xsl:element name="AcquisitionSoftwareVersion">
                    <xsl:value-of select="Version"/>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>