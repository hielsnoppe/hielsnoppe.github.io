<?xml version="1.0"?>
<xsl:transform version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/TR/xmlschema-2/#"
    xmlns:cv="http://rdfs.org/resume-rdf/cv.rdfs#"
    xmlns:cvx="http://vocab.nielshoppe.de/resume-rdf#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:date="http://exslt.org/dates-and-times"
    extension-element-prefixes="date">

    <xsl:output
        method="html"
        indent="yes"
        omit-xml-decalaration="yes"
        />

    <xsl:key name="Course-by-Education"
        match="cv:Course"
        use="@cvx:inEducation"
        />

    <xsl:template match="/">
        <xsl:text>---
layout: sheet
title: About
---
        </xsl:text>

        <xsl:apply-templates select="rdf:RDF/cv:CV"/>
    </xsl:template>

    <xsl:template match="cv:CV">
        <article typeof="cv:CV">
            <header>
                <h1>Curriculum vitae</h1>

                <div class="row">
                    <div class="col-md-8">
                        <xsl:copy-of select="cv:cvDescription/*"/>
                    </div>
                    <div class="col-md-4" style="text-align:center">
                        <img src="http://placehold.it/200x300"/>
                    </div>
                </div>
            </header>

            <section class="vcalendar">
                <h1>Education</h1>
                <xsl:apply-templates select="cv:hasEducation/cv:Education">
                    <xsl:sort select="concat(cv:eduEndDate, substring('9999-99-99', 1 div not(cv:eduEndDate)))" order="descending"/>
                </xsl:apply-templates>
            </section>

            <section class="vcalendar">
                <h1>Work and Teaching Experience</h1>
                <xsl:apply-templates select="cv:hasWorkHistory[not(@cvx:category='social')]/cv:WorkHistory">
                    <xsl:sort select="concat(cv:endDate, substring('9999-99-99', 1 div not(cv:endDate)))" order="descending"/>
                </xsl:apply-templates>
            </section>

            <section>
                <h1>Certifications</h1>
                <xsl:apply-templates select="cv:hasCourse/cv:Course[@cv:isCertification='True']">
                    <xsl:sort select="concat(cv:courseFinishDate, substring('9999-99-99', 1 div not(cv:courseFinishDate)))" order="descending"/>
                </xsl:apply-templates>
            </section>

            <section class="vcalendar">
                <h1>Community Service</h1>
                <xsl:apply-templates select="cv:hasWorkHistory[@cvx:category='social']/cv:WorkHistory">
                    <xsl:sort select="concat(cv:endDate, substring('9999-99-99', 1 div not(cv:endDate)))" order="descending"/>
                </xsl:apply-templates>
            </section>
        </article>
    </xsl:template>

    <xsl:template name="CV_Entry">
        <xsl:param name="startDate"/>
        <xsl:param name="endDate"/>
        <xsl:param name="summary"/>
        <xsl:param name="details"/>

        <xsl:variable name="formattedDate">
            <xsl:choose>
                <xsl:when test="$startDate and not($endDate)">
                    <xsl:text>since </xsl:text>
                    <time class="dtstart">
                        <xsl:value-of select="substring($startDate, 1, 7)"/>
                    </time>
                </xsl:when>
                <xsl:when test="$endDate and not($startDate)">
                    <xsl:text>until </xsl:text>
                    <time class="dtend">
                        <xsl:value-of select="substring($endDate, 1, 7)"/>
                    </time>
                </xsl:when>
                <xsl:when test="$startDate and $endDate">
                    <xsl:choose>
                        <xsl:when test="$startDate = $endDate">
                            <time class="dtstart dtend">
                                <xsl:value-of select="substring($startDate, 1, 7)"/>
                            </time>
                        </xsl:when>
                        <xsl:otherwise>
                            <time class="dtstart">
                                <xsl:value-of select="substring($startDate, 1, 7)"/>
                            </time>
                            <xsl:text> - </xsl:text>
                            <time class="dtend">
                                <xsl:value-of select="substring($endDate, 1, 7)"/>
                            </time>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <div class="row vevent">
            <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>

            <div class="col-date col-md-2">
                <xsl:copy-of select="$formattedDate" />
            </div>

            <div class="col-details col-sm-10">
                <xsl:copy-of select="$summary"/>

                <a data-toggle="collapse" class="pull-right" title="Show details">
                    <xsl:attribute name="href">
                        <xsl:value-of select="concat('#', @id, '-details')"/>
                    </xsl:attribute>

                    <span class="caret"></span>
                    <span class="sr-only">
                        <xsl:text>Show details</xsl:text>
                    </span>
                </a>
            </div>
        </div>

        <details class="collapse">
            <xsl:attribute name="id">
                <xsl:value-of select="concat(@id, '-details')"/>
            </xsl:attribute>

            <xsl:copy-of select="$details"/>
        </details>
    </xsl:template>

    <xsl:template match="cv:Education">
        <xsl:call-template name="CV_Entry">
            <xsl:with-param name="startDate" select="cv:eduStartDate"/>
            <xsl:with-param name="endDate" select="cv:eduEndDate"/>
            <xsl:with-param name="summary">
                <span property="cv:degreeType">
                    <xsl:value-of select="cv:degreeType"/>
                </span>
                <xsl:if test="cv:eduMajor">
                    <xsl:text> in </xsl:text>
                    <span property="cv:eduMajor">
                        <xsl:value-of select="cv:eduMajor"/>
                    </span>
                </xsl:if>
                <xsl:text> (</xsl:text>
                <xsl:value-of select="cvx:eduGrade"/>
                <xsl:text>) </xsl:text>
                <br class="hidden-md hidden-lg" />
                <xsl:text> at </xsl:text>
                <a class="url fn org">
                    <xsl:attribute name="href">
                        <xsl:value-of select="cv:studiedIn/cv:EducationalOrg/cv:URL"/>
                    </xsl:attribute>
                    <xsl:value-of select="cv:studiedIn/cv:EducationalOrg/cv:Name"/>
                </a>
            </xsl:with-param>
            <xsl:with-param name="details">
                <summary style="font-weight:bold">Selected courses</summary>

                <xsl:apply-templates
                    select="key('Course-by-Education', @id)"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="cv:WorkHistory">
        <xsl:call-template name="CV_Entry">
            <xsl:with-param name="startDate" select="cv:startDate"/>
            <xsl:with-param name="endDate" select="cv:endDate"/>
            <xsl:with-param name="summary">
                <span property="cv:jobTitle">
                    <xsl:value-of select="cv:jobTitle"/>
                </span>
                <br class="hidden-md hidden-lg" />
                <xsl:text> at </xsl:text>
                <a class="url fn org">
                    <xsl:attribute name="href">
                        <xsl:value-of select="cv:employedIn/cv:Company/cv:URL"/>
                    </xsl:attribute>
                    <xsl:value-of select="cv:employedIn/cv:Company/cv:Name"/>
                </a>
            </xsl:with-param>
            <xsl:with-param name="details">
                <xsl:copy-of select="cv:jobDescription/node()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="cv:Course">
        <xsl:call-template name="CV_Entry">
            <xsl:with-param name="startDate" select="cv:courseStartDate"/>
            <xsl:with-param name="endDate" select="cv:courseFinishDate"/>
            <xsl:with-param name="summary">
                <span property="cv:courseTitle">
                    <xsl:value-of select="cv:courseTitle"/>
                </span>
            </xsl:with-param>
            <xsl:with-param name="details">
                <xsl:copy-of select="cv:courseDescription/node()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="cv:Course" mode="inEducation">
        <h2 property="cv:courseTitle">
            <xsl:value-of select="cv:courseTitle"/>
        </h2>
        <p property="cv:courseDescription">
            <xsl:value-of select="cv:courseDescription"/>
        </p>
    </xsl:template>
</xsl:transform>
