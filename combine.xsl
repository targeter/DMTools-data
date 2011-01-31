<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <!-- Some overridable defaults -->
    <xsl:param name="name" select="'Gamma World'"/>
    <xsl:param name="partyFile" select="'/party.xml'"/>
    <xsl:param name="monstersFile" select="'/monsters.xml'"/>

    <!-- Read the external documents -->
    <xsl:variable name="monsters" select="document(concat($name, $monstersFile))"/>
    <xsl:variable name="party" select="document(concat($name, $partyFile))"/>

    <!-- Identity transform -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Encounters come from the source document,
             add the monster database and include the party -->
    <xsl:template match="/DMToolData">
        <xsl:copy>
            <xsl:apply-templates/>
            <monsters>
                <xsl:copy-of select="$monsters/DMToolData/monsters/MonsterEntry"/>
                <xsl:copy-of select="$party/DMToolData/monsters/MonsterEntry"/>
            </monsters>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
