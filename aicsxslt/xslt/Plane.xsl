<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="ExposureTime">
        <xsl:attribute name="ExposureTime">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="METADATA">
        <xsl:element name="SamplePosition">
            <xsl:attribute name="SamplePositionX">
                <xsl:value-of select="./Tags/StageXPosition" />
            </xsl:attribute>
            <xsl:attribute name="SamplePositionY">
                <xsl:value-of select="./Tags/StageYPosition" />
            </xsl:attribute>
        </xsl:element>
        <xsl:element name="FocalPosition">
            <xsl:attribute name="StagePositionZ">
                <xsl:value-of select="./Tags/FocusPosition" />
            </xsl:attribute>
        </xsl:element>
    </xsl:template>

    <xsl:template match="@T">
        <xsl:attribute name="TheT">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@C">
        <xsl:attribute name="TheC">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@Z">
        <xsl:attribute name="TheZ">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="Subblock">
        <xsl:element name="Plane">
            <xsl:apply-templates select="@T" />
            <xsl:apply-templates select="@C" />
            <xsl:apply-templates select="@Z" />
            <xsl:apply-templates select="METADATA/Tags/DetectorState/CameraState/ExposureTime"/>
            <xsl:element name="FocalPosition">
                <xsl:apply-templates select="METADATA" />
            </xsl:element>

        </xsl:element>
    </xsl:template>


    <xsl:template match="Subblocks">
        <xsl:param name="scene_index"/>
        <xsl:apply-templates select="Subblock[@S=$scene_index]"/>
    </xsl:template>


</xsl:stylesheet>