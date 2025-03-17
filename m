Return-Path: <linux-tip-commits+bounces-4272-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4134BA64AA8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 567177A2709
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93357230BF2;
	Mon, 17 Mar 2025 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NFFTUTi/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="veNqJYLY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFEC1993BD;
	Mon, 17 Mar 2025 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208389; cv=none; b=aOi5IonNQZKabQawREKkrhmKZbhVUq/t5LlXdCz1yFmAFlks5cUSPiOKJ0jA2oAZjXB1ipp7wwUmQ2sVDDHuvrZR26MDDLMUkfymP1OrWxg9yv9UhX6ln4op3I4TstHUGXLsjHehSNSvctv9Sig1AgbbkkEef6HrcBqzsSB23N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208389; c=relaxed/simple;
	bh=oRyhunPBOyS4FkzNsGJ7Z0Hn3lIuU8WiUPqvbFFEVz4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LSOsXyffaI8j8Mb+ULic7x/nkUo+648M9wL/BvTj9RRUfLpbylphzDsfrG8aguRjQPuQw+urxpLzPT4v2G6X855UGO7kTJJfzwvBIrCLBRbU86GyYNk/uj/7L7vQ14ai8Zms15MOMNe+Kez8CxbVdAZVbWQmdfeHZajl0s6DuN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NFFTUTi/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=veNqJYLY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:46:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742208386;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBFD1YNgJQk/xmheVql9ZDIbNcZCbjqOBVV2NdkvJa8=;
	b=NFFTUTi/NpZuHwb4augrVu5a7rDzlUjTy0ne7dZXhoqtZDqQJslkUvf7L849nBK9fnTNWI
	hIfMDi5UtBPy59uzwp61OIVaMe6F2VsqGjfUXQtqPLEytrsOf/cqa8l/o47SHScPndiRoV
	Ti49YfeG/UXZ1cyu5HOw4b7/Li/leyNWaG+9j3rVIdJukahZ9JDdbvK7by0fZvK8axDqkx
	xJDjylYhVmqjLpXpqgEcKDYxy/iCEwv2B9SZW1CpT3q9Tg7a5Y89hQfVFqIeiF/tTFa5RO
	vMlKP1DIWEZviMYaBR4gOL7BORQs7h8nsfKk2lpxN4+HAAA4kipYpTOO4LZV/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742208386;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBFD1YNgJQk/xmheVql9ZDIbNcZCbjqOBVV2NdkvJa8=;
	b=veNqJYLY31moDgiILwcIGLlwROXM3R/TVqlmbDhNpG7Y003HW7GVXCuFGun0dv22Rs2m0v
	R+e9hCHUqd2MR+DQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Create backup on error and print args
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <7571e30636359b3e173ce6e122419452bb31882f.1741975349.git.jpoimboe@kernel.org>
References:
 <7571e30636359b3e173ce6e122419452bb31882f.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220838508.14745.14480888937876114986.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     aa8b3e64fd397eddd6a627d148a964e4bc2ed9ab
Gitweb:        https://git.kernel.org/tip/aa8b3e64fd397eddd6a627d148a964e4bc2ed9ab
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 14 Mar 2025 12:29:10 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:36:02 +01:00

objtool: Create backup on error and print args

Recreating objtool errors can be a manual process.  Kbuild removes the
object, so it has to be compiled or linked again before running objtool.
Then the objtool args need to be reversed engineered.

Make that all easier by automatically making a backup of the object file
on error, and print a modified version of the args which can be used to
recreate.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/7571e30636359b3e173ce6e122419452bb31882f.1741975349.git.jpoimboe@kernel.org
---
 tools/objtool/builtin-check.c           | 68 ++++++++++++++++++++++--
 tools/objtool/include/objtool/builtin.h |  1 +-
 tools/objtool/objtool.c                 | 63 +----------------------
 3 files changed, 65 insertions(+), 67 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index c201650..39ddca6 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -91,7 +91,6 @@ static const struct option check_options[] = {
 
 	OPT_GROUP("Options:"),
 	OPT_BOOLEAN(0,   "backtrace", &opts.backtrace, "unwind on error"),
-	OPT_BOOLEAN(0,   "backup", &opts.backup, "create .orig files before modification"),
 	OPT_BOOLEAN(0,   "dry-run", &opts.dryrun, "don't write modifications"),
 	OPT_BOOLEAN(0,   "link", &opts.link, "object is a linked object"),
 	OPT_BOOLEAN(0,   "module", &opts.module, "object is part of a kernel module"),
@@ -228,10 +227,39 @@ static int copy_file(const char *src, const char *dst)
 	return 0;
 }
 
+static char **save_argv(int argc, const char **argv)
+{
+	char **orig_argv;
+
+	orig_argv = calloc(argc, sizeof(char *));
+	if (!orig_argv) {
+		perror("calloc");
+		return NULL;
+	}
+
+	for (int i = 0; i < argc; i++) {
+		orig_argv[i] = strdup(argv[i]);
+		if (!orig_argv[i]) {
+			perror("strdup");
+			return NULL;
+		}
+	};
+
+	return orig_argv;
+}
+
+#define ORIG_SUFFIX ".orig"
+
 int objtool_run(int argc, const char **argv)
 {
 	struct objtool_file *file;
-	int ret;
+	char *backup = NULL;
+	char **orig_argv;
+	int ret = 0;
+
+	orig_argv = save_argv(argc, argv);
+	if (!orig_argv)
+		return 1;
 
 	cmd_parse_options(argc, argv, check_usage);
 
@@ -271,8 +299,42 @@ int objtool_run(int argc, const char **argv)
 	return 0;
 
 err:
-	if (opts.output)
+	if (opts.dryrun)
+		goto err_msg;
+
+	if (opts.output) {
 		unlink(opts.output);
+		goto err_msg;
+	}
+
+	/*
+	 * Make a backup before kbuild deletes the file so the error
+	 * can be recreated without recompiling or relinking.
+	 */
+	backup = malloc(strlen(objname) + strlen(ORIG_SUFFIX) + 1);
+	if (!backup) {
+		perror("malloc");
+		return 1;
+	}
+
+	strcpy(backup, objname);
+	strcat(backup, ORIG_SUFFIX);
+	if (copy_file(objname, backup))
+		return 1;
+
+err_msg:
+	fprintf(stderr, "%s", orig_argv[0]);
+
+	for (int i = 1; i < argc; i++) {
+		char *arg = orig_argv[i];
+
+		if (backup && !strcmp(arg, objname))
+			fprintf(stderr, " %s -o %s", backup, objname);
+		else
+			fprintf(stderr, " %s", arg);
+	}
+
+	fprintf(stderr, "\n");
 
 	return 1;
 }
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index b18f114..0fafd0f 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -29,7 +29,6 @@ struct opts {
 
 	/* options: */
 	bool backtrace;
-	bool backup;
 	bool dryrun;
 	bool link;
 	bool mnop;
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 53cd881..1c73fb6 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -20,64 +20,6 @@ bool help;
 
 static struct objtool_file file;
 
-static bool objtool_create_backup(const char *_objname)
-{
-	int len = strlen(_objname);
-	char *buf, *base, *name = malloc(len+6);
-	int s, d, l, t;
-
-	if (!name) {
-		perror("failed backup name malloc");
-		return false;
-	}
-
-	strcpy(name, _objname);
-	strcpy(name + len, ".orig");
-
-	d = open(name, O_CREAT|O_WRONLY|O_TRUNC, 0644);
-	if (d < 0) {
-		perror("failed to create backup file");
-		return false;
-	}
-
-	s = open(_objname, O_RDONLY);
-	if (s < 0) {
-		perror("failed to open orig file");
-		return false;
-	}
-
-	buf = malloc(4096);
-	if (!buf) {
-		perror("failed backup data malloc");
-		return false;
-	}
-
-	while ((l = read(s, buf, 4096)) > 0) {
-		base = buf;
-		do {
-			t = write(d, base, l);
-			if (t < 0) {
-				perror("failed backup write");
-				return false;
-			}
-			base += t;
-			l -= t;
-		} while (l);
-	}
-
-	if (l < 0) {
-		perror("failed backup read");
-		return false;
-	}
-
-	free(name);
-	free(buf);
-	close(d);
-	close(s);
-
-	return true;
-}
-
 struct objtool_file *objtool_open_read(const char *filename)
 {
 	if (file.elf) {
@@ -89,11 +31,6 @@ struct objtool_file *objtool_open_read(const char *filename)
 	if (!file.elf)
 		return NULL;
 
-	if (opts.backup && !objtool_create_backup(objname)) {
-		WARN("can't create backup file");
-		return NULL;
-	}
-
 	hash_init(file.insn_hash);
 	INIT_LIST_HEAD(&file.retpoline_call_list);
 	INIT_LIST_HEAD(&file.return_thunk_list);

