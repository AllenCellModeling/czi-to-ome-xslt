<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ome="http://www.openmicroscopy.org/Schemas/OME/2016-06">


    <xsl:import href="Channels.xsl"/>
    <xsl:import href="Plane.xsl"/>

    <!-- SizeX -->
    <xsl:template match="SizeX">
        <xsl:attribute name="SizeX">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <!-- SizeY -->
    <xsl:template match="SizeY">
        <xsl:attribute name="SizeY">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <!-- SizeZ -->
    <xsl:template name="SizeZ">
        <xsl:param name="simg"/>
        <xsl:attribute name="SizeZ">
            <xsl:choose>
                <xsl:when test="$simg/SizeZ">
                    <xsl:value-of select="$simg/SizeZ"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>1</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>

    <!-- SizeC -->
    <xsl:template name="SizeC">
        <xsl:param name="simg"/>
        <xsl:attribute name="SizeC">
            <xsl:choose>
                <xsl:when test="$simg/SizeC">
                    <xsl:value-of select="$simg/SizeC"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>1</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>

    <!-- SizeT -->
    <xsl:template name="SizeT">
        <xsl:param name="simg"/>
        <xsl:attribute name="SizeT">
            <xsl:choose>
                <xsl:when test="$simg/SizeT">
                    <xsl:value-of select="$simg/SizeT"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>1</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>

    <!-- /Metadata/Scaling/Items/Distance[@Id=X]/Value => /OME/Image/Pixels/@PhysicalSizeX -->
    <xsl:template match="Distance">
        <xsl:param name="dim"/>
        <xsl:param name="unit"/>
        <xsl:attribute name="PhysicalSize{$dim}">
            <xsl:choose>
                <xsl:when test="(($unit = 'µm') and (Value &lt; 1E-5)) ">
                    <xsl:value-of select="number(Value) * 1000000"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="Value"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:if test="$unit != ''">
            <xsl:attribute name="PhysicalSize{$dim}Unit">
                <xsl:value-of select="$unit"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

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




    <xsl:template name="Sizes">
        <xsl:param name="image"/>
        <xsl:apply-templates select="$image/SizeX"/>
        <xsl:apply-templates select="$image/SizeY"/>
        <xsl:call-template name="SizeZ">
            <xsl:with-param name="simg" select="$image"/>
        </xsl:call-template>
        <xsl:call-template name="SizeC">
            <xsl:with-param name="simg" select="$image"/>
        </xsl:call-template>
        <xsl:call-template name="SizeT">
            <xsl:with-param name="simg" select="$image"/>
        </xsl:call-template>
        <xsl:apply-templates select="/ImageDocument/Metadata/Scaling/Items"/>
    </xsl:template>


    <!-- PixelType -->
    <!-- zisraw/CommonTypes.xsd: 224 -->
    <!-- ome/ome.xsd: 1689 -->
    <xsl:template match="PixelType">
        <xsl:variable name="pixel_data" select="."/>
        <xsl:attribute name="Type">
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

    <xsl:template match="Image">
        <xsl:param name="chs" />
        <xsl:param name="idx" />
        <xsl:element name="ome:Pixels">
            <xsl:attribute name="ID">
                <xsl:value-of select="concat('Pixels:', position(), '-', $idx)"/>
            </xsl:attribute>
            <xsl:attribute name="DimensionOrder">
                <xsl:text>XYZCT</xsl:text> <!--  Hardcoded for AICSImageIO  -->
            </xsl:attribute>
            <xsl:apply-templates select="PixelType"/>
            <xsl:call-template name="Sizes"> <!-- SizeX SizeY .... SizeT -->
                <xsl:with-param name="image" select="."/>
            </xsl:call-template>
            <xsl:apply-templates select="$chs" > <!-- Channel -->
                <xsl:with-param name="idx"  select="$idx"/>
            </xsl:apply-templates>
            <xsl:element name="ome:TiffData">
                <xsl:attribute name="IFD">
                    <xsl:value-of select="position()"/>
                </xsl:attribute>
            </xsl:element>
            <xsl:apply-templates select="$subblocks"> <!-- Plane -->
                <xsl:with-param name="scene_index" select="$idx" />
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>

<!--    <ns:Pixels ID="string" DimensionOrder="XYCTZ" Type="int32" SignificantBits="3" Interleaved="false" BigEndian="false" SizeX="3" SizeY="3" SizeZ="3" SizeC="3" SizeT="3" PhysicalSizeX="1.5E2" PhysicalSizeXUnit="µm" PhysicalSizeY="1.5E2" PhysicalSizeYUnit="µm" PhysicalSizeZ="1.5E2" PhysicalSizeZUnit="µm" TimeIncrement="1.5E2" TimeIncrementUnit="s"> -->

</xsl:stylesheet>
