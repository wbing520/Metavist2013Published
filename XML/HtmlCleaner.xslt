<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
	<xsl:output method="html" indent="yes" />

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:copy-of select="@*[.!='']" />
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="*[.=''][not(@*[.!=''])]" />

	<xsl:template match="text()[normalize-space() and not(ancestor::a | ancestor::script | ancestor::style)]" name="PreserveLineBreaks">
		<xsl:param name="text" select="." />
		<xsl:choose>
			<xsl:when test="not(contains($text, '&#xD;'))">
				<xsl:copy-of select="$text" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="substring-before($text, '&#xD;')" />
				<br />
				<xsl:call-template name="PreserveLineBreaks">
					<xsl:with-param name="text" select="substring-after($text, '&#xD;')" />
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>