<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:eaditor="https://github.com/ewg118/eaditor"
	exclude-result-prefixes="#all" version="2.0">

	<xsl:template name="tei-content">
		<xsl:choose>
			<xsl:when test="string($id)">
				<div class="yui3-g">
					<div class="yui3-u-1">
						<div class="content">
							<xsl:apply-templates/>
						</div>
					</div>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="yui3-g">
					<div class="yui3-u-1-3">
						<div class="content">
							<xsl:apply-templates select="tei:teiHeader/tei:fileDesc"/>
							<xsl:apply-templates select="tei:text"/>
						</div>
					</div>
					<div class="yui3-u-2-3">
						<div class="content">
							<xsl:call-template name="facsimiles"/>
						</div>
					</div>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="tei:fileDesc">
		<h1>
			<xsl:value-of select="tei:titleStmt/tei:title"/>
		</h1>
	</xsl:template>

	<xsl:template name="facsimiles">
		<div>
			<xsl:call-template name="page-navigation"/>
			<div>
				<div id="annot"/>
			</div>
			<table id="slider">
				<tr>
					<td id="left-scroll">
						<span>⇐</span>
					</td>
					<td>
						<div id="slider-thumbs">
							<xsl:apply-templates select="tei:facsimile" mode="slider"/>
						</div>						
					</td>
					<td id="right-scroll">
						<span>⇒</span>
					</td>
				</tr>
				
			</table>

			<!-- controls -->
			<div style="display:none">
				<span id="image-path">
					<xsl:value-of select="concat($include_path, 'ui/media/archive/', tei:facsimile[1]/tei:graphic/@url, '.jpg')"/>
				</span>
				<span id="image-id">
					<xsl:value-of select="tei:facsimile[1]/@xml:id"/>
				</span>
				<span id="display_path">
					<xsl:value-of select="$display_path"/>
				</span>
				<span id="doc">
					<xsl:value-of select="$doc"/>
				</span>
				<span id="first-page">
					<xsl:value-of select="tei:facsimile[1]/@xml:id"/>
				</span>
				<span id="last-page">
					<xsl:value-of select="tei:facsimile[last()]/@xml:id"/>
				</span>
				<span id="image-container"/>
			</div>			
		</div>
	</xsl:template>

	<xsl:template match="tei:facsimile" mode="slider">
		<a href="{$include_path}ui/media/archive/{tei:graphic/@url}.jpg" title="{tei:graphic/@n}" class="page-image" id="{@xml:id}">
			<img src="{$include_path}ui/media/thumbnail/{tei:graphic/@url}.jpg" alt="{tei:graphic/@n}">
				<xsl:if test="position()=1">
					<xsl:attribute name="class">selected</xsl:attribute>
				</xsl:if>
			</img>
		</a>
	</xsl:template>

	<xsl:template name="page-navigation">
		<div class="nav">
			<a href="#" id="prev-page" class="disabled">⇐Previous</a>
			<span id="goto-container">
				<xsl:text>Go to page: </xsl:text>
				<select id="goto-page">
					<xsl:for-each select="tei:facsimile">
						<option value="{@xml:id}">
							<xsl:choose>
								<xsl:when test="tei:graphic/@n">
									<xsl:value-of select="tei:graphic/@n"/>
								</xsl:when>
								<xsl:otherwise>[unnumbered]</xsl:otherwise>
							</xsl:choose>
						</option>
					</xsl:for-each>
				</select>
			</span>
			<a href="#" id="next-page">Next⇒</a>
		</div>
	</xsl:template>

</xsl:stylesheet>