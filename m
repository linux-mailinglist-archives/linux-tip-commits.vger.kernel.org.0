Return-Path: <linux-tip-commits+bounces-6888-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E832FBE2915
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BF6A4FCCE0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4BE32F77C;
	Thu, 16 Oct 2025 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CrvvfF62";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L1V/7rOo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A7032BF52;
	Thu, 16 Oct 2025 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608381; cv=none; b=iXaQgwRwC5oKvaFTDcv6JxlpP41k0qUuV8DBw1PX8lHaXb7iARyPPio7Df5BmpMLfEnOGqxaimqGhY6pVZKy/k64UnVmJwYLelazvz1AZlDAwaelcvRuJo0goUm755rDotRyEE5xJpODomtC/XSTT/3XlXoSt7ffhVwwwRgYK50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608381; c=relaxed/simple;
	bh=uS4pO0UIMT7q3ctjKDyQ+aTZhrUbeuwL9liT0hYrfx0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=bPSSAz5wNwFqlhm48cIosLZaaGFSuWRtN3iympI3I6AwpBRI/L1QIqsaByf1RkYi+9cCQouG+rGBFGf7d3J8xJoorhE+CMhwXGwP4fa7cjbmh/Tk9NRfytCv9K+FGHlbUGbnuFpLtGfn8WC9lL4t3xfIhFrcFG0xiH25W1zLe3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CrvvfF62; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L1V/7rOo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608358;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=L+rprV+NtTR0/m8yODkW3kpAMOa88dKTF2aWrBXoNl0=;
	b=CrvvfF62AWl+z3mut0ULgsW0oJAQHnsDounfZ13aGQ/ZRvLj8s94E3mXJEzXeJyzMjSR82
	I77kiE4wxynX/HwEzc+BkKOgUgZtEL8k/RlOeUjHJMZE+80f2cldSM83Fj6fKsPrEmmGgi
	3/gAqoKLUd49cuW/FooNKKkmV887u5GJzQWfHFM+6gYFZjivDmWu2BwFdZyaG0g22dqiH/
	NF83v0iFo7SsdsRYYX3i71c7b6tKS0nNYXyDxfkqHGPZIQ5qeae0Ne2KSwc4g6tCGc/HCD
	AoBIR+d7Md6fQggko9uDojVliHtlGviMsySI7xAZ4sJFleipbPk2/ymDZJi7lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608358;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=L+rprV+NtTR0/m8yODkW3kpAMOa88dKTF2aWrBXoNl0=;
	b=L1V/7rOosRkbhkkQ6pFUqLVUXMAcXy+At9Nw9/9RcW4hw77RmaUhskt1RGnpnIbgkUVpwv
	BYrNmEwU2xn1E+CQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Resurrect --backup option
Cc: Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>,
 Joe Lawrence <joe.lawrence@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060835691.709179.3497567887666009677.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2b91479776b66cd815e339d420abbf4ae047bfb2
Gitweb:        https://git.kernel.org/tip/2b91479776b66cd815e339d420abbf4ae04=
7bfb2
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:43 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:46:48 -07:00

objtool: Resurrect --backup option

The --backup option was removed with the following commit:

  aa8b3e64fd39 ("objtool: Create backup on error and print args")

... which tied the backup functionality to --verbose, and only for
warnings/errors.

It's a bit inelegant and out of scope to tie that to --verbose.

Bring back the old --backup option, but with the new behavior: only on
warnings/errors, and print the args to make it easier to recreate.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/builtin-check.c           | 25 ++++++++++--------------
 tools/objtool/check.c                   |  4 +++-
 tools/objtool/include/objtool/builtin.h |  3 ++-
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 2aa28af..2abac92 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -92,6 +92,7 @@ static const struct option check_options[] =3D {
=20
 	OPT_GROUP("Options:"),
 	OPT_BOOLEAN(0,   "backtrace", &opts.backtrace, "unwind on error"),
+	OPT_BOOLEAN(0,   "backup", &opts.backup, "create backup (.orig) file on war=
ning/error"),
 	OPT_BOOLEAN(0,   "dry-run", &opts.dryrun, "don't write modifications"),
 	OPT_BOOLEAN(0,   "link", &opts.link, "object is a linked object"),
 	OPT_BOOLEAN(0,   "module", &opts.module, "object is part of a kernel module=
"),
@@ -246,12 +247,9 @@ static void save_argv(int argc, const char **argv)
 	}
 }
=20
-void print_args(void)
+int make_backup(void)
 {
-	char *backup =3D NULL;
-
-	if (opts.output || opts.dryrun)
-		goto print;
+	char *backup;
=20
 	/*
 	 * Make a backup before kbuild deletes the file so the error
@@ -260,33 +258,32 @@ void print_args(void)
 	backup =3D malloc(strlen(objname) + strlen(ORIG_SUFFIX) + 1);
 	if (!backup) {
 		ERROR_GLIBC("malloc");
-		goto print;
+		return 1;
 	}
=20
 	strcpy(backup, objname);
 	strcat(backup, ORIG_SUFFIX);
-	if (copy_file(objname, backup)) {
-		backup =3D NULL;
-		goto print;
-	}
+	if (copy_file(objname, backup))
+		return 1;
=20
-print:
 	/*
-	 * Print the cmdline args to make it easier to recreate.  If '--output'
-	 * wasn't used, add it to the printed args with the backup as input.
+	 * Print the cmdline args to make it easier to recreate.
 	 */
+
 	fprintf(stderr, "%s", orig_argv[0]);
=20
 	for (int i =3D 1; i < orig_argc; i++) {
 		char *arg =3D orig_argv[i];
=20
-		if (backup && !strcmp(arg, objname))
+		/* Modify the printed args to use the backup */
+		if (!opts.output && !strcmp(arg, objname))
 			fprintf(stderr, " %s -o %s", backup, objname);
 		else
 			fprintf(stderr, " %s", arg);
 	}
=20
 	fprintf(stderr, "\n");
+	return 0;
 }
=20
 int objtool_run(int argc, const char **argv)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e567a62..b63f7c4 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4824,9 +4824,11 @@ out:
 	if (opts.verbose) {
 		if (opts.werror && warnings)
 			WARN("%d warning(s) upgraded to errors", warnings);
-		print_args();
 		disas_warned_funcs(file);
 	}
=20
+	if (opts.backup && make_backup())
+		return 1;
+
 	return ret;
 }
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/=
objtool/builtin.h
index ab22673..7d559a2 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -30,6 +30,7 @@ struct opts {
=20
 	/* options: */
 	bool backtrace;
+	bool backup;
 	bool dryrun;
 	bool link;
 	bool mnop;
@@ -48,6 +49,6 @@ int cmd_parse_options(int argc, const char **argv, const ch=
ar * const usage[]);
=20
 int objtool_run(int argc, const char **argv);
=20
-void print_args(void);
+int make_backup(void);
=20
 #endif /* _BUILTIN_H */

