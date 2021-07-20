<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ome="http://www.openmicroscopy.org/Schemas/OME/2016-06">

    <xsl:template match="Application">
        <xsl:element name="ome:StructuredAnnotations">
            <xsl:element name="ome:XMLAnnotation">
                <xsl:attribute name="ID">
                    <xsl:text>urn:lsid:allencell.org:Annotation:AcquisitionSoftware</xsl:text>
                </xsl:attribute>
                <xsl:element name="ome:Description">
                    <xsl:value-of select="Name"/>
                    <xsl:value-of select="Version"/>
                </xsl:element>
                <xsl:element name="ome:Value">
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
