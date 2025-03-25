Return-Path: <linux-tip-commits+bounces-4459-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F66A6EBB8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D531188C1B9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F36254843;
	Tue, 25 Mar 2025 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AdIGzb36";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sin/klOG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9266D2571C6;
	Tue, 25 Mar 2025 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891709; cv=none; b=DxoMkrbNfF7OAfUebQ/qMfvM6UVmaWcztASPtIgQYZR0ejZ5ELACGmJ+2xUwGmXATc+t9QIQg8sGCPzQ17Bbor+eMKDVsEjAofQi00ramTKQnNKPecJExmeHFzBJnEuZoD2VwwAQmKJdJsqIG/19e14IkZzQPnKtNDIPvw8Y/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891709; c=relaxed/simple;
	bh=Yn5xRUvBgLAr78hIcMgGw9V5Jd7VTd+O+qjN3ZErZKM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qGZpp/YbREH2jproAGXi9lShQWy5qOXnYpF6vah7ljBjy+V+xJXH9gx/twC1iH4Ze10sTwrAeBBum/mWYLHIy5WVZVpGeubbC32eFXwXNVcZViA6L0QisjWdvrwjZUY/iTOG9F2f9nq0R5UOi/i1GiIeHPQsc6pkkN8g47fn/cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AdIGzb36; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sin/klOG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:35:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891705;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSVrHhRvjjDs9x3bA+1x2xCUPkRjgRWWi6KFGJmNEa4=;
	b=AdIGzb36/7qPtzjhH8GlhBLOAxCdFuJxXYmr7P3r/bwWNoVON1Li4mHYAEJ/KAoVU9g+Rr
	+YWxcuNwiNnailEm/BnX7lnBjNuGvlIXT3gepBeWLmcw/R2M1tq7S0WEFxhPKIE9cR1uYl
	QMAxZ39W1H4BnIA884toi3f20ePqNmvOtBuB/NEZs52UypGcLAKbYvGgi4cYLkwP8I9fVk
	HXCRyBuhANvtGUehTHyWF5oamJcYv7+LeqXWBLzmjdWpLe/rbtNnRQ80ZCKbaSHoSC0eey
	RKpssarWtihIU5tGov09XmLWBVh/sGXIxWx50js0vRgzWHw3UbBVrMtB5suMcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891705;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSVrHhRvjjDs9x3bA+1x2xCUPkRjgRWWi6KFGJmNEa4=;
	b=Sin/klOG+8BCMTxPETvFl3f8hPkR62DZKOMBB0VlqedJcdIUcT6dKrNZ9A52MdwY2gsSve
	NrLujqSBLXoLfBCA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Reduce CONFIG_OBJTOOL_WERROR verbosity
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <d61df69f64b396fa6b2a1335588aad7a34ea9e71.1742852846.git.jpoimboe@kernel.org>
References:
 <d61df69f64b396fa6b2a1335588aad7a34ea9e71.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289170209.14745.14028781241955027632.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     d39f82a058c0269392a797cb04f2a6064e5dcab6
Gitweb:        https://git.kernel.org/tip/d39f82a058c0269392a797cb04f2a6064e5dcab6
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:56:00 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:27 +01:00

objtool: Reduce CONFIG_OBJTOOL_WERROR verbosity

Remove the following from CONFIG_OBJTOOL_WERROR:

  * backtrace

  * "upgraded warnings to errors" message

  * cmdline args

This makes the default output less cluttered and makes it easier to spot
the actual warnings.  Note the above options are still are available
with --verbose or OBJTOOL_VERBOSE=1.

Also, do the cmdline arg printing on all warnings, regardless of werror.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/d61df69f64b396fa6b2a1335588aad7a34ea9e71.1742852846.git.jpoimboe@kernel.org
---
 scripts/Makefile.lib                    |   2 +-
 tools/objtool/builtin-check.c           | 113 +++++++++++------------
 tools/objtool/check.c                   |  23 ++---
 tools/objtool/include/objtool/builtin.h |   6 +-
 4 files changed, 73 insertions(+), 71 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 57620b4..b935974 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -277,7 +277,7 @@ objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
 objtool-args-$(CONFIG_HAVE_UACCESS_VALIDATION)		+= --uaccess
 objtool-args-$(CONFIG_GCOV_KERNEL)			+= --no-unreachable
 objtool-args-$(CONFIG_PREFIX_SYMBOLS)			+= --prefix=$(CONFIG_FUNCTION_PADDING_BYTES)
-objtool-args-$(CONFIG_OBJTOOL_WERROR)			+= --Werror --backtrace
+objtool-args-$(CONFIG_OBJTOOL_WERROR)			+= --Werror
 
 objtool-args = $(objtool-args-y)					\
 	$(if $(delay-objtool), --link)					\
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index c973a75..2bdff91 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -15,8 +15,11 @@
 #include <objtool/objtool.h>
 #include <objtool/warn.h>
 
-const char *objname;
+#define ORIG_SUFFIX ".orig"
 
+int orig_argc;
+static char **orig_argv;
+const char *objname;
 struct opts opts;
 
 static const char * const check_usage[] = {
@@ -224,39 +227,73 @@ static int copy_file(const char *src, const char *dst)
 	return 0;
 }
 
