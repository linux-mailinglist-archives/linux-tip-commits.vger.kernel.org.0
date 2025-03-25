Return-Path: <linux-tip-commits+bounces-4468-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD448A6EBC6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0761895478
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783DC2586D5;
	Tue, 25 Mar 2025 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OngWmljs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="45c8+9Xy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48632257AED;
	Tue, 25 Mar 2025 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891715; cv=none; b=KpUYv/z3P9MxaOBW9HflVbfX7JSP6k31w8Pdp82rYaN0wO0c3AecJOOhXLz1BlBBDeL73YglTCwyg+Ht07eRZ1FEA9JdHkXpc0bakU6oO9wMeg0jj4Rt5JnOz93F7Nl5XzXBtnMFtVo6rnkXX587Bv399F3HV+ROHido9O+YMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891715; c=relaxed/simple;
	bh=QFBPsvx6/ycXHTZo6GlwH5tOm54KuE9ZTbTS/sSRHik=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sEim/isjTNiM5pf4atC2YxIVLMWvmUn9JfrUc84/SbJvh1QrU+f9Y9N7wvJMgcsZPBIPq3tZNINdJgnOYkhII9kVw42A7MuaspK5gRmRLLQyDn+S2XE/pXAfsD9OadsSQyuWhLulGi+BL85OJmSQa26xswdIALLwcX+6W2nnj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OngWmljs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=45c8+9Xy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:35:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891712;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utHuU1RpUfun8NDz/7xeRjJ351N6RzbQuI41jj/r2lY=;
	b=OngWmljsZHXoG6xJnzaugq+yuShwQms4S8L5wXHM1o7fGpOsbF6Xxv4ixdQrbxfpYLXAH4
	M3Z/9lph2ZB7L6WNZ9YFgtKMct/ZlzbEnjCE+rsboF1zlkxDQKCKLkMxcEsE5ElyyXdezV
	8+e4g2X6X0azq3T9bAemGWgFsKap1YpJFHhhew+JLfx40DsNTm6lIHSPCVkwZxEGLe/nAH
	HYR+CNx2LtPmKesyTDieRQ1qjmVHW9o+Nh8VSXQ2pk/9wbSuKz5ztCsY8kIM4QJujCUXfd
	O0vbEjSfrJjZN9OBtvd3mIj9or/9aoCzvoQDUsNDh3ex8oPqY7KBft/NfvErKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891712;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utHuU1RpUfun8NDz/7xeRjJ351N6RzbQuI41jj/r2lY=;
	b=45c8+9XyGRT93u63hi+LXHaQdtOa7VkJ/Vz9ZijNydWyNvRFavXQx1tgXSx+SmSXnH+b80
	U5WeTJN0fwQ5soBA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix detection of consecutive jump
 tables on Clang 20
Cc: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <141752fff614eab962dba6bdfaa54aa67ff03bba.1742852846.git.jpoimboe@kernel.org>
References:
 <141752fff614eab962dba6bdfaa54aa67ff03bba.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289171133.14745.15063796259846197040.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     ef753d66051ca03bee1982ce047f9eaf90f81ab4
Gitweb:        https://git.kernel.org/tip/ef753d66051ca03bee1982ce047f9eaf90f81ab4
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:55:51 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:25 +01:00

objtool: Fix detection of consecutive jump tables on Clang 20

The jump table detection code assumes jump tables are in the same order
as their corresponding indirect branches.  That's apparently not always
true with Clang 20.

Fix that by changing how multiple jump tables are detected.  In the
first detection pass, mark the beginning of each jump table so the
second pass can tell where one ends and the next one begins.

Fixes the following warnings:

  vmlinux.o: warning: objtool: SiS_GetCRT2Ptr+0x1ad: stack state mismatch: cfa1=4+8 cfa2=5+16
  sound/core/seq/snd-seq.o: warning: objtool: cc_ev_to_ump_midi2+0x589: return with modified stack frame

Fixes: be2f0b1e1264 ("objtool: Get rid of reloc->jump_table_start")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/141752fff614eab962dba6bdfaa54aa67ff03bba.1742852846.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/oe-kbuild-all/202503171547.LlCTJLQL-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202503200535.J3hAvcjw-lkp@intel.com/
---
 tools/objtool/check.c               | 26 ++++++++------------------
 tools/objtool/elf.c                 |  6 +++---
 tools/objtool/include/objtool/elf.h | 27 ++++++++++++++++++++++++++-
 3 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ca3435a..dae17ed 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1941,8 +1941,7 @@ __weak unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct relo
 	return reloc->sym->offset + reloc_addend(reloc);
 }
 
-static int add_jump_table(struct objtool_file *file, struct instruction *insn,
-			  struct reloc *next_table)
+static int add_jump_table(struct objtool_file *file, struct instruction *insn)
 {
 	unsigned long table_size = insn_jump_table_size(insn);
 	struct symbol *pfunc = insn_func(insn)->pfunc;
@@ -1962,7 +1961,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		/* Check for the end of the table: */
 		if (table_size && reloc_offset(reloc) - reloc_offset(table) >= table_size)
 			break;
-		if (reloc != table && reloc == next_table)
+		if (reloc != table && is_jump_table(reloc))
 			break;
 
 		/* Make sure the table entries are consecutive: */
@@ -2053,8 +2052,10 @@ static void find_jump_table(struct objtool_file *file, struct symbol *func,
 		if (!dest_insn || !insn_func(dest_insn) || insn_func(dest_insn)->pfunc != func)
 			continue;
 
+		set_jump_table(table_reloc);
 		orig_insn->_jump_table = table_reloc;
 		orig_insn->_jump_table_size = table_size;
+
 		break;
 	}
 }
@@ -2096,31 +2097,20 @@ static void mark_func_jump_tables(struct objtool_file *file,
 static int add_func_jump_tables(struct objtool_file *file,
 				  struct symbol *func)
 {
-	struct instruction *insn, *insn_t1 = NULL, *insn_t2;
-	int ret = 0;
+	struct instruction *insn;
+	int ret;
 
 	func_for_each_insn(file, func, insn) {
 		if (!insn_jump_table(insn))
 			continue;
 
-		if (!insn_t1) {
-			insn_t1 = insn;
-			continue;
-		}
-
-		insn_t2 = insn;
 
-		ret = add_jump_table(file, insn_t1, insn_jump_table(insn_t2));
+		ret = add_jump_table(file, insn);
 		if (ret)
 			return ret;
-
-		insn_t1 = insn_t2;
 	}
 
-	if (insn_t1)
-		ret = add_jump_table(file, insn_t1, NULL);
-
-	return ret;
+	return 0;
 }
 
 /*
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index be4f4b6..0f38167 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -583,7 +583,7 @@ static int elf_update_sym_relocs(struct elf *elf, struct symbol *sym)
 {
 	struct reloc *reloc;
 
-	for (reloc = sym->relocs; reloc; reloc = reloc->sym_next_reloc)
+	for (reloc = sym->relocs; reloc; reloc = sym_next_reloc(reloc))
 		set_reloc_sym(elf, reloc, reloc->sym->idx);
 
 	return 0;
@@ -880,7 +880,7 @@ static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 	set_reloc_addend(elf, reloc, addend);
 
 	elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
-	reloc->sym_next_reloc = sym->relocs;
+	set_sym_next_reloc(reloc, sym->relocs);
 	sym->relocs = reloc;
 
 	return reloc;
@@ -979,7 +979,7 @@ static int read_relocs(struct elf *elf)
 			}
 
 			elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
-			reloc->sym_next_reloc = sym->relocs;
+			set_sym_next_reloc(reloc, sym->relocs);
 			sym->relocs = reloc;
 
 			nr_reloc++;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 223ac1c..4edc957 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -77,7 +77,7 @@ struct reloc {
 	struct elf_hash_node hash;
 	struct section *sec;
 	struct symbol *sym;
-	struct reloc *sym_next_reloc;
+	unsigned long _sym_next_reloc;
 };
 
 struct elf {
@@ -297,6 +297,31 @@ static inline void set_reloc_type(struct elf *elf, struct reloc *reloc, unsigned
 	mark_sec_changed(elf, reloc->sec, true);
 }
 
+#define RELOC_JUMP_TABLE_BIT 1UL
+
+/* Does reloc mark the beginning of a jump table? */
+static inline bool is_jump_table(struct reloc *reloc)
+{
+	return reloc->_sym_next_reloc & RELOC_JUMP_TABLE_BIT;
+}
+
+static inline void set_jump_table(struct reloc *reloc)
+{
+	reloc->_sym_next_reloc |= RELOC_JUMP_TABLE_BIT;
+}
+
+static inline struct reloc *sym_next_reloc(struct reloc *reloc)
+{
+	return (struct reloc *)(reloc->_sym_next_reloc & ~RELOC_JUMP_TABLE_BIT);
+}
+
+static inline void set_sym_next_reloc(struct reloc *reloc, struct reloc *next)
+{
+	unsigned long bit = reloc->_sym_next_reloc & RELOC_JUMP_TABLE_BIT;
+
+	reloc->_sym_next_reloc = (unsigned long)next | bit;
+}
+
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
 

