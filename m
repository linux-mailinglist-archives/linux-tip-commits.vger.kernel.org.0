Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 042CE18B8E0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Mar 2020 15:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgCSOLs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Mar 2020 10:11:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32859 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgCSOLN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Mar 2020 10:11:13 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvsv-0002Ew-Mw; Thu, 19 Mar 2020 15:10:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B2E661C22AE;
        Thu, 19 Mar 2020 15:10:51 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:51 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf expr: Move expr lexer to flex
Cc:     Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200228093616.67125-3-jolsa@kernel.org>
References: <20200228093616.67125-3-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <158462705143.28353.156109176011386450.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     26226a97724d1671d553b8eb0cd95b0a5557cfb2
Gitweb:        https://git.kernel.org/tip/26226a97724d1671d553b8eb0cd95b0a5557cfb2
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Fri, 28 Feb 2020 10:36:13 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 09 Mar 2020 21:43:24 -03:00

perf expr: Move expr lexer to flex

Adding expr flex code instead of the manual parser code. So it's easily
extensible in upcoming changes.

The new flex code is in flex.l object and gets compiled like all the
other flexers we use.  It's defined as flex reentrant parser.

It's used by both expr__parse and expr__find_other interfaces by
separating the starting point.

There's no intended change of functionality ;-) the test expr is
passing.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200228093616.67125-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build  |  10 +-
 tools/perf/util/expr.c |  93 ++++++++++++++++++++++-
 tools/perf/util/expr.h |   2 +-
 tools/perf/util/expr.l | 114 +++++++++++++++++++++++++++-
 tools/perf/util/expr.y | 169 +++++++---------------------------------
 5 files changed, 247 insertions(+), 141 deletions(-)
 create mode 100644 tools/perf/util/expr.l

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 6fdf073..c0cf8df 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -121,6 +121,7 @@ perf-y += mem-events.o
 perf-y += vsprintf.o
 perf-y += units.o
 perf-y += time-utils.o
+perf-y += expr-flex.o
 perf-y += expr-bison.o
 perf-y += expr.o
 perf-y += branch.o
@@ -190,9 +191,13 @@ $(OUTPUT)util/parse-events-bison.c: util/parse-events.y
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,bison)$(BISON) -v util/parse-events.y -d $(PARSER_DEBUG_BISON) -o $@ -p parse_events_
 
+$(OUTPUT)util/expr-flex.c: util/expr.l $(OUTPUT)util/expr-bison.c
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/expr-flex.h $(PARSER_DEBUG_FLEX) util/expr.l
+
 $(OUTPUT)util/expr-bison.c: util/expr.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v util/expr.y -d $(PARSER_DEBUG_BISON) -o $@ -p expr__
+	$(Q)$(call echo-cmd,bison)$(BISON) -v util/expr.y -d $(PARSER_DEBUG_BISON) -o $@ -p expr_
 
 $(OUTPUT)util/pmu-flex.c: util/pmu.l $(OUTPUT)util/pmu-bison.c
 	$(call rule_mkdir)
@@ -204,12 +209,14 @@ $(OUTPUT)util/pmu-bison.c: util/pmu.y
 
 CFLAGS_parse-events-flex.o  += -w
 CFLAGS_pmu-flex.o           += -w
+CFLAGS_expr-flex.o          += -w
 CFLAGS_parse-events-bison.o += -DYYENABLE_NLS=0 -w
 CFLAGS_pmu-bison.o          += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 -w
 CFLAGS_expr-bison.o         += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 -w
 
 $(OUTPUT)util/parse-events.o: $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-bison.c
 $(OUTPUT)util/pmu.o: $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-bison.c
+$(OUTPUT)util/expr.o: $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-bison.c
 
 CFLAGS_bitmap.o        += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_find_bit.o      += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
@@ -217,6 +224,7 @@ CFLAGS_rbtree.o        += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ET
 CFLAGS_libstring.o     += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_hweight.o       += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_parse-events.o  += -Wno-redundant-decls
