<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


    <!--  /Metadata/Experiment/ExperimentBlocks/AcquisitionBlock/SubDimensionSetups/RegionsSetup/SampleHolder/Template/ShapeDistanceX => /OME/Plate/WellOriginX -->
    <!--  /Metadata/Information/Image/Dimensions/S/Scenes/Scene/Shape/RowIndex => /OME/Plate/@Rows -->
    <!-- /Metadata/Information/Image/Dimensions/T/StartTime => /OME/Plate/PlateAcquisition@StartTime -->

    <xsl:template match="StartTime">
        <xsl:element name="PlateAcquisition">
            <xsl:attribute name="StartTime">
                <xsl:value-of select="."/>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>

    <xsl:template match="ShapeDistanceX">
        <xsl:attribute name="WellOriginX">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="ShapeDistanceY">
        <xsl:attribute name="WellOriginY">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="RowIndex">
        <xsl:attribute name="Rows">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="ColumnIndex">
        <xsl:attribute name="Columns">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

<!--  /Metadata/Experiment/ExperimentBlocks/AcquisitionBlock/HelperSetups/FocusSetup/FocusStrategy/TimeSeriesIntervalInfo/IsActivated
        =>
        Plate/Well/WellSample@Timepoint
        -->

    <xsl:template match="Template">
        <xsl:param name="dimensions"/>
        <xsl:element name="Plate">
            <xsl:apply-templates select="ShapeDistanceX"/>
            <xsl:apply-templates select="ShapeDistanceY"/>
            <xsl:apply-templates select="$dimensions/S/Scenes/Scene/Shape/RowIndex"/>
            <xsl:apply-templates select="$dimensions/S/Scenes/Scene/Shape/ColumnIndex"/>
            <xsl:apply-templates select="$dimensions/T/StartTime"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="Dimensions">
        <xsl:apply-templates select="/ImageDocument/Metadata/Experiment/ExperimentBlocks/AcquisitionBlock/SubDimensionSetups/RegionsSetup/SampleHolder/Template">
            <xsl:with-param name="dimensions" select="."/>
        </xsl:apply-templates>
    </xsl:template>
</xsl:stylesheet>