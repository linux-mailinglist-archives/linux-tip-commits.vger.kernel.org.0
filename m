Return-Path: <linux-tip-commits+bounces-4275-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2CCA64AD4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2338A3AF7D2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAD122D4F7;
	Mon, 17 Mar 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y/8NfwDm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1I+8LgqT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467CE235371;
	Mon, 17 Mar 2025 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208392; cv=none; b=SybsnJVCvstyAOibyLRDThVClYrux3IDgo3hBjMTEOdKQ6WkUzlfLj2k0bMvZzT3JR66/EbgRNhBU/2QVdg+DZ8DVBVJwcnTa8DKk7xg9F6VsS3S7lsCxQLjeFm/6L317PgjMAtCSpC2xR7BW4tTRfCtfsgXIyofihu1+FZBnFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208392; c=relaxed/simple;
	bh=Ygjec6XPBTGluWr+UF2cNZq9uc1tvrqHziAGb6h3VY8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QCSHm0QU7T/Oo/qMCfq2TqiYb1wquzFJsThP80bBJgiIMpGn6Q3KKsyoWGDbLVQWelvSredIRLBySrinCiv9XkgRGYMddUxD4PtDt/Ul98ELvUq+2QsDPt3o2TjtTJLBizuKBfU+YYzaTH9gSprOUurA7xZuZW+axc8pQph7Rko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y/8NfwDm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1I+8LgqT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:46:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742208388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9M+izFnhD+Bib4PYZbzX/jyhavlhBphg5m3spUloN4=;
	b=y/8NfwDmS4w0UfgM13pRmwTe98PmRhHJsSdfSyiH9QDrtqzeKjPgf21xHdNq5FNX9spr4C
	AIjLnyPS568e5MCwvOFS0XkLpsYjW17Yrp4Urd+gqzuqukZ288MLYQaT8+eAVY/XpDnvqy
	yauPQ91waNkNGUcU3zsa+che6sYhZ5j+ESfRgfAttCLL5JHrRPyyugdPQAK+wv0si964nh
	qnEs3zS7YlZMuSSpnIfaPFuwfw9/wei07bWE0n+2KkH79fHQxS2z3eNBVSvPMBU+yvF3wn
	WbUUYMG4xhZ0A0WrJnN3cuocW0lcS099inoJbOGD3YnAwWeE1C58Qj7ZZ/YvGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742208388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9M+izFnhD+Bib4PYZbzX/jyhavlhBphg5m3spUloN4=;
	b=1I+8LgqT/PYKZCvA4zaBrTk2HQd4N18DrhGZrRAWiOHMwSqtKZg5MI5YEKbklOg8brBXZv
	WOvVQHSVb9u0HYCg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add --output option
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <0da308d42d82b3bbed16a31a72d6bde52afcd6bd.1741975349.git.jpoimboe@kernel.org>
References:
 <0da308d42d82b3bbed16a31a72d6bde52afcd6bd.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220838734.14745.10279649616681386528.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     5a406031d0719d146d2033ee4270310b1ca9a1e3
Gitweb:        https://git.kernel.org/tip/5a406031d0719d146d2033ee4270310b1ca9a1e3
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 14 Mar 2025 12:29:07 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:36:01 +01:00

objtool: Add --output option

Add option to allow writing the changed binary to a separate file rather
than changing it in place.

Libelf makes this suprisingly hard, so take the easy way out and just
copy the file before editing it.

Also steal the -o short option from --orc.  Nobody will notice ;-)

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/0da308d42d82b3bbed16a31a72d6bde52afcd6bd.1741975349.git.jpoimboe@kernel.org
---
 tools/objtool/builtin-check.c           | 98 +++++++++++++++++++-----
 tools/objtool/elf.c                     |  3 +-
 tools/objtool/include/objtool/builtin.h |  1 +-
 tools/objtool/objtool.c                 | 15 +---
 tools/objtool/orc_dump.c                |  7 +--
 5 files changed, 89 insertions(+), 35 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 7984351..3de3afa 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -6,6 +6,10 @@
 #include <subcmd/parse-options.h>
 #include <string.h>
 #include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/sendfile.h>
 #include <objtool/builtin.h>
 #include <objtool/objtool.h>
 