+CFLAGS_expr.o          += -Wno-redundant-decls
 CFLAGS_header.o        += -include $(OUTPUT)PERF-VERSION-FILE
 
 $(OUTPUT)util/kallsyms.o: ../lib/symbol/kallsyms.c FORCE
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 816b23b..b39fd39 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -1,6 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdbool.h>
 #include <assert.h>
 #include "expr.h"
+#include "expr-bison.h"
+#define YY_EXTRA_TYPE int
+#include "expr-flex.h"
+
+#ifdef PARSER_DEBUG
+extern int expr_debug;
+#endif
 
 /* Caller must make sure id is allocated */
 void expr__add_id(struct parse_ctx *ctx, const char *name, double val)
@@ -17,3 +25,88 @@ void expr__ctx_init(struct parse_ctx *ctx)
 {
 	ctx->num_ids = 0;
 }
+
+static int
+__expr__parse(double *val, struct parse_ctx *ctx, const char *expr,
+	      int start)
+{
+	YY_BUFFER_STATE buffer;
+	void *scanner;
+	int ret;
+
+	ret = expr_lex_init_extra(start, &scanner);
+	if (ret)
+		return ret;
+
+	buffer = expr__scan_string(expr, scanner);
+
+#ifdef PARSER_DEBUG
+	expr_debug = 1;
+#endif
+
+	ret = expr_parse(val, ctx, scanner);
+
+	expr__flush_buffer(buffer, scanner);
+	expr__delete_buffer(buffer, scanner);
+	expr_lex_destroy(scanner);
+	return ret;
+}
+
+int expr__parse(double *final_val, struct parse_ctx *ctx, const char **pp)
+{
+	return __expr__parse(final_val, ctx, *pp, EXPR_PARSE);
+}
+
+static bool
+already_seen(const char *val, const char *one, const char **other,
+	     int num_other)
+{
+	int i;
+
+	if (one && !strcasecmp(one, val))
+		return true;
+	for (i = 0; i < num_other; i++)
+		if (!strcasecmp(other[i], val))
+			return true;
+	return false;
+}
+
+int expr__find_other(const char *p, const char *one, const char ***other,
+		     int *num_other)
+{
+	int err, i = 0, j = 0;
+	struct parse_ctx ctx;
+
+	expr__ctx_init(&ctx);
+	err = __expr__parse(NULL, &ctx, p, EXPR_OTHER);
+	if (err)
+		return -1;
+
+	*other = malloc((ctx.num_ids + 1) * sizeof(char *));
+	if (!*other)
+		return -ENOMEM;
+
+	for (i = 0, j = 0; i < ctx.num_ids; i++) {
+		const char *str = ctx.ids[i].name;
+
+		if (already_seen(str, one, *other, j))
+			continue;
+
+		str = strdup(str);
+		if (!str)
+			goto out;
+		(*other)[j++] = str;
+	}
+	(*other)[j] = NULL;
+
+out:
+	if (i != ctx.num_ids) {
+		while (--j)
+			free((char *) (*other)[i]);
+		free(*other);
+		err = -1;
+	}
+
+	*num_other = j;
+	return err;
+}
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 0461608..9332796 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -17,9 +17,7 @@ struct parse_ctx {
 
 void expr__ctx_init(struct parse_ctx *ctx);
 void expr__add_id(struct parse_ctx *ctx, const char *id, double val);
-#ifndef IN_EXPR_Y
 int expr__parse(double *final_val, struct parse_ctx *ctx, const char **pp);
-#endif
 int expr__find_other(const char *p, const char *one, const char ***other,
 		int *num_other);
 
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
new file mode 100644
index 0000000..1928f2a
--- /dev/null
+++ b/tools/perf/util/expr.l
@@ -0,0 +1,114 @@
+%option prefix="expr_"
+%option reentrant
+%option bison-bridge
+
+%{
+#include <linux/compiler.h>
+#include "expr.h"
+#include "expr-bison.h"
+
+char *expr_get_text(yyscan_t yyscanner);
+YYSTYPE *expr_get_lval(yyscan_t yyscanner);
+
+static int __value(YYSTYPE *yylval, char *str, int base, int token)
+{
+	u64 num;
+
+	errno = 0;
+	num = strtoull(str, NULL, base);
+	if (errno)
+		return EXPR_ERROR;
+
+	yylval->num = num;
+	return token;
+}
+
+static int value(yyscan_t scanner, int base)
+{
+	YYSTYPE *yylval = expr_get_lval(scanner);
+	char *text = expr_get_text(scanner);
+
+	return __value(yylval, text, base, NUMBER);
+}
+
+/*
+ * Allow @ instead of / to be able to specify pmu/event/ without
+ * conflicts with normal division.
+ */
+static char *normalize(char *str)
+{
+	char *ret = str;
+	char *dst = str;
+
+	while (*str) {
+		if (*str == '@')
+			*dst++ = '/';
+		else if (*str == '\\')
+			*dst++ = *++str;
+		else
+			*dst++ = *str;
+		str++;
+	}
+
+	*dst = 0x0;
+	return ret;
+}
+
+static int str(yyscan_t scanner, int token)
+{
+	YYSTYPE *yylval = expr_get_lval(scanner);
+	char *text = expr_get_text(scanner);
+
+	yylval->str = normalize(strdup(text));
+	if (!yylval->str)
+		return EXPR_ERROR;
+
+	yylval->str = normalize(yylval->str);
+	return token;
+}
+%}
+
+number		[0-9]+
+
+sch		[-,=]
+spec		\\{sch}
+sym		[0-9a-zA-Z_\.:@]+
+symbol		{spec}*{sym}*{spec}*{sym}*
+
+%%
+	{
+		int start_token;
+
+		start_token = parse_events_get_extra(yyscanner);
+
+		if (start_token) {
+			parse_events_set_extra(NULL, yyscanner);
+			return start_token;
+		}
+	}
+
+max		{ return MAX; }
+min		{ return MIN; }
+if		{ return IF; }
+else		{ return ELSE; }
+#smt_on		{ return SMT_ON; }
+{number}	{ return value(yyscanner, 10); }
+{symbol}	{ return str(yyscanner, ID); }
+"|"		{ return '|'; }
+"^"		{ return '^'; }
+"&"		{ return '&'; }
+"-"		{ return '-'; }
+"+"		{ return '+'; }
+"*"		{ return '*'; }
+"/"		{ return '/'; }
+"%"		{ return '%'; }
+"("		{ return '('; }
+")"		{ return ')'; }
+","		{ return ','; }
+.		{ }
+%%
+
+int expr_wrap(void *scanner __maybe_unused)
+{
+	return 1;
+}
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 7cea8b7..4720cbe 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -1,5 +1,7 @@
 /* Simple expression parser */
 %{
+#define YYDEBUG 1
+#include <stdio.h>
 #include "util.h"
 #include "util/debug.h"
 #include <stdlib.h> // strtod()
@@ -8,23 +10,23 @@
 #include "smt.h"
 #include <string.h>
 
-#define MAXIDLEN 256
 %}
 
 %define api.pure full
 
 %parse-param { double *final_val }
 %parse-param { struct parse_ctx *ctx }
-%parse-param { const char **pp }
-%lex-param { const char **pp }
+%parse-param {void *scanner}
+%lex-param {void* scanner}
 
 %union {
-	double num;
-	char id[MAXIDLEN+1];
+	double	 num;
+	char	*str;
 }
 
+%token EXPR_PARSE EXPR_OTHER EXPR_ERROR
 %token <num> NUMBER
-%token <id> ID
+%token <str> ID
 %token MIN MAX IF ELSE SMT_ON
 %left MIN MAX IF
 %left '|'
@@ -36,11 +38,9 @@
 %type <num> expr if_expr
 
 %{
-static int expr__lex(YYSTYPE *res, const char **pp);
-
-static void expr__error(double *final_val __maybe_unused,
+static void expr_error(double *final_val __maybe_unused,
 		       struct parse_ctx *ctx __maybe_unused,
-		       const char **pp __maybe_unused,
+		       void *scanner,
 		       const char *s)
 {
 	pr_debug("%s\n", s);
@@ -62,6 +62,27 @@ static int lookup_id(struct parse_ctx *ctx, char *id, double *val)
 %}
 %%
 
+start:
+EXPR_PARSE all_expr
+|
+EXPR_OTHER all_other
+
+all_other: all_other other
+|
+
+other: ID
+{
+	if (ctx->num_ids + 1 >= EXPR_MAX_OTHER) {
+		pr_err("failed: way too many variables");
+		YYABORT;
+	}
+
+	ctx->ids[ctx->num_ids++].name = $1;
+}
+|
+MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')'
+
+
 all_expr: if_expr			{ *final_val = $1; }
 	;
 
@@ -92,131 +113,3 @@ expr:	  NUMBER
 	;
 
 %%
-
-static int expr__symbol(YYSTYPE *res, const char *p, const char **pp)
-{
-	char *dst = res->id;
-	const char *s = p;
-
-	if (*p == '#')
-		*dst++ = *p++;
-
-	while (isalnum(*p) || *p == '_' || *p == '.' || *p == ':' || *p == '@' || *p == '\\') {
-		if (p - s >= MAXIDLEN)
-			return -1;
-		/*
-		 * Allow @ instead of / to be able to specify pmu/event/ without
-		 * conflicts with normal division.
-		 */
-		if (*p == '@')
-			*dst++ = '/';
-		else if (*p == '\\')
-			*dst++ = *++p;
-		else
-			*dst++ = *p;
-		p++;
-	}
-	*dst = 0;
-	*pp = p;
-	dst = res->id;
-	switch (dst[0]) {
-	case 'm':
-		if (!strcmp(dst, "min"))
-			return MIN;
-		if (!strcmp(dst, "max"))
-			return MAX;
-		break;
-	case 'i':
-		if (!strcmp(dst, "if"))
-			return IF;
-		break;
-	case 'e':
-		if (!strcmp(dst, "else"))
-			return ELSE;
-		break;
-	case '#':
-		if (!strcasecmp(dst, "#smt_on"))
-			return SMT_ON;
-		break;
-	}
-	return ID;
-}
-
-static int expr__lex(YYSTYPE *res, const char **pp)
-{
-	int tok;
-	const char *s;
-	const char *p = *pp;
-
-	while (isspace(*p))
-		p++;
-	s = p;
-	switch (*p++) {
-	case '#':
-	case 'a' ... 'z':
-	case 'A' ... 'Z':
-		return expr__symbol(res, p - 1, pp);
-	case '0' ... '9': case '.':
-		res->num = strtod(s, (char **)&p);
-		tok = NUMBER;
-		break;
-	default:
-		tok = *s;
-		break;
-	}
-	*pp = p;
-	return tok;
-}
-
-static bool already_seen(const char *val, const char *one, const char **other,
-			 int num_other)
-{
-	int i;
-
-	if (one && !strcasecmp(one, val))
-		return true;
-	for (i = 0; i < num_other; i++)
-		if (!strcasecmp(other[i], val))
-			return true;
-	return false;
-}
-
-int expr__find_other(const char *p, const char *one, const char ***other,
-		     int *num_otherp)
-{
-	const char *orig = p;
-	int err = -1;
-	int num_other;
-
-	*other = malloc((EXPR_MAX_OTHER + 1) * sizeof(char *));
-	if (!*other)
-		return -1;
-
-	num_other = 0;
-	for (;;) {
-		YYSTYPE val;
-		int tok = expr__lex(&val, &p);
-		if (tok == 0) {
-			err = 0;
-			break;
-		}
-		if (tok == ID && !already_seen(val.id, one, *other, num_other)) {
-			if (num_other >= EXPR_MAX_OTHER - 1) {
-				pr_debug("Too many extra events in %s\n", orig);
-				break;
-			}
-			(*other)[num_other] = strdup(val.id);
-			if (!(*other)[num_other])
-				return -1;
-			num_other++;
-		}
-	}
-	(*other)[num_other] = NULL;
-	*num_otherp = num_other;
-	if (err) {
-		*num_otherp = 0;
-		free(*other);
-		*other = NULL;
-	}
-	return err;
-}
