<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ome="http://www.openmicroscopy.org/Schemas/OME/2016-06">

    <xsl:template match="ExposureTime">
        <xsl:attribute name="ExposureTime">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="METADATA">
        <xsl:attribute name="PositionX">
            <xsl:value-of select="./Tags/StageXPosition" />
        </xsl:attribute>
        <xsl:attribute name="PositionY">
            <xsl:value-of select="./Tags/StageYPosition" />
        </xsl:attribute>
        <xsl:attribute name="PositionZ">
            <xsl:value-of select="./Tags/FocusPosition" />
        </xsl:attribute>
    </xsl:template>

    <xsl:template name="Plane_T">
        <xsl:param name="theT"/>
        <xsl:attribute name="TheT">
            <xsl:choose>
                <xsl:when test="$theT">
                    <xsl:value-of select="$theT"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="0"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>

    <xsl:template name="Plane_C">
        <xsl:param name="theC"/>
        <xsl:attribute name="TheC">
            <xsl:choose>
                <xsl:when test="$theC">
                    <xsl:value-of select="$theC"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="0"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>

    <xsl:template name="Plane_Z">
        <xsl:param name="theZ"/>
        <xsl:attribute name="TheZ">
            <xsl:choose>
                <xsl:when test="$theZ">
                    <xsl:value-of select="$theZ"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="0"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="Subblock">
        <xsl:element name="ome:Plane">
            <xsl:call-template name="Plane_T">
                <xsl:with-param name="theT" select="@T"/>
            </xsl:call-template>
            <xsl:call-template name="Plane_C">
                <xsl:with-param name="theC" select="@C"/>
            </xsl:call-template>
            <xsl:call-template name="Plane_Z">
                <xsl:with-param name="theZ" select="@Z"/>
            </xsl:call-template>
            <xsl:apply-templates select="METADATA/Tags/DetectorState/CameraState/ExposureTime"/>
            <xsl:apply-templates select="METADATA" />

        </xsl:element>
    </xsl:template>


    <xsl:template match="Subblocks">
        <xsl:param name="scene_index"/>
        <xsl:apply-templates select="Subblock[@S=$scene_index]"/>
    </xsl:template>


</xsl:stylesheet>
