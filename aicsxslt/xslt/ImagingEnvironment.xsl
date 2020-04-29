<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- /Metadata/Information/TimelineTracks/TimelineTrack/TimelineElements/TimelineElement/EventInformation/IncubationRecording/Components/MTBIncubationCO2Channel/Value
        =>
     /OME/Image/ImagingEnvironment@CO2Percent
    -->
    <xsl:template match="MTBIncubationCO2Channel">
        <xsl:attribute name="CO2Percent">
            <xsl:value-of select="Value"/>
        </xsl:attribute>
    </xsl:template>

    <!-- /Metadata/Information/TimelineTracks/TimelineTrack/TimelineElements/TimelineElement/EventInformation/IncubationRecording/Components/MTBIncubationCO2Channel/Value
        =>
     /OME/Image/ImagingEnvironment@UnitTemperature
    -->
    <xsl:template match="MTBIncubationTemperatureChannel4">
        <xsl:attribute name="UnitTemperature">
            <xsl:value-of select="Value"/>
        </xsl:attribute>
    </xsl:template>

    <!-- /Metadata/Information/TimelineTracks/TimelineTrack/TimelineElements/TimelineElement/EventInformation/IncubationRecording
        =>
     /OME/Image/ImagingEnvironment
    -->
    <xsl:template match="IncubationRecording">
        <xsl:if test="Components/MTBIncubationCO2Channel">
            <xsl:element name="ImagingEnvironment">
                <xsl:apply-templates select="Components/MTBIncubationCO2Channel"/>
                <xsl:apply-templates select="Components/MTBIncubationTemperatureChannel4"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>