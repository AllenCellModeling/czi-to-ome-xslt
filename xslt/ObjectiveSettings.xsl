<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


    <xsl:template match="Medium">
        <xsl:attribute name="ImmersionMedium">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="RefractiveIndex">
        <xsl:attribute name="ImmersionRefractiveIndex">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

<!--
    /Metadata/Information/Image/ObjectiveSettings
        =>
    /OME/Image/ObjectiveSettings
    -->
    <xsl:template match="ObjectiveSettings">
        <xsl:element name="ObjectiveSettings">
            <xsl:apply-templates select="Medium"/>
            <xsl:apply-templates select="RefractiveIndex"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>