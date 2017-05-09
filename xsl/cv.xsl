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
                <h1>Niels Hoppe <small>curriculum vitae</small></h1>

                <xsl:copy-of select="cv:cvDescription/*"/>

                <div class="row">
                    <dl class="col-sm-6 col-sm-offset-1">
                        <div class="row">
                            <dt class="col-date col-sm-4" style="text-align:right;font-weight:normal">Born:</dt>
                            <dd class="col-details col-sm-8">June 8, 1991</dd>
                        </div>

                        <div class="row">
                            <dt class="col-date col-sm-4" style="text-align:right;font-weight:normal">Address:</dt>
                            <dd class="col-details col-sm-8">Odenwaldstr. 9, 12161 Berlin</dd>
                        </div>

                        <div class="row">
                            <dt class="col-date col-sm-4" style="text-align:right;font-weight:normal">Email:</dt>
                            <dd class="col-details col-sm-8">
                                <a href="/contact">Please see the contact form</a>
                            </dd>
                        </div>

                        <div class="row">
                            <dt class="col-date col-sm-4" style="text-align:right;font-weight:normal">Phone:</dt>
                            <dd class="col-details col-sm-8">
                                <a href="tel:+493053142577">+49 30 53 14 25 77</a>
                            </dd>
                        </div>

                        <div class="row">
                            <dt class="col-date col-sm-4" style="text-align:right;font-weight:normal">Mobile:</dt>
                            <dd class="col-details col-sm-8">
                                <a href="/contact">On request</a>
                            </dd>
                        </div>

                        <div class="row">
                            <dt class="col-date col-sm-4" style="text-align:right;font-weight:normal">LinkedIn:</dt>
                            <dd class="col-details col-sm-8">
                                <a href="https://www.linkedin.com/in/hielsnoppe">@hielsnoppe</a>
                            </dd>
                        </div>

                        <!--
                        <div class="row">
                            <dt class="col-date col-sm-6" style="text-align:right;font-weight:normal">StackOverflow Careers:</dt>
                            <dd class="col-details col-sm-6">
                                <a href="https://www.linkedin.com/in/hielsnoppe">@hielsnoppe</a>
                            </dd>
                        </div>
                        -->
                    </dl>

                    <div class="col-md-5" style="text-align:center">
                        <!--
                        <img src="http://placehold.it/150x200"/>
                        -->
                    </div>
                </div>
            </header>

            <section class="vcalendar">
                <h1 class="h2">Work and teaching experience</h1>
                <xsl:apply-templates select="cv:hasWorkHistory[not(@cvx:category='social')]/cv:WorkHistory">
                    <xsl:sort select="concat(cv:endDate, substring('9999-99-99', 1 div not(cv:endDate)))" order="descending"/>
                </xsl:apply-templates>
            </section>

            <section class="vcalendar">
                <h1 class="h2">Education</h1>
                <xsl:apply-templates select="cv:hasEducation/cv:Education">
                    <xsl:sort select="concat(cv:eduEndDate, substring('9999-99-99', 1 div not(cv:eduEndDate)))" order="descending"/>
                </xsl:apply-templates>
            </section>

            <section>
                <h1 class="h2">Certifications</h1>
                <xsl:apply-templates select="cv:hasCourse/cv:Course[@cv:isCertification='True']">
                    <xsl:sort select="concat(cv:courseFinishDate, substring('9999-99-99', 1 div not(cv:courseFinishDate)))" order="descending"/>
                </xsl:apply-templates>
            </section>

            <section class="vcalendar">
                <h1 class="h2">Other activities</h1>
                <xsl:apply-templates select="cv:hasWorkHistory[@cvx:category='social']/cv:WorkHistory">
                    <xsl:sort select="concat(cv:endDate, substring('9999-99-99', 1 div not(cv:endDate)))" order="descending"/>
                </xsl:apply-templates>

                <div class="row vevent" style="padding-top: 0.5em; padding-bottom: 0.5em">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>

                    <div class="col-date col-sm-3" style="text-align:right">
                        since
                        <time class="dtstart" style="display:block">2008</time>
                    </div>

                    <div class="col-details col-sm-9">
                        <p><a href="/about/dance">Competitive ballroom dancing</a></p>
                    </div>
                </div>
            </section>

            <section>
                <h1 class="h2">Languages</h1>
                <p>German native, English fluent spoken and written (C1 in <abbr title="Common European Frame of Reference for Languages">CEFR</abbr>)</p>
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
                    <time class="dtstart" style="display:block">
                        <xsl:value-of select="concat('{{ &quot;', $startDate, '-01&quot; | date: &quot;%B %Y&quot; }}')"/>
                    </time>
                </xsl:when>
                <xsl:when test="$endDate and not($startDate)">
                    <xsl:text>until </xsl:text>
                    <time class="dtend" style="display:block">
                        <xsl:value-of select="concat('{{ &quot;', $endDate, '-01&quot; | date: &quot;%B %Y&quot; }}')"/>
                    </time>
                </xsl:when>
                <xsl:when test="$startDate and $endDate">
                    <xsl:choose>
                        <xsl:when test="$startDate = $endDate">
                            <time class="dtstart dtend">
                                <xsl:value-of select="concat('{{ &quot;', $startDate, '-01&quot; | date: &quot;%B %Y&quot; }}')"/>
                            </time>
                        </xsl:when>
                        <xsl:otherwise>
                            <time class="dtstart" style="display:block">
                                <xsl:value-of select="concat('{{ &quot;', $startDate, '-01&quot; | date: &quot;%B %Y&quot; }}')"/>
                            </time>
                            <xsl:text disable-output-escaping="yes"> &amp;ndash; </xsl:text>
                            <time class="dtend">
                                <xsl:value-of select="concat('{{ &quot;', $endDate, '-01&quot; | date: &quot;%B %Y&quot; }}')"/>
                            </time>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <div class="row vevent" style="padding-top: 0.5em; padding-bottom: 0.5em">
            <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>

            <div class="col-date col-sm-3" style="text-align:right">
                <xsl:copy-of select="$formattedDate" />
            </div>

            <div class="col-details col-sm-9">
                <xsl:copy-of select="$summary"/>

                <!--
                <a data-toggle="collapse" class="pull-right" title="Show details">
                    <xsl:attribute name="href">
                        <xsl:value-of select="concat('#', @id, '-details')"/>
                    </xsl:attribute>

                    <span class="caret"></span>
                    <span class="sr-only">
                        <xsl:text>Show details</xsl:text>
                    </span>
                </a>
                -->
            </div>
        </div>

        <!--
        <details class="collapse">
            <xsl:attribute name="id">
                <xsl:value-of select="concat(@id, '-details')"/>
            </xsl:attribute>

            <xsl:copy-of select="$details"/>
        </details>
        -->
    </xsl:template>

    <xsl:template match="cv:Education">
        <xsl:variable name="degreeTypeAbbr">
            <xsl:choose>
                <xsl:when test="cv:degreeType = 'Bachelor of Science'">B.Sc.</xsl:when>
                <xsl:when test="cv:degreeType = 'Master of Science'">M.Sc.</xsl:when>
            </xsl:choose>
        </xsl:variable>

        <xsl:call-template name="CV_Entry">
            <xsl:with-param name="startDate" select="cv:eduStartDate"/>
            <xsl:with-param name="endDate" select="cv:eduEndDate"/>
            <xsl:with-param name="summary">
                <xsl:if test="cv:eduMajor">
                    <span property="cv:eduMajor">
                        <xsl:value-of select="cv:eduMajor"/>
                    </span>
                    <xsl:text>, </xsl:text>
                </xsl:if>
                <xsl:choose>
                    <xsl:when test="$degreeTypeAbbr != ''">
                        <abbr property="cv:degreeType">
                            <xsl:attribute name="title">
                                <xsl:value-of select="cv:degreeType"/>
                            </xsl:attribute>
                            <xsl:value-of select="$degreeTypeAbbr"/>
                        </abbr>
                    </xsl:when>
                    <xsl:otherwise>
                        <span property="cv:degreeType">
                            <xsl:value-of select="cv:degreeType"/>
                        </span>
                    </xsl:otherwise>
                </xsl:choose>
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
                <xsl:if test="cv:employedIn">
                    <br class="hidden-md hidden-lg" />
                    <xsl:text> at </xsl:text>
                    <a class="url fn org">
                        <xsl:attribute name="href">
                            <xsl:value-of select="cv:employedIn/cv:Company/cv:URL"/>
                        </xsl:attribute>
                        <xsl:value-of select="cv:employedIn/cv:Company/cv:Name"/>
                    </a>
                </xsl:if>
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
