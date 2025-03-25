Return-Path: <linux-tip-commits+bounces-4461-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A560A6EBBD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB91416D849
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10756257420;
	Tue, 25 Mar 2025 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sv/wENiG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6KXT3C8N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3672B2571CB;
	Tue, 25 Mar 2025 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891710; cv=none; b=PNf+Yia+wTMNNp867gfkZx9Pp3lSnFC3F1rfDosmz992Qi2Q6NbC5huVrPa/otb8fzLKsRI6oXofNL6Rx0V7W+X5zXROMggJOGWJxDnGFc5roZoANJ4EORvLG1qR+zHa7rNB3cvHi58GIsEHx9+Y20JSg7GcD9gmTOgkRim/t2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891710; c=relaxed/simple;
	bh=Xj+IgPfAabi+aREHSclBLjCr1VuVNPJVgFpMKO0dVMI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Io5iUha+Svj5ZAOmD632fPq89TGCxHAVLMGPpmfKjqb54jc6uKn6YStiV1bq3lzoXMqX4LUFi3PxwaEVZVJ2sc/3AuF/J5a/QX6dwJFjrriRJIguBvTCe93llYiexxrrsHfuaDumth8ubi0StUMVAm/sCStIYpLsJeUKk46/psc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sv/wENiG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6KXT3C8N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:35:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyM8N4AvhhZg6uYHNPJ35Ujww1zrJWdX5EYicl2/mmc=;
	b=Sv/wENiG/dkcEJumGNuOkDm4LRRgjwSYAHoj47NczMJ9Y+vF7JBdjtvDcGK1KpqlKdWvbf
	FZPt7spm5bafPOLndiIYvjcsBr1x8usJe6ZeigBVgHqG05mjYRd/+Un6LKDkDia+adowMk
	kan0+yT8HBaaduHIZKkueyZtZpYSYnUqrz+zJgZX7IhoHJU48w8fzW0+mtuSIeC6FLnVHw
	wRuB3VYZOtxpi9PufrELK3FD9QeeOSEu7Z3PL6ft67kUEJPIgIxNBmUMoszSmLuq3Js+NT
	vc5q01hadc1DEX+rbhlC/uVfLlbX9egDEZPdzNRoFt71lAcRIK/sNsX85ecbgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyM8N4AvhhZg6uYHNPJ35Ujww1zrJWdX5EYicl2/mmc=;
	b=6KXT3C8NKnWVBUWzbHndwHnj0JBw2C4knzyZxGWyjmVepas7CestcXp85V5dmr7GhfFTJx
	SrtN0KVtDUPGKhAQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Improve error handling
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <3094bb4463dad29b6bd1bea03848d1571ace771c.1742852846.git.jpoimboe@kernel.org>
References:
 <3094bb4463dad29b6bd1bea03848d1571ace771c.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289170611.14745.14786465461467885317.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     c5995abe15476798b2e2f0163a33404c41aafc8f
Gitweb:        https://git.kernel.org/tip/c5995abe15476798b2e2f0163a33404c41aafc8f
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:55:59 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:27 +01:00

objtool: Improve error handling

Fix some error handling issues, improve error messages, properly
distinguish betwee errors and warnings, and generally try to make all
the error handling more consistent.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/3094bb4463dad29b6bd1bea03848d1571ace771c.1742852846.git.jpoimboe@kernel.org
---
 tools/objtool/builtin-check.c           |  37 +--
 tools/objtool/check.c                   | 368 +++++++++++------------
 tools/objtool/elf.c                     |  22 +-
 tools/objtool/include/objtool/objtool.h |   2 +-
 tools/objtool/include/objtool/warn.h    |  13 +-
 tools/objtool/objtool.c                 |  11 +-
 6 files changed, 232 insertions(+), 221 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 5f761f4..c973a75 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -8,15 +8,12 @@
 #include <stdlib.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <errno.h>
 #include <sys/stat.h>
 #include <sys/sendfile.h>
 #include <objtool/builtin.h>
 #include <objtool/objtool.h>
-
-#define ERROR(format, ...)				\
-	fprintf(stderr,					\
-		"error: objtool: " format "\n",		\
-		##__VA_ARGS__)
+#include <objtool/warn.h>
 
 const char *objname;
 
@@ -139,22 +136,22 @@ int cmd_parse_options(int argc, const char **argv, const char * const usage[])
 static bool opts_valid(void)
 {
 	if (opts.mnop && !opts.mcount) {
-		ERROR("--mnop requires --mcount");
+		WARN("--mnop requires --mcount");
 		return false;
 	}
 
 	if (opts.noinstr && !opts.link) {
-		ERROR("--noinstr requires --link");
+		WARN("--noinstr requires --link");
 		return false;
 	}
 
 	if (opts.ibt && !opts.link) {
-		ERROR("--ibt requires --link");
+		WARN("--ibt requires --link");
 		return false;
 	}
 
 	if (opts.unret && !opts.link) {
-		ERROR("--unret requires --link");
+		WARN("--unret requires --link");
 		return false;
 	}
 
@@ -171,7 +168,7 @@ static bool opts_valid(void)
 	    opts.static_call		||
 	    opts.uaccess) {
 		if (opts.dump_orc) {
-			ERROR("--dump can't be combined with other actions");
+			WARN("--dump can't be combined with other actions");
 			return false;
 		}
 
@@ -181,7 +178,7 @@ static bool opts_valid(void)
 	if (opts.dump_orc)
 		return true;
 
-	ERROR("At least one action required");
+	WARN("At least one action required");
 	return false;
 }
 
@@ -194,30 +191,30 @@ static int copy_file(const char *src, const char *dst)
 
 	src_fd = open(src, O_RDONLY);
 	if (src_fd == -1) {
-		ERROR("can't open '%s' for reading", src);
+		WARN("can't open %s for reading: %s", src, strerror(errno));
 		return 1;
 	}
 
 	dst_fd = open(dst, O_WRONLY | O_CREAT | O_TRUNC, 0400);
 	if (dst_fd == -1) {
-		ERROR("can't open '%s' for writing", dst);
+		WARN("can't open %s for writing: %s", dst, strerror(errno));
 		return 1;
 	}
 
 	if (fstat(src_fd, &stat) == -1) {
-		perror("fstat");
+		WARN_GLIBC("fstat");
 		return 1;
 	}
 
 	if (fchmod(dst_fd, stat.st_mode) == -1) {
-		perror("fchmod");
+		WARN_GLIBC("fchmod");
 		return 1;
 	}
 
 	for (to_copy = stat.st_size; to_copy > 0; to_copy -= copied) {
 		copied = sendfile(dst_fd, src_fd, &offset, to_copy);
 		if (copied == -1) {
-			perror("sendfile");
+			WARN_GLIBC("sendfile");
 			return 1;
 		}
 	}
@@ -233,14 +230,14 @@ static char **save_argv(int argc, const char **argv)
 
 	orig_argv = calloc(argc, sizeof(char *));
 	if (!orig_argv) {
-		perror("calloc");
+		WARN_GLIBC("calloc");
 		return NULL;
 	}
 
 	for (int i = 0; i < argc; i++) {
 		orig_argv[i] = strdup(argv[i]);
 		if (!orig_argv[i]) {
-			perror("strdup");
+			WARN_GLIBC("strdup(%s)", orig_argv[i]);
 			return NULL;
 		}
 	};
@@ -285,7 +282,7 @@ int objtool_run(int argc, const char **argv)
 		goto err;
 
 	if (!opts.link && has_multiple_files(file->elf)) {
-		ERROR("Linked object requires --link");
+		WARN("Linked object requires --link");
 		goto err;
 	}
 
@@ -313,7 +310,7 @@ err:
 	 */
 	backup = malloc(strlen(objname) + strlen(ORIG_SUFFIX) + 1);
 	if (!backup) {
-		perror("malloc");
+		WARN_GLIBC("malloc");
 		return 1;
 	}
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b0ef14a..f4e7ee8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -353,7 +353,7 @@ static struct cfi_state *cfi_alloc(void)
 {
 	struct cfi_state *cfi = calloc(1, sizeof(struct cfi_state));
 	if (!cfi) {
-		WARN("calloc failed");
+		WARN_GLIBC("calloc");
 		exit(1);
 	}
 	nr_cfi++;
@@ -409,7 +409,7 @@ static void *cfi_hash_alloc(unsigned long size)
 			PROT_READ|PROT_WRITE,
 			MAP_PRIVATE|MAP_ANON, -1, 0);
 	if (cfi_hash == (void *)-1L) {
-		WARN("mmap fail cfi_hash");
+		WARN_GLIBC("mmap fail cfi_hash");
 		cfi_hash = NULL;
 	}  else if (opts.stats) {
 		printf("cfi_bits: %d\n", cfi_bits);
@@ -465,7 +465,7 @@ static int decode_instructions(struct objtool_file *file)
 			if (!insns || idx == INSN_CHUNK_MAX) {
 				insns = calloc(sizeof(*insn), INSN_CHUNK_SIZE);
 				if (!insns) {
-					WARN("malloc failed");
+					WARN_GLIBC("calloc");
 					return -1;
 				}
 				idx = 0;
@@ -567,14 +567,21 @@ static int add_pv_ops(struct objtool_file *file, const char *symname)
 		if (!reloc)
 			break;
 
+		idx = (reloc_offset(reloc) - sym->offset) / sizeof(unsigned long);
+
 		func = reloc->sym;
 		if (func->type == STT_SECTION)
 			func = find_symbol_by_offset(reloc->sym->sec,
 						     reloc_addend(reloc));
+		if (!func) {
+			WARN_FUNC("can't find func at %s[%d]",
+				  reloc->sym->sec, reloc_addend(reloc),
+				  symname, idx);
+			return -1;
+		}
 
-		idx = (reloc_offset(reloc) - sym->offset) / sizeof(unsigned long);
-
-		objtool_pv_add(file, idx, func);
+		if (objtool_pv_add(file, idx, func))
+			return -1;
 
 		off = reloc_offset(reloc) + 1;
 		if (off > end)
@@ -598,7 +605,7 @@ static int init_pv_ops(struct objtool_file *file)
 	};
 	const char *pv_ops;
 	struct symbol *sym;
-	int idx, nr;
+	int idx, nr, ret;
 
 	if (!opts.noinstr)
 		return 0;
@@ -611,14 +618,19 @@ static int init_pv_ops(struct objtool_file *file)
 
 	nr = sym->len / sizeof(unsigned long);
 	file->pv_ops = calloc(sizeof(struct pv_state), nr);
-	if (!file->pv_ops)
+	if (!file->pv_ops) {
+		WARN_GLIBC("calloc");
 		return -1;
+	}
 
 	for (idx = 0; idx < nr; idx++)
 		INIT_LIST_HEAD(&file->pv_ops[idx].targets);
 
-	for (idx = 0; (pv_ops = pv_ops_tables[idx]); idx++)
-		add_pv_ops(file, pv_ops);
+	for (idx = 0; (pv_ops = pv_ops_tables[idx]); idx++) {
+		ret = add_pv_ops(file, pv_ops);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -666,13 +678,12 @@ static int create_static_call_sections(struct objtool_file *file)
 		/* find key symbol */
 		key_name = strdup(insn_call_dest(insn)->name);
 		if (!key_name) {
-			perror("strdup");
+			WARN_GLIBC("strdup");
 			return -1;
 		}
 		if (strncmp(key_name, STATIC_CALL_TRAMP_PREFIX_STR,
 			    STATIC_CALL_TRAMP_PREFIX_LEN)) {
 			WARN("static_call: trampoline name malformed: %s", key_name);
-			free(key_name);
 			return -1;
 		}
 		tmp = key_name + STATIC_CALL_TRAMP_PREFIX_LEN - STATIC_CALL_KEY_PREFIX_LEN;
@@ -682,7 +693,6 @@ static int create_static_call_sections(struct objtool_file *file)
 		if (!key_sym) {
 			if (!opts.module) {
 				WARN("static_call: can't find static_call_key symbol: %s", tmp);
-				free(key_name);
 				return -1;
 			}
 
@@ -697,7 +707,6 @@ static int create_static_call_sections(struct objtool_file *file)
 			 */
 			key_sym = insn_call_dest(insn);
 		}
-		free(key_name);
 
 		/* populate reloc for 'key' */
 		if (!elf_init_reloc_data_sym(file->elf, sec,
@@ -981,7 +990,7 @@ static int create_direct_call_sections(struct objtool_file *file)
 /*
  * Warnings shouldn't be reported for ignored functions.
  */
-static void add_ignores(struct objtool_file *file)
+static int add_ignores(struct objtool_file *file)
 {
 	struct section *rsec;
 	struct symbol *func;
@@ -989,7 +998,7 @@ static void add_ignores(struct objtool_file *file)
 
 	rsec = find_section_by_name(file->elf, ".rela.discard.func_stack_frame_non_standard");
 	if (!rsec)
-		return;
+		return 0;
 
 	for_each_reloc(rsec, reloc) {
 		switch (reloc->sym->type) {
@@ -1006,11 +1015,13 @@ static void add_ignores(struct objtool_file *file)
 		default:
 			WARN("unexpected relocation symbol type in %s: %d",
 			     rsec->name, reloc->sym->type);
-			continue;
+			return -1;
 		}
 
 		func->ignore = true;
 	}
+
+	return 0;
 }
 
 /*
@@ -1275,7 +1286,7 @@ static void remove_insn_ops(struct instruction *insn)
 	insn->stack_ops = NULL;
 }
 
-static void annotate_call_site(struct objtool_file *file,
+static int annotate_call_site(struct objtool_file *file,
 			       struct instruction *insn, bool sibling)
 {
 	struct reloc *reloc = insn_reloc(file, insn);
@@ -1286,12 +1297,12 @@ static void annotate_call_site(struct objtool_file *file,
 
 	if (sym->static_call_tramp) {
 		list_add_tail(&insn->call_node, &file->static_call_list);
-		return;
+		return 0;
 	}
 
 	if (sym->retpoline_thunk) {
 		list_add_tail(&insn->call_node, &file->retpoline_call_list);
-		return;
+		return 0;
 	}
 
 	/*
@@ -1303,10 +1314,12 @@ static void annotate_call_site(struct objtool_file *file,
 		if (reloc)
 			set_reloc_type(file->elf, reloc, R_NONE);
 
-		elf_write_insn(file->elf, insn->sec,
-			       insn->offset, insn->len,
-			       sibling ? arch_ret_insn(insn->len)
-			               : arch_nop_insn(insn->len));
+		if (elf_write_insn(file->elf, insn->sec,
+				   insn->offset, insn->len,
+				   sibling ? arch_ret_insn(insn->len)
+					   : arch_nop_insn(insn->len))) {
+			return -1;
+		}
 
 		insn->type = sibling ? INSN_RETURN : INSN_NOP;
 
@@ -1320,7 +1333,7 @@ static void annotate_call_site(struct objtool_file *file,
 			insn->retpoline_safe = true;
 		}
 
-		return;
+		return 0;
 	}
 
 	if (opts.mcount && sym->fentry) {
@@ -1330,15 +1343,17 @@ static void annotate_call_site(struct objtool_file *file,
 			if (reloc)
 				set_reloc_type(file->elf, reloc, R_NONE);
 
-			elf_write_insn(file->elf, insn->sec,
-				       insn->offset, insn->len,
-				       arch_nop_insn(insn->len));
+			if (elf_write_insn(file->elf, insn->sec,
+					   insn->offset, insn->len,
+					   arch_nop_insn(insn->len))) {
+				return -1;
+			}
 
 			insn->type = INSN_NOP;
 		}
 
 		list_add_tail(&insn->call_node, &file->mcount_loc_list);
-		return;
+		return 0;
 	}
 
 	if (insn->type == INSN_CALL && !insn->sec->init &&
@@ -1347,14 +1362,16 @@ static void annotate_call_site(struct objtool_file *file,
 
 	if (!sibling && dead_end_function(file, sym))
 		insn->dead_end = true;
+
+	return 0;
 }
 
-static void add_call_dest(struct objtool_file *file, struct instruction *insn,
+static int add_call_dest(struct objtool_file *file, struct instruction *insn,
 			  struct symbol *dest, bool sibling)
 {
 	insn->_call_dest = dest;
 	if (!dest)
-		return;
+		return 0;
 
 	/*
 	 * Whatever stack impact regular CALLs have, should be undone
@@ -1365,10 +1382,10 @@ static void add_call_dest(struct objtool_file *file, struct instruction *insn,
 	 */
 	remove_insn_ops(insn);
 
-	annotate_call_site(file, insn, sibling);
+	return annotate_call_site(file, insn, sibling);
 }
 
-static void add_retpoline_call(struct objtool_file *file, struct instruction *insn)
+static int add_retpoline_call(struct objtool_file *file, struct instruction *insn)
 {
 	/*
 	 * Retpoline calls/jumps are really dynamic calls/jumps in disguise,
@@ -1385,7 +1402,7 @@ static void add_retpoline_call(struct objtool_file *file, struct instruction *in
 		insn->type = INSN_JUMP_DYNAMIC_CONDITIONAL;
 		break;
 	default:
-		return;
+		return 0;
 	}
 
 	insn->retpoline_safe = true;
@@ -1399,7 +1416,7 @@ static void add_retpoline_call(struct objtool_file *file, struct instruction *in
 	 */
 	remove_insn_ops(insn);
 
-	annotate_call_site(file, insn, false);
+	return annotate_call_site(file, insn, false);
 }
 
 static void add_return_call(struct objtool_file *file, struct instruction *insn, bool add)
@@ -1468,6 +1485,7 @@ static int add_jump_destinations(struct objtool_file *file)
 	struct reloc *reloc;
 	struct section *dest_sec;
 	unsigned long dest_off;
+	int ret;
 
 	for_each_insn(file, insn) {
 		if (insn->jump_dest) {
@@ -1488,7 +1506,9 @@ static int add_jump_destinations(struct objtool_file *file)
 			dest_sec = reloc->sym->sec;
 			dest_off = arch_dest_reloc_offset(reloc_addend(reloc));
 		} else if (reloc->sym->retpoline_thunk) {
-			add_retpoline_call(file, insn);
+			ret = add_retpoline_call(file, insn);
+			if (ret)
+				return ret;
 			continue;
 		} else if (reloc->sym->return_thunk) {
 			add_return_call(file, insn, true);
@@ -1498,7 +1518,9 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * External sibling call or internal sibling call with
 			 * STT_FUNC reloc.
 			 */
-			add_call_dest(file, insn, reloc->sym, true);
+			ret = add_call_dest(file, insn, reloc->sym, true);
+			if (ret)
+				return ret;
 			continue;
 		} else if (reloc->sym->sec->idx) {
 			dest_sec = reloc->sym->sec;
@@ -1538,7 +1560,9 @@ static int add_jump_destinations(struct objtool_file *file)
 		 */
 		if (jump_dest->sym && jump_dest->offset == jump_dest->sym->offset) {
 			if (jump_dest->sym->retpoline_thunk) {
-				add_retpoline_call(file, insn);
+				ret = add_retpoline_call(file, insn);
+				if (ret)
+					return ret;
 				continue;
 			}
 			if (jump_dest->sym->return_thunk) {
@@ -1580,7 +1604,9 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * Internal sibling call without reloc or with
 			 * STT_SECTION reloc.
 			 */
-			add_call_dest(file, insn, insn_func(jump_dest), true);
+			ret = add_call_dest(file, insn, insn_func(jump_dest), true);
+			if (ret)
+				return ret;
 			continue;
 		}
 
@@ -1610,6 +1636,7 @@ static int add_call_destinations(struct objtool_file *file)
 	unsigned long dest_off;
 	struct symbol *dest;
 	struct reloc *reloc;
+	int ret;
 
 	for_each_insn(file, insn) {
 		struct symbol *func = insn_func(insn);
@@ -1621,7 +1648,9 @@ static int add_call_destinations(struct objtool_file *file)
 			dest_off = arch_jump_destination(insn);
 			dest = find_call_destination(insn->sec, dest_off);
 
-			add_call_dest(file, insn, dest, false);
+			ret = add_call_dest(file, insn, dest, false);
+			if (ret)
+				return ret;
 
 			if (func && func->ignore)
 				continue;
@@ -1645,13 +1674,20 @@ static int add_call_destinations(struct objtool_file *file)
 				return -1;
 			}
 
-			add_call_dest(file, insn, dest, false);
+			ret = add_call_dest(file, insn, dest, false);
+			if (ret)
+				return ret;
 
 		} else if (reloc->sym->retpoline_thunk) {
-			add_retpoline_call(file, insn);
+			ret = add_retpoline_call(file, insn);
+			if (ret)
+				return ret;
 
-		} else
-			add_call_dest(file, insn, reloc->sym, false);
+		} else {
+			ret = add_call_dest(file, insn, reloc->sym, false);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return 0;
@@ -1674,15 +1710,15 @@ static int handle_group_alt(struct objtool_file *file,
 	if (!orig_alt_group) {
 		struct instruction *last_orig_insn = NULL;
 
-		orig_alt_group = malloc(sizeof(*orig_alt_group));
+		orig_alt_group = calloc(1, sizeof(*orig_alt_group));
 		if (!orig_alt_group) {
-			WARN("malloc failed");
+			WARN_GLIBC("calloc");
 			return -1;
 		}
 		orig_alt_group->cfi = calloc(special_alt->orig_len,
 					     sizeof(struct cfi_state *));
 		if (!orig_alt_group->cfi) {
-			WARN("calloc failed");
+			WARN_GLIBC("calloc");
 			return -1;
 		}
 
@@ -1711,9 +1747,9 @@ static int handle_group_alt(struct objtool_file *file,
 		}
 	}
 
-	new_alt_group = malloc(sizeof(*new_alt_group));
+	new_alt_group = calloc(1, sizeof(*new_alt_group));
 	if (!new_alt_group) {
-		WARN("malloc failed");
+		WARN_GLIBC("calloc");
 		return -1;
 	}
 
@@ -1725,9 +1761,9 @@ static int handle_group_alt(struct objtool_file *file,
 		 * instruction affects the stack, the instruction after it (the
 		 * nop) will propagate the new state to the shared CFI array.
 		 */
-		nop = malloc(sizeof(*nop));
+		nop = calloc(1, sizeof(*nop));
 		if (!nop) {
-			WARN("malloc failed");
+			WARN_GLIBC("calloc");
 			return -1;
 		}
 		memset(nop, 0, sizeof(*nop));
@@ -1827,9 +1863,13 @@ static int handle_jump_alt(struct objtool_file *file,
 
 		if (reloc)
 			set_reloc_type(file->elf, reloc, R_NONE);
-		elf_write_insn(file->elf, orig_insn->sec,
-			       orig_insn->offset, orig_insn->len,
-			       arch_nop_insn(orig_insn->len));
+
+		if (elf_write_insn(file->elf, orig_insn->sec,
+				   orig_insn->offset, orig_insn->len,
+				   arch_nop_insn(orig_insn->len))) {
+			return -1;
+		}
+
 		orig_insn->type = INSN_NOP;
 	}
 
@@ -1865,9 +1905,8 @@ static int add_special_section_alts(struct objtool_file *file)
 	struct alternative *alt;
 	int ret;
 
-	ret = special_get_alts(file->elf, &special_alts);
-	if (ret)
-		return ret;
+	if (special_get_alts(file->elf, &special_alts))
+		return -1;
 
 	list_for_each_entry_safe(special_alt, tmp, &special_alts, list) {
 
@@ -1876,8 +1915,7 @@ static int add_special_section_alts(struct objtool_file *file)
 		if (!orig_insn) {
 			WARN_FUNC("special: can't find orig instruction",
 				  special_alt->orig_sec, special_alt->orig_off);
-			ret = -1;
-			goto out;
+			return -1;
 		}
 
 		new_insn = NULL;
@@ -1888,8 +1926,7 @@ static int add_special_section_alts(struct objtool_file *file)
 				WARN_FUNC("special: can't find new instruction",
 					  special_alt->new_sec,
 					  special_alt->new_off);
-				ret = -1;
-				goto out;
+				return -1;
 			}
 		}
 
@@ -1902,19 +1939,19 @@ static int add_special_section_alts(struct objtool_file *file)
 			ret = handle_group_alt(file, special_alt, orig_insn,
 					       &new_insn);
 			if (ret)
-				goto out;
+				return ret;
+
 		} else if (special_alt->jump_or_nop) {
 			ret = handle_jump_alt(file, special_alt, orig_insn,
 					      &new_insn);
 			if (ret)
-				goto out;
+				return ret;
 		}
 
-		alt = malloc(sizeof(*alt));
+		alt = calloc(1, sizeof(*alt));
 		if (!alt) {
-			WARN("malloc failed");
-			ret = -1;
-			goto out;
+			WARN_GLIBC("calloc");
+			return -1;
 		}
 
 		alt->insn = new_insn;
@@ -1931,8 +1968,7 @@ static int add_special_section_alts(struct objtool_file *file)
 		printf("long:\t%ld\t%ld\n", file->jl_nop_long, file->jl_long);
 	}
 
-out:
-	return ret;
+	return 0;
 }
 
 __weak unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *table)
@@ -1989,9 +2025,9 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn)
 		if (!insn_func(dest_insn) || insn_func(dest_insn)->pfunc != pfunc)
 			break;
 
-		alt = malloc(sizeof(*alt));
+		alt = calloc(1, sizeof(*alt));
 		if (!alt) {
-			WARN("malloc failed");
+			WARN_GLIBC("calloc");
 			return -1;
 		}
 
@@ -2039,7 +2075,7 @@ static void find_jump_table(struct objtool_file *file, struct symbol *func,
 		    insn->jump_dest &&
 		    (insn->jump_dest->offset <= insn->offset ||
 		     insn->jump_dest->offset > orig_insn->offset))
-		    break;
+			break;
 
 		table_reloc = arch_find_switch_table(file, insn, &table_size);
 		if (!table_reloc)
@@ -2103,7 +2139,6 @@ static int add_func_jump_tables(struct objtool_file *file,
 		if (!insn_jump_table(insn))
 			continue;
 
-
 		ret = add_jump_table(file, insn);
 		if (ret)
 			return ret;
@@ -2221,6 +2256,7 @@ static int read_unwind_hints(struct objtool_file *file)
 			if (sym && sym->bind == STB_GLOBAL) {
 				if (opts.ibt && insn->type != INSN_ENDBR && !insn->noendbr) {
 					WARN_INSN(insn, "UNWIND_HINT_IRET_REGS without ENDBR");
+					return -1;
 				}
 			}
 		}
@@ -2390,7 +2426,7 @@ static int __annotate_late(struct objtool_file *file, int type, struct instructi
 
 	default:
 		WARN_INSN(insn, "Unknown annotation type: %d", type);
-		break;
+		return -1;
 	}
 
 	return 0;
@@ -2503,7 +2539,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	add_ignores(file);
+	ret = add_ignores(file);
+	if (ret)
+		return ret;
+
 	add_uaccess_safe(file);
 
 	ret = read_annotate(file, __annotate_early);
@@ -2723,7 +2762,7 @@ static int update_cfi_state(struct instruction *insn,
 	if (cfa->base == CFI_UNDEFINED) {
 		if (insn_func(insn)) {
 			WARN_INSN(insn, "undefined stack state");
-			return -1;
+			return 1;
 		}
 		return 0;
 	}
@@ -3166,9 +3205,8 @@ static int propagate_alt_cfi(struct objtool_file *file, struct instruction *insn
 		if (cficmp(alt_cfi[group_off], insn->cfi)) {
 			struct alt_group *orig_group = insn->alt_group->orig_group ?: insn->alt_group;
 			struct instruction *orig = orig_group->first_insn;
-			char *where = offstr(insn->sec, insn->offset);
-			WARN_INSN(orig, "stack layout conflict in alternatives: %s", where);
-			free(where);
+			WARN_INSN(orig, "stack layout conflict in alternatives: %s",
+				  offstr(insn->sec, insn->offset));
 			return -1;
 		}
 	}
@@ -3181,11 +3219,13 @@ static int handle_insn_ops(struct instruction *insn,
 			   struct insn_state *state)
 {
 	struct stack_op *op;
+	int ret;
 
 	for (op = insn->stack_ops; op; op = op->next) {
 
-		if (update_cfi_state(insn, next_insn, &state->cfi, op))
-			return 1;
+		ret = update_cfi_state(insn, next_insn, &state->cfi, op);
+		if (ret)
+			return ret;
 
 		if (!opts.uaccess || !insn->alt_group)
 			continue;
@@ -3229,36 +3269,41 @@ static bool insn_cfi_match(struct instruction *insn, struct cfi_state *cfi2)
 		WARN_INSN(insn, "stack state mismatch: cfa1=%d%+d cfa2=%d%+d",
 			  cfi1->cfa.base, cfi1->cfa.offset,
 			  cfi2->cfa.base, cfi2->cfa.offset);
+		return false;
 
-	} else if (memcmp(&cfi1->regs, &cfi2->regs, sizeof(cfi1->regs))) {
+	}
+
+	if (memcmp(&cfi1->regs, &cfi2->regs, sizeof(cfi1->regs))) {
 		for (i = 0; i < CFI_NUM_REGS; i++) {
-			if (!memcmp(&cfi1->regs[i], &cfi2->regs[i],
-				    sizeof(struct cfi_reg)))
+
+			if (!memcmp(&cfi1->regs[i], &cfi2->regs[i], sizeof(struct cfi_reg)))
 				continue;
 
 			WARN_INSN(insn, "stack state mismatch: reg1[%d]=%d%+d reg2[%d]=%d%+d",
 				  i, cfi1->regs[i].base, cfi1->regs[i].offset,
 				  i, cfi2->regs[i].base, cfi2->regs[i].offset);
-			break;
 		}
+		return false;
+	}
 
-	} else if (cfi1->type != cfi2->type) {
+	if (cfi1->type != cfi2->type) {
 
 		WARN_INSN(insn, "stack state mismatch: type1=%d type2=%d",
 			  cfi1->type, cfi2->type);
+		return false;
+	}
 
-	} else if (cfi1->drap != cfi2->drap ||
+	if (cfi1->drap != cfi2->drap ||
 		   (cfi1->drap && cfi1->drap_reg != cfi2->drap_reg) ||
 		   (cfi1->drap && cfi1->drap_offset != cfi2->drap_offset)) {
 
 		WARN_INSN(insn, "stack state mismatch: drap1=%d(%d,%d) drap2=%d(%d,%d)",
 			  cfi1->drap, cfi1->drap_reg, cfi1->drap_offset,
 			  cfi2->drap, cfi2->drap_reg, cfi2->drap_offset);
+		return false;
+	}
 
-	} else
-		return true;
-
-	return false;
+	return true;
 }
 
 static inline bool func_uaccess_safe(struct symbol *func)
@@ -3490,6 +3535,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn_func(insn)->name);
+			func->warnings++;
+
 			return 1;
 		}
 
@@ -3597,9 +3644,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				return 1;
 			}
 
-			if (insn->dead_end)
-				return 0;
-
 			break;
 
 		case INSN_JUMP_CONDITIONAL:
@@ -3706,7 +3750,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (file->ignore_unreachables)
 				return 0;
 
-			WARN("%s: unexpected end of section", sec->name);
+			WARN("%s%sunexpected end of section %s",
+			     func ? func->name : "", func ? ": " : "",
+			     sec->name);
 			return 1;
 		}
 
@@ -3796,7 +3842,7 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 			if (!is_sibling_call(insn)) {
 				if (!insn->jump_dest) {
 					WARN_INSN(insn, "unresolved jump target after linking?!?");
-					return -1;
+					return 1;
 				}
 				ret = validate_unret(file, insn->jump_dest);
 				if (ret) {
@@ -3818,7 +3864,7 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 			if (!dest) {
 				WARN("Unresolved function after linking!?: %s",
 				     insn_call_dest(insn)->name);
-				return -1;
+				return 1;
 			}
 
 			ret = validate_unret(file, dest);
@@ -3847,7 +3893,7 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 
 		if (!next) {
 			WARN_INSN(insn, "teh end!");
-			return -1;
+			return 1;
 		}
 		insn = next;
 	}
@@ -3862,18 +3908,13 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 static int validate_unrets(struct objtool_file *file)
 {
 	struct instruction *insn;
-	int ret, warnings = 0;
+	int warnings = 0;
 
 	for_each_insn(file, insn) {
 		if (!insn->unret)
 			continue;
 
-		ret = validate_unret(file, insn);
-		if (ret < 0) {
-			WARN_INSN(insn, "Failed UNRET validation");
-			return ret;
-		}
-		warnings += ret;
+		warnings += validate_unret(file, insn);
 	}
 
 	return warnings;
@@ -3899,13 +3940,13 @@ static int validate_retpoline(struct objtool_file *file)
 		if (insn->type == INSN_RETURN) {
 			if (opts.rethunk) {
 				WARN_INSN(insn, "'naked' return found in MITIGATION_RETHUNK build");
-			} else
-				continue;
-		} else {
-			WARN_INSN(insn, "indirect %s found in MITIGATION_RETPOLINE build",
-				  insn->type == INSN_JUMP_DYNAMIC ? "jump" : "call");
+				warnings++;
+			}
+			continue;
 		}
 
+		WARN_INSN(insn, "indirect %s found in MITIGATION_RETPOLINE build",
+			  insn->type == INSN_JUMP_DYNAMIC ? "jump" : "call");
 		warnings++;
 	}
 
@@ -4472,7 +4513,7 @@ static int validate_reachable_instructions(struct objtool_file *file)
 }
 
 /* 'funcs' is a space-separated list of function names */
-static int disas_funcs(const char *funcs)
+static void disas_funcs(const char *funcs)
 {
 	const char *objdump_str, *cross_compile;
 	int size, ret;
@@ -4505,7 +4546,7 @@ static int disas_funcs(const char *funcs)
 	size = snprintf(NULL, 0, objdump_str, cross_compile, objname, funcs) + 1;
 	if (size <= 0) {
 		WARN("objdump string size calculation failed");
-		return -1;
+		return;
 	}
 
 	cmd = malloc(size);
@@ -4515,13 +4556,11 @@ static int disas_funcs(const char *funcs)
 	ret = system(cmd);
 	if (ret) {
 		WARN("disassembly failed: %d", ret);
-		return -1;
+		return;
 	}
-
-	return 0;
 }
 
-static int disas_warned_funcs(struct objtool_file *file)
+static void disas_warned_funcs(struct objtool_file *file)
 {
 	struct symbol *sym;
 	char *funcs = NULL, *tmp;
@@ -4530,9 +4569,17 @@ static int disas_warned_funcs(struct objtool_file *file)
 		if (sym->warnings) {
 			if (!funcs) {
 				funcs = malloc(strlen(sym->name) + 1);
+				if (!funcs) {
+					WARN_GLIBC("malloc");
+					return;
+				}
 				strcpy(funcs, sym->name);
 			} else {
 				tmp = malloc(strlen(funcs) + strlen(sym->name) + 2);
+				if (!tmp) {
+					WARN_GLIBC("malloc");
+					return;
+				}
 				sprintf(tmp, "%s %s", funcs, sym->name);
 				free(funcs);
 				funcs = tmp;
@@ -4542,8 +4589,6 @@ static int disas_warned_funcs(struct objtool_file *file)
 
 	if (funcs)
 		disas_funcs(funcs);
-
-	return 0;
 }
 
 struct insn_chunk {
@@ -4576,7 +4621,7 @@ static void free_insns(struct objtool_file *file)
 
 int check(struct objtool_file *file)
 {
-	int ret, warnings = 0;
+	int ret = 0, warnings = 0;
 
 	arch_initial_func_cfi_state(&initial_func_cfi);
 	init_cfi_state(&init_cfi);
@@ -4594,44 +4639,27 @@ int check(struct objtool_file *file)
 	cfi_hash_add(&func_cfi);
 
 	ret = decode_sections(file);
-	if (ret < 0)
+	if (ret)
 		goto out;
 
-	warnings += ret;
-
 	if (!nr_insns)
 		goto out;
 
-	if (opts.retpoline) {
-		ret = validate_retpoline(file);
-		if (ret < 0)
-			goto out;
-		warnings += ret;
-	}
+	if (opts.retpoline)
+		warnings += validate_retpoline(file);
 
 	if (opts.stackval || opts.orc || opts.uaccess) {
-		ret = validate_functions(file);
-		if (ret < 0)
-			goto out;
-		warnings += ret;
+		int w = 0;
 
-		ret = validate_unwind_hints(file, NULL);
-		if (ret < 0)
-			goto out;
-		warnings += ret;
+		w += validate_functions(file);
+		w += validate_unwind_hints(file, NULL);
+		if (!w)
+			w += validate_reachable_instructions(file);
 
-		if (!warnings) {
-			ret = validate_reachable_instructions(file);
-			if (ret < 0)
-				goto out;
-			warnings += ret;
-		}
+		warnings += w;
 
 	} else if (opts.noinstr) {
-		ret = validate_noinstr_sections(file);
-		if (ret < 0)
-			goto out;
-		warnings += ret;
+		warnings += validate_noinstr_sections(file);
 	}
 
 	if (opts.unret) {
@@ -4639,87 +4667,67 @@ int check(struct objtool_file *file)
 		 * Must be after validate_branch() and friends, it plays
 		 * further games with insn->visited.
 		 */
-		ret = validate_unrets(file);
-		if (ret < 0)
-			goto out;
-		warnings += ret;
+		warnings += validate_unrets(file);
 	}
 
-	if (opts.ibt) {
-		ret = validate_ibt(file);
-		if (ret < 0)
-			goto out;
-		warnings += ret;
-	}
+	if (opts.ibt)
+		warnings += validate_ibt(file);
 
-	if (opts.sls) {
-		ret = validate_sls(file);
-		if (ret < 0)
-			goto out;
-		warnings += ret;
-	}
+	if (opts.sls)
+		warnings += validate_sls(file);
 
 	if (opts.static_call) {
 		ret = create_static_call_sections(file);
-		if (ret < 0)
+		if (ret)
 			goto out;
-		warnings += ret;
 	}
 
 	if (opts.retpoline) {
 		ret = create_retpoline_sites_sections(file);
-		if (ret < 0)
+		if (ret)
 			goto out;
-		warnings += ret;
 	}
 
 	if (opts.cfi) {
 		ret = create_cfi_sections(file);
-		if (ret < 0)
+		if (ret)
 			goto out;
-		warnings += ret;
 	}
 
 	if (opts.rethunk) {
 		ret = create_return_sites_sections(file);
-		if (ret < 0)
+		if (ret)
 			goto out;
-		warnings += ret;
 
 		if (opts.hack_skylake) {
 			ret = create_direct_call_sections(file);
-			if (ret < 0)
+			if (ret)
 				goto out;
-			warnings += ret;
 		}
 	}
 
 	if (opts.mcount) {
 		ret = create_mcount_loc_sections(file);
-		if (ret < 0)
+		if (ret)
 			goto out;
-		warnings += ret;
 	}
 
 	if (opts.prefix) {
 		ret = add_prefix_symbols(file);
-		if (ret < 0)
+		if (ret)
 			goto out;
-		warnings += ret;
 	}
 
 	if (opts.ibt) {
 		ret = create_ibt_endbr_seal_sections(file);
-		if (ret < 0)
+		if (ret)
 			goto out;
-		warnings += ret;
 	}
 
 	if (opts.orc && nr_insns) {
 		ret = orc_create(file);
-		if (ret < 0)
+		if (ret)
 			goto out;
-		warnings += ret;
 	}
 
 	free_insns(file);
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 0f38167..b352a78 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -331,7 +331,7 @@ static int read_sections(struct elf *elf)
 
 	elf->section_data = calloc(sections_nr, sizeof(*sec));
 	if (!elf->section_data) {
-		perror("calloc");
+		WARN_GLIBC("calloc");
 		return -1;
 	}
 	for (i = 0; i < sections_nr; i++) {
@@ -467,7 +467,7 @@ static int read_symbols(struct elf *elf)
 
 	elf->symbol_data = calloc(symbols_nr, sizeof(*sym));
 	if (!elf->symbol_data) {
-		perror("calloc");
+		WARN_GLIBC("calloc");
 		return -1;
 	}
 	for (i = 0; i < symbols_nr; i++) {
@@ -799,7 +799,7 @@ elf_create_section_symbol(struct elf *elf, struct section *sec)
 	struct symbol *sym = calloc(1, sizeof(*sym));
 
 	if (!sym) {
-		perror("malloc");
+		WARN_GLIBC("malloc");
 		return NULL;
 	}
 
@@ -829,7 +829,7 @@ elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size)
 	char *name = malloc(namelen);
 
 	if (!sym || !name) {
-		perror("malloc");
+		WARN_GLIBC("malloc");
 		return NULL;
 	}
 
@@ -963,7 +963,7 @@ static int read_relocs(struct elf *elf)
 		nr_reloc = 0;
 		rsec->relocs = calloc(sec_num_entries(rsec), sizeof(*reloc));
 		if (!rsec->relocs) {
-			perror("calloc");
+			WARN_GLIBC("calloc");
 			return -1;
 		}
 		for (i = 0; i < sec_num_entries(rsec); i++) {
@@ -1005,7 +1005,7 @@ struct elf *elf_open_read(const char *name, int flags)
 
 	elf = malloc(sizeof(*elf));
 	if (!elf) {
-		perror("malloc");
+		WARN_GLIBC("malloc");
 		return NULL;
 	}
 	memset(elf, 0, sizeof(*elf));
@@ -1099,7 +1099,7 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 
 	sec = malloc(sizeof(*sec));
 	if (!sec) {
-		perror("malloc");
+		WARN_GLIBC("malloc");
 		return NULL;
 	}
 	memset(sec, 0, sizeof(*sec));
@@ -1114,7 +1114,7 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 
 	sec->name = strdup(name);
 	if (!sec->name) {
-		perror("strdup");
+		WARN_GLIBC("strdup");
 		return NULL;
 	}
 
@@ -1132,7 +1132,7 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	if (size) {
 		sec->data->d_buf = malloc(size);
 		if (!sec->data->d_buf) {
-			perror("malloc");
+			WARN_GLIBC("malloc");
 			return NULL;
 		}
 		memset(sec->data->d_buf, 0, size);
@@ -1179,7 +1179,7 @@ static struct section *elf_create_rela_section(struct elf *elf,
 
 	rsec_name = malloc(strlen(sec->name) + strlen(".rela") + 1);
 	if (!rsec_name) {
-		perror("malloc");
+		WARN_GLIBC("malloc");
 		return NULL;
 	}
 	strcpy(rsec_name, ".rela");
@@ -1199,7 +1199,7 @@ static struct section *elf_create_rela_section(struct elf *elf,
 
 	rsec->relocs = calloc(sec_num_entries(rsec), sizeof(struct reloc));
 	if (!rsec->relocs) {
-		perror("calloc");
+		WARN_GLIBC("calloc");
 		return NULL;
 	}
 
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/objtool/objtool.h
index 94a33ee..c0dc86a 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -41,7 +41,7 @@ struct objtool_file {
 
 struct objtool_file *objtool_open_read(const char *_objname);
 
-void objtool_pv_add(struct objtool_file *file, int idx, struct symbol *func);
+int objtool_pv_add(struct objtool_file *file, int idx, struct symbol *func);
 
 int check(struct objtool_file *file);
 int orc_dump(const char *objname);
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index e72b9d6..b29ac14 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -11,6 +11,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <errno.h>
 #include <objtool/builtin.h>
 #include <objtool/elf.h>
 
@@ -43,8 +44,9 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 
 #define WARN(format, ...)				\
 	fprintf(stderr,					\
-		"%s: %s: objtool: " format "\n",	\
-		objname,				\
+		"%s%s%s: objtool: " format "\n",	\
+		objname ?: "",				\
+		objname ? ": " : "",			\
 		opts.werror ? "error" : "warning",	\
 		##__VA_ARGS__)
 
@@ -83,7 +85,10 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 	}							\
 })
 
-#define WARN_ELF(format, ...)				\
-	WARN(format ": %s", ##__VA_ARGS__, elf_errmsg(-1))
+#define WARN_ELF(format, ...)					\
+	WARN("%s: " format " failed: %s", __func__, ##__VA_ARGS__, elf_errmsg(-1))
+
+#define WARN_GLIBC(format, ...)					\
+	WARN("%s: " format " failed: %s", __func__, ##__VA_ARGS__, strerror(errno))
 
 #endif /* _WARN_H */
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 1c73fb6..e4b49c5 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -44,14 +44,14 @@ struct objtool_file *objtool_open_read(const char *filename)
 	return &file;
 }
 
-void objtool_pv_add(struct objtool_file *f, int idx, struct symbol *func)
+int objtool_pv_add(struct objtool_file *f, int idx, struct symbol *func)
 {
 	if (!opts.noinstr)
-		return;
+		return 0;
 
 	if (!f->pv_ops) {
 		WARN("paravirt confusion");
-		return;
+		return -1;
 	}
 
 	/*
@@ -60,14 +60,15 @@ void objtool_pv_add(struct objtool_file *f, int idx, struct symbol *func)
 	 */
 	if (!strcmp(func->name, "_paravirt_nop") ||
 	    !strcmp(func->name, "_paravirt_ident_64"))
-		return;
+		return 0;
 
 	/* already added this function */
 	if (!list_empty(&func->pv_target))
-		return;
+		return 0;
 
 	list_add(&func->pv_target, &f->pv_ops[idx].targets);
 	f->pv_ops[idx].clean = false;
+	return 0;
 }
 
 int main(int argc, const char **argv)