@@ -14,6 +18,8 @@
 		"error: objtool: " format "\n",		\
 		##__VA_ARGS__)
 
+const char *objname;
+
 struct opts opts;
 
 static const char * const check_usage[] = {
@@ -71,7 +77,7 @@ static const struct option check_options[] = {
 	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
 	OPT_BOOLEAN('m', "mcount", &opts.mcount, "annotate mcount/fentry calls for ftrace"),
 	OPT_BOOLEAN('n', "noinstr", &opts.noinstr, "validate noinstr rules"),
-	OPT_BOOLEAN('o', "orc", &opts.orc, "generate ORC metadata"),
+	OPT_BOOLEAN(0,   "orc", &opts.orc, "generate ORC metadata"),
 	OPT_BOOLEAN('r', "retpoline", &opts.retpoline, "validate and annotate retpoline usage"),
 	OPT_BOOLEAN(0,   "rethunk", &opts.rethunk, "validate and annotate rethunk usage"),
 	OPT_BOOLEAN(0,   "unret", &opts.unret, "validate entry unret placement"),
@@ -84,15 +90,16 @@ static const struct option check_options[] = {
 	OPT_CALLBACK_OPTARG(0, "dump", NULL, NULL, "orc", "dump metadata", parse_dump),
 
 	OPT_GROUP("Options:"),
-	OPT_BOOLEAN(0, "backtrace", &opts.backtrace, "unwind on error"),
-	OPT_BOOLEAN(0, "backup", &opts.backup, "create .orig files before modification"),
-	OPT_BOOLEAN(0, "dry-run", &opts.dryrun, "don't write modifications"),
-	OPT_BOOLEAN(0, "link", &opts.link, "object is a linked object"),
-	OPT_BOOLEAN(0, "module", &opts.module, "object is part of a kernel module"),
-	OPT_BOOLEAN(0, "mnop", &opts.mnop, "nop out mcount call sites"),
-	OPT_BOOLEAN(0, "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
-	OPT_BOOLEAN(0, "sec-address", &opts.sec_address, "print section addresses in warnings"),
-	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
+	OPT_BOOLEAN(0,   "backtrace", &opts.backtrace, "unwind on error"),
+	OPT_BOOLEAN(0,   "backup", &opts.backup, "create .orig files before modification"),
+	OPT_BOOLEAN(0,   "dry-run", &opts.dryrun, "don't write modifications"),
+	OPT_BOOLEAN(0,   "link", &opts.link, "object is a linked object"),
+	OPT_BOOLEAN(0,   "module", &opts.module, "object is part of a kernel module"),
+	OPT_BOOLEAN(0,   "mnop", &opts.mnop, "nop out mcount call sites"),
+	OPT_BOOLEAN(0,   "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
+	OPT_STRING('o',  "output", &opts.output, "file", "output file name"),
+	OPT_BOOLEAN(0,   "sec-address", &opts.sec_address, "print section addresses in warnings"),
+	OPT_BOOLEAN(0,   "stats", &opts.stats, "print statistics"),
 	OPT_BOOLEAN('v', "verbose", &opts.verbose, "verbose warnings"),
 
 	OPT_END(),
@@ -178,24 +185,75 @@ static bool opts_valid(void)
 	return false;
 }
 
+static int copy_file(const char *src, const char *dst)
+{
+	size_t to_copy, copied;
+	int dst_fd, src_fd;
+	struct stat stat;
+	off_t offset = 0;
+
+	src_fd = open(src, O_RDONLY);
+	if (src_fd == -1) {
+		ERROR("can't open '%s' for reading", src);
+		return 1;
+	}
+
+	dst_fd = open(dst, O_WRONLY | O_CREAT | O_TRUNC);
+	if (dst_fd == -1) {
+		ERROR("can't open '%s' for writing", dst);
+		return 1;
+	}
+
+	if (fstat(src_fd, &stat) == -1) {
+		perror("fstat");
+		return 1;
+	}
+
+	if (fchmod(dst_fd, stat.st_mode) == -1) {
+		perror("fchmod");
+		return 1;
+	}
+
+	for (to_copy = stat.st_size; to_copy > 0; to_copy -= copied) {
+		copied = sendfile(dst_fd, src_fd, &offset, to_copy);
+		if (copied == -1) {
+			perror("sendfile");
+			return 1;
+		}
+	}
+
+	close(dst_fd);
+	close(src_fd);
+	return 0;
+}
+
 int objtool_run(int argc, const char **argv)
 {
-	const char *objname;
 	struct objtool_file *file;
 	int ret;
 
-	argc = cmd_parse_options(argc, argv, check_usage);
-	objname = argv[0];
+	cmd_parse_options(argc, argv, check_usage);
 
 	if (!opts_valid())
 		return 1;
 
+	objname = argv[0];
+
 	if (opts.dump_orc)
 		return orc_dump(objname);
 
+	if (!opts.dryrun && opts.output) {
+		/* copy original .o file to output file */
+		if (copy_file(objname, opts.output))
+			return 1;
+
+		/* from here on, work directly on the output file */
+		objname = opts.output;
+	}
+
 	file = objtool_open_read(objname);
 	if (!file)
-		return 1;
+		goto err;
 
 	if (!opts.link && has_multiple_files(file->elf)) {
 		ERROR("Linked object requires --link");
@@ -204,10 +262,16 @@ int objtool_run(int argc, const char **argv)
 
 	ret = check(file);
 	if (ret)
-		return ret;
+		goto err;
 
-	if (file->elf->changed)
-		return elf_write(file->elf);
+	if (!opts.dryrun && file->elf->changed && elf_write(file->elf))
+		goto err;
 
 	return 0;
+
+err:
+	if (opts.output)
+		unlink(opts.output);
+
+	return 1;
 }
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 6f64d61..be4f4b6 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1302,9 +1302,6 @@ int elf_write(struct elf *elf)
 	struct section *sec;
 	Elf_Scn *s;
 
-	if (opts.dryrun)
-		return 0;
-
 	/* Update changed relocation sections and section headers: */
 	list_for_each_entry(sec, &elf->sections, list) {
 		if (sec->truncate)
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index fcca666..25cfa01 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -35,6 +35,7 @@ struct opts {
 	bool mnop;
 	bool module;
 	bool no_unreachable;
+	const char *output;
 	bool sec_address;
 	bool stats;
 	bool verbose;
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index f40febd..53cd881 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -18,7 +18,6 @@
 
 bool help;
 
-const char *objname;
 static struct objtool_file file;
 
 static bool objtool_create_backup(const char *_objname)
@@ -79,18 +78,14 @@ static bool objtool_create_backup(const char *_objname)
 	return true;
 }
 
-struct objtool_file *objtool_open_read(const char *_objname)
+struct objtool_file *objtool_open_read(const char *filename)
 {
-	if (objname) {
-		if (strcmp(objname, _objname)) {
-			WARN("won't handle more than one file at a time");
-			return NULL;
-		}
-		return &file;
+	if (file.elf) {
+		WARN("won't handle more than one file at a time");
+		return NULL;
 	}
-	objname = _objname;
 
-	file.elf = elf_open_read(objname, O_RDWR);
+	file.elf = elf_open_read(filename, O_RDWR);
 	if (!file.elf)
 		return NULL;
 
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index a62247e..05ef0e2 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -10,7 +10,7 @@
 #include <objtool/warn.h>
 #include <objtool/endianness.h>
 
-int orc_dump(const char *_objname)
+int orc_dump(const char *filename)
 {
 	int fd, nr_entries, i, *orc_ip = NULL, orc_size = 0;
 	struct orc_entry *orc = NULL;
@@ -26,12 +26,9 @@ int orc_dump(const char *_objname)
 	Elf_Data *data, *symtab = NULL, *rela_orc_ip = NULL;
 	struct elf dummy_elf = {};
 
-
-	objname = _objname;
-
 	elf_version(EV_CURRENT);
 
-	fd = open(objname, O_RDONLY);
+	fd = open(filename, O_RDONLY);
 	if (fd == -1) {
 		perror("open");
 		return -1;