-static char **save_argv(int argc, const char **argv)
+static void save_argv(int argc, const char **argv)
 {
-	char **orig_argv;
-
 	orig_argv = calloc(argc, sizeof(char *));
 	if (!orig_argv) {
 		WARN_GLIBC("calloc");
-		return NULL;
+		exit(1);
 	}
 
 	for (int i = 0; i < argc; i++) {
 		orig_argv[i] = strdup(argv[i]);
 		if (!orig_argv[i]) {
 			WARN_GLIBC("strdup(%s)", orig_argv[i]);
-			return NULL;
+			exit(1);
 		}
 	};
-
-	return orig_argv;
 }
 
-#define ORIG_SUFFIX ".orig"
+void print_args(void)
+{
+	char *backup = NULL;
+
+	if (opts.output || opts.dryrun)
+		goto print;
+
+	/*
+	 * Make a backup before kbuild deletes the file so the error
+	 * can be recreated without recompiling or relinking.
+	 */
+	backup = malloc(strlen(objname) + strlen(ORIG_SUFFIX) + 1);
+	if (!backup) {
+		WARN_GLIBC("malloc");
+		goto print;
+	}
+
+	strcpy(backup, objname);
+	strcat(backup, ORIG_SUFFIX);
+	if (copy_file(objname, backup)) {
+		backup = NULL;
+		goto print;
+	}
+
+print:
+	/*
+	 * Print the cmdline args to make it easier to recreate.  If '--output'
+	 * wasn't used, add it to the printed args with the backup as input.
+	 */
+	fprintf(stderr, "%s", orig_argv[0]);
+
+	for (int i = 1; i < orig_argc; i++) {
+		char *arg = orig_argv[i];
+
+		if (backup && !strcmp(arg, objname))
+			fprintf(stderr, " %s -o %s", backup, objname);
+		else
+			fprintf(stderr, " %s", arg);
+	}
+
+	fprintf(stderr, "\n");
+}
 
 int objtool_run(int argc, const char **argv)
 {
 	struct objtool_file *file;
-	char *backup = NULL;
-	char **orig_argv;
 	int ret = 0;
 
-	orig_argv = save_argv(argc, argv);
-	if (!orig_argv)
-		return 1;
+	orig_argc = argc;
+	save_argv(argc, argv);
 
 	cmd_parse_options(argc, argv, check_usage);
 
@@ -279,59 +316,19 @@ int objtool_run(int argc, const char **argv)
 
 	file = objtool_open_read(objname);
 	if (!file)
-		goto err;
+		return 1;
 
 	if (!opts.link && has_multiple_files(file->elf)) {
 		WARN("Linked object requires --link");
-		goto err;
+		return 1;
 	}
 
 	ret = check(file);
 	if (ret)
-		goto err;
+		return ret;
 
 	if (!opts.dryrun && file->elf->changed && elf_write(file->elf))
-		goto err;
-
-	return 0;
-
-err:
-	if (opts.dryrun)
-		goto err_msg;
-
-	if (opts.output) {
-		unlink(opts.output);
-		goto err_msg;
-	}
-
-	/*
-	 * Make a backup before kbuild deletes the file so the error
-	 * can be recreated without recompiling or relinking.
-	 */
-	backup = malloc(strlen(objname) + strlen(ORIG_SUFFIX) + 1);
-	if (!backup) {
-		WARN_GLIBC("malloc");
 		return 1;
-	}
-
-	strcpy(backup, objname);
-	strcat(backup, ORIG_SUFFIX);
-	if (copy_file(objname, backup))
-		return 1;
-
-err_msg:
-	fprintf(stderr, "%s", orig_argv[0]);
-
-	for (int i = 1; i < argc; i++) {
-		char *arg = orig_argv[i];
 
-		if (backup && !strcmp(arg, objname))
-			fprintf(stderr, " %s -o %s", backup, objname);
-		else
-			fprintf(stderr, " %s", arg);
-	}
-
-	fprintf(stderr, "\n");
-
-	return 1;
+	return 0;
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f4e7ee8..ac21f28 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4732,9 +4732,6 @@ int check(struct objtool_file *file)
 
 	free_insns(file);
 
-	if (opts.verbose)
-		disas_warned_funcs(file);
-
 	if (opts.stats) {
 		printf("nr_insns_visited: %ld\n", nr_insns_visited);
 		printf("nr_cfi: %ld\n", nr_cfi);
@@ -4743,19 +4740,25 @@ int check(struct objtool_file *file)
 	}
 
 out:
+	if (!ret && !warnings)
+		return 0;
+
+	if (opts.verbose) {
+		if (opts.werror && warnings)
+			WARN("%d warning(s) upgraded to errors", warnings);
+		print_args();
+		disas_warned_funcs(file);
+	}
+
 	/*
 	 * CONFIG_OBJTOOL_WERROR upgrades all warnings (and errors) to actual
 	 * errors.
 	 *
-	 * Note that even "fatal" type errors don't actually return an error
-	 * without CONFIG_OBJTOOL_WERROR.  That probably needs improved at some
-	 * point.
+	 * Note that even fatal errors don't yet actually return an error
+	 * without CONFIG_OBJTOOL_WERROR.  That will be fixed soon-ish.
 	 */
-	if (opts.werror && (ret || warnings)) {
-		if (warnings)
-			WARN("%d warning(s) upgraded to errors", warnings);
+	if (opts.werror)
 		return 1;
-	}
 
 	return 0;
 }
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 0fafd0f..6b08666 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -43,8 +43,10 @@ struct opts {
 
 extern struct opts opts;
 
-extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
+int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 
-extern int objtool_run(int argc, const char **argv);
+int objtool_run(int argc, const char **argv);
+
+void print_args(void);
 
 #endif /* _BUILTIN_H */

