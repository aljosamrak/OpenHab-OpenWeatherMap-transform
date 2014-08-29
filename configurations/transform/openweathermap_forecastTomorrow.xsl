<?xml version="1.0"?>
<xsl:stylesheet 
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

        <xsl:output indent="yes" method="text" encoding="UTF-8" omit-xml-declaration="yes" />

        <xsl:template match="/">
                <xsl:value-of select="//symbol/@name" />
                <xsl:text>, Low: </xsl:text>
                <xsl:value-of select="//temperature/@min" /> 
                <xsl:text>°C, High: </xsl:text>
                <xsl:value-of select="//temperature/@max" /> 
                <xsl:text>°C</xsl:text>
        </xsl:template>


</xsl:stylesheet>
