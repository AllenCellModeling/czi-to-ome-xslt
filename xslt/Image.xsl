<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xls="http://www.w3.org/1999/XSL/Transform" xmlns:xslt="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="ImagingEnvironment.xsl"/>
    <xsl:import href="ObjectiveSettings.xsl"/>
    <xsl:import href="Plane.xsl"/>
    <xsl:import href="Channels.xsl"/>

    <!-- /Metadata/Information/Image/AcquisitionDataAndTime => /OME/Image/@AcquisitionDate   -->
    <xsl:template match="AcquisitionDateAndTime">
        <xsl:attribute name="AcquisitionDate">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <!-- /Metadata/Information/Image/SizeX => /OME/Image/@SizeX -->
    <xsl:template match="SizeX">
        <xsl:attribute name="SizeX">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <!-- /Metadata/Information/Image/SizeY => /OME/Image/@SizeY -->
    <xsl:template match="SizeY">
        <xsl:attribute name="SizeY">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <!-- /Metadata/Information/Image/SizeZ => /OME/Image/@SizeZ -->
    <xsl:template match="SizeZ">
        <xsl:attribute name="SizeZ">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <!-- /Metadata/Information/Image/SizeC => /OME/Image/@SizeC -->
    <xsl:template match="SizeC">
        <xsl:attribute name="SizeC">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <!-- /Metadata/Scaling/Items/Distance[@Id=X]/Value => /OME/Image/@PhysicalSizeX -->
    <xsl:template match="Distance">
        <xsl:param name="dim"/>
        <xsl:param name="unit"/>
        <xls:attribute name="PhysicalSize{$dim}">
            <xsl:choose>
                <xsl:when test="(($unit = 'µm') and (Value &lt; 1E-5)) ">
                    <xsl:value-of select="number(Value) * 1000000"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="Value"/>
                </xsl:otherwise>
            </xsl:choose>
        </xls:attribute>
        <xsl:if test="$unit != ''">
            <xsl:attribute name="PhysicalSize{$dim}Unit">
                <xsl:value-of select="$unit"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

    <!-- /Metadata/Scaling/Items => /OME/Image/@PhysicalSizeX -->
    <!-- /Metadata/Scaling/Items => /OME/Image/@PhysicalSizeY -->
    <!-- /Metadata/Scaling/Items => /OME/Image/@PhysicalSizeZ -->
    <xsl:template match="Items">
        <xsl:variable name="default_size_unit" select="/ImageDocument/Metadata/Scaling/Items/Distance/DefaultUnitFormat"/>
        <xsl:apply-templates select="Distance[@Id='X']">
            <xsl:with-param name="dim">X</xsl:with-param>
            <xsl:with-param name="unit" select="$default_size_unit"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="Distance[@Id='Y']">
            <xsl:with-param name="dim">Y</xsl:with-param>
            <xsl:with-param name="unit" select="$default_size_unit"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="Distance[@Id='Z']">
            <xsl:with-param name="dim">Z</xsl:with-param>
            <xsl:with-param name="unit" select="$default_size_unit"/>
        </xsl:apply-templates>
    </xsl:template>


    <!-- /Metadata/Experiment/AutoSave/DimensionsForSeparateFolders
        =>
    @DimensionOrder
    -->
    <xsl:template match="DimensionsForSeparateFolders">
        <xsl:attribute name="DimensionOrder">
            <!-- Remove `-` and `;` characters from DimensionsForSeparateFolders value -->
            <!-- Add XY to the front of the dimension order string as required by OME -->
            <xslt:value-of select="concat('XY', translate(., '-;', ''))"/>
        </xsl:attribute>
    </xsl:template>

    <!-- PixelType -->
    <!-- zisraw/CommonTypes.xsd: 224 -->
    <!-- ome/ome.xsd: 1689 -->
    <xsl:template match="PixelType">
        <xsl:variable name="pixel_data" select="."/>
        <xsl:attribute name="PixelType">
            <!-- Attempt to get to map the ZISRAW pixeltype to OME pixeltype -->
            <xsl:choose>
                <xsl:when test="$pixel_data='Gray8'">
                    <xsl:text>uint8</xsl:text>
                </xsl:when>
                <xsl:when test="$pixel_data='Gray16'">
                    <xsl:text>uint16</xsl:text>
                </xsl:when>
                <xsl:when test="$pixel_data='Gray32'">
                    <!-- Zeiss Docs: planned-->
                    <xsl:text>float</xsl:text>
                </xsl:when>
                <xsl:when test="$pixel_data='Gray64'">
                    <!-- Zeiss Docs: planned-->
                    <xsl:text>double</xsl:text>
                </xsl:when>
                <xsl:when test="$pixel_data='Bgr24'">
                    <xsl:text>uint8</xsl:text>
                </xsl:when>
                <xsl:when test="$pixel_data='Bgr48'">
                    <xsl:text>uint16</xsl:text>
                </xsl:when>
                <xsl:when test="$pixel_data='Gray32Float'">
                    <!-- float, specifically an IEEE 4 byte float-->
                    <xsl:text>float</xsl:text>
                </xsl:when>
                <xsl:when test="$pixel_data='Bgr96Float'">
                    <!-- float, specifically an IEEE 4 byte float-->
                    <xsl:text>float</xsl:text>
                </xsl:when>
                <xsl:when test="$pixel_data='Gray64ComplexFloat'">
                    <!-- 2 x float, specifically an IEEE 4 byte float-->
                    <xsl:text>complex</xsl:text>
                </xsl:when>
                <xsl:when test="$pixel_data='Bgr192ComplexFloat'">
                    <!-- a BGR triplet of (2 x float), specifically an IEEE 4 byte float-->
                    <xsl:text>complex</xsl:text>
                </xsl:when>
                <xsl:when test="$pixel_data='Bgra32'">
                    <!-- Bgra32 = 3 uint8 followed by a 8 bit transparency value-->
                    <!-- From other sources (non-Zeiss) the a value is a uint8-->
                    <xsl:text>uint8</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="BitCountRange">
        <xsl:attribute name="SignificantBits">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>


    <!-- /ImageDocument/Metadata/Information/Image/Dimensions/S/Scenes/Scene => /OME/Image/Image -->
    <xsl:template match="Scene">
        <xsl:element name="Image">
            <!-- Attributes -->
            <xsl:attribute name="Id">
                <xsl:text>Image:</xsl:text>
                <xsl:value-of select="@Index"/>
            </xsl:attribute>
            <xsl:variable name="img" select="/ImageDocument/Metadata/Information/Image"/>
            <xsl:variable name="chs" select="/ImageDocument/Metadata/DisplaySetting/Channels"/>
            <xsl:apply-templates select="$img/AcquisitionDateAndTime"/>
            <xsl:apply-templates select="$img/SizeX"/>
            <xsl:apply-templates select="$img/SizeY"/>
            <xsl:apply-templates select="$img/SizeZ"/>
            <xsl:apply-templates select="$img/SizeC"/>
            <xsl:apply-templates select="/ImageDocument/Metadata/Experiment/AutoSave/DimensionsForSeparateFolders"/>    <!-- DimensionOrder -->
            <xsl:apply-templates select="$chs/Channel[1]/PixelType"/>
            <xsl:apply-templates select="$chs/Channel/BitCountRange[1]"/>
            <xsl:apply-templates select="/ImageDocument/Metadata/Scaling/Items"/>
            <!-- Elements -->
            <xsl:apply-templates select="/ImageDocument/Metadata/Information/TimelineTracks/TimelineTrack/TimelineElements/TimelineElement/EventInformation/IncubationRecording"/>  <!-- Imaging Environment -->
            <xsl:apply-templates select="$img/ObjectiveSettings"/>  <!-- ObjectiveSettings -->
            <xsl:apply-templates select="$subblocks"> <!-- Plane -->
                <xsl:with-param name="scene_index" select="@Index" />
            </xsl:apply-templates>
            <!-- <xsl:apply-templates select="/ImageDocument/Metadata/Information/TimelineTracks/TimelineTrack/TimelineElements/TimelineElement/EventInformation/FocusAction/ResultPosition"/> &lt;!&ndash; Plane &ndash;&gt;-->
            <xsl:apply-templates select="$chs"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
