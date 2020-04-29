<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- /Metadata/DisplaySetting/Channels/Channel/DyeName => /OME/Image/Channel@Fluorophore -->
    <xsl:template match="DyeName">
       <xsl:attribute name="Fluorophore">
           <xsl:value-of select="."/>
       </xsl:attribute>
    </xsl:template>

    <!-- /Metadata/DisplaySetting/Channels/Channel/IlluminationType => /OME/Image/Channel/IlluminationType -->
    <xsl:template match="IlluminationType">
        <xsl:attribute name="IlluminationType">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>


    <xsl:template match="ExcitationWavelength">
        <xsl:attribute name="ExcitationWavelength">
            <xsl:value-of select="."/>
        </xsl:attribute>
        <xsl:attribute name="ExcitationWavelengthUnit">
            <xsl:text>nm</xsl:text>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="EmissionWavelength">
        <xsl:attribute name="EmissionWavelength">
            <xsl:value-of select="."/>
        </xsl:attribute>
        <xsl:attribute name="EmissionWavelengthUnit">
            <xsl:text>nm</xsl:text>
        </xsl:attribute>
    </xsl:template>


    <xsl:template match="Intensity">
        <xsl:if test="not(. = 'n/a')">
            <xsl:element name="LightSourceSettings">
                <xsl:attribute name="Attenuation">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:element>
        </xsl:if>
    </xsl:template>



    <!-- /Metadata/DisplaySetting/Channels/Channel => /OME/Image/Channel -->
    <!-- /Metadata/DisplaySetting/Channels/Channel/DyeName => /OME/Image/Channel@Name -->
    <!-- /ImageDocument/Metadata/Information/Image/Dimensions/Channels/Channel/ExcitationWavelength => /Ome/Image/Channel@ExcitationWavelength  -->
    <!-- /ImageDocument/Metadata/Information/Image/Dimensions/Channels/Channel/EmissionWavelength => /Ome/Image/Channel@EmissionWavelength  -->
    <xsl:template match="Channel">
        <xsl:param name="info_channel"/>
        <xsl:element name="Channel">
            <xsl:attribute name="Name">
                <xsl:value-of select="@Name"/>
            </xsl:attribute>
            <xsl:attribute name="AcquisitionMode">
                <xsl:value-of select="$info_channel/AcquisitionMode"/>
            </xsl:attribute>
            <xsl:apply-templates select="IlluminationType"/>
                <xsl:apply-templates select="$info_channel/ExcitationWavelength"/>
                <xsl:apply-templates select="$info_channel/EmissionWavelength"/>
            <xsl:attribute name="Fluorophore">
                <xsl:value-of select="DyeName"/>
            </xsl:attribute>

            <xsl:apply-templates select="$info_channel/LightSourcesSettings/LightSourceSettings/Intensity"/>

        </xsl:element>
    </xsl:template>

    <xsl:template match="Channels">
        <xsl:for-each select="Channel">
            <xsl:variable name="channel" select="."/>
            <xsl:for-each select="/ImageDocument/Metadata/Information/Image/Dimensions/Channels/Channel">
                <xsl:if test="$channel/@Id = ./@Id">
                    <xsl:apply-templates select="$channel">
                        <xsl:with-param name="info_channel" select="."/>
                    </xsl:apply-templates>
                </xsl:if>
            </xsl:for-each>

        </xsl:for-each>
    </xsl:template>



</xsl:stylesheet>