Return-Path: <linux-tip-commits+bounces-4216-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D86A61C0B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 21:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A264F882A29
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 20:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18CF2063EA;
	Fri, 14 Mar 2025 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0hHmqUe8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HKEDBxHU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7C0204F92;
	Fri, 14 Mar 2025 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982645; cv=none; b=BUBsbgj7wj5/6wbLO5ZNwtx6Lt3Mc1mHoQVO312LOjTZRnC1ISuJtX5dhK4uTBw0rumSCrOX5301lNRiwBNiYa2zT865ipX9TOPQyNo1oH3uUHM1xOlmNZHb7PUboKrrkdxTAwjvyTbGRAsHaZAwyWBcRFUZChLcvXmy2moSJA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982645; c=relaxed/simple;
	bh=pS8BWhRoNsihacIKX+qfq4LEuGqJ2JBR+CCTj8Iu2Ws=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ix1HJ7nX5Me7gntX5t4lbQVmcycCwBs8lbtlgJ1yheSelbSzy9EFlUK5Sc01Ae1Brn/04GU0NOLfQy42wRcRg8ztBVLX1W/dA1iv0fUih/TQ/lCfeuV6/3Mwg/Npros9w8ofu7Om4JO2s3yA8PFmlPlwPtv/lSRxpq+mc0VbFuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0hHmqUe8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HKEDBxHU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 20:04:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741982641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ok+0rfm+ssL1wjIVnadysn8VVbhqswrm4zMu3MVvh4E=;
	b=0hHmqUe8J8P78blXHTA+ffsPlGEHG6Y3uuDXsDWvLw8LKDCJC028H3DSfdjQjCMp92Y3UM
	f9qNXpcFpI4+oZEMQFvUYRbZe8tKklbOhoQLprHcAR2fpGg7gY/wG2IO9Xtcry93DYitBC
	CBPMwIvyd5qfaSANkXNWbrh7+yrrBw4nUmI3PwOvaaS+ZpUjzewYARdFPMNIwhILO/OnBn
	CW//7DZS8Ff9qlNqCCTBfbhf//sGsIQnooEDo5+Q3W/raS1TbrMkbHqlNHg01z3/F1uh+P
	XkDshzw0pkT4T9Ae42SyBGc7Fn9e70gEg9F+DBlGqN3lClh8Zm7PxF1kbwuSuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741982641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ok+0rfm+ssL1wjIVnadysn8VVbhqswrm4zMu3MVvh4E=;
	b=HKEDBxHUIcz3CyYrwp9TlUFMVUF/VcLbCb40alXfV69oJoE11fQxDCzt9ofM2OX/UgLejK
	jkihhHQ14mXUMRCg==
From: "tip-bot2 for Tiezhu Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool/LoongArch: Add support for switch table
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250211115016.26913-5-yangtiezhu@loongson.cn>
References: <20250211115016.26913-5-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174198264105.14745.7450228861634080690.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     b95f852d3af21513e19a54c1e971c79f2911b54a
Gitweb:        https://git.kernel.org/tip/b95f852d3af21513e19a54c1e971c79f2911b54a
Author:        Tiezhu Yang <yangtiezhu@loongson.cn>
AuthorDate:    Tue, 11 Feb 2025 19:50:13 +08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 12 Mar 2025 15:43:38 -07:00

objtool/LoongArch: Add support for switch table

The objtool program need to analysis the control flow of each object file
generated by compiler toolchain, it needs to know all the locations that
a branch instruction may jump into, if a jump table is used, objtool has
to correlate the jump instruction with the table.

On x86 (which is the only port supported by objtool before LoongArch),
there is a relocation type on the jump instruction and directly points
to the table. But on LoongArch, the relocation is on another kind of
instruction prior to the jump instruction, and also with scheduling it
is not very easy to tell the offset of that instruction from the jump
instruction. Furthermore, because LoongArch has -fsection-anchors (often
enabled at -O1 or above) the relocation may actually points to a section
anchor instead of the table itself.

The good news is that after continuous analysis and discussion, at last
a GCC patch "LoongArch: Add support to annotate tablejump" and a Clang
patch "[LoongArch] Add options for annotate tablejump" have been merged
into the upstream mainline, the compiler changes make life much easier
for switch table support of objtool on LoongArch.

By now, there is an additional section ".discard.tablejump_annotate" to
store the jump info as pairs of addresses, each pair contains the address
of jump instruction and the address of jump table.

In order to find switch table, it is easy to parse the relocation section
".rela.discard.tablejump_annotate" to get table_sec and table_offset, the
rest process is somehow like x86.

Additionally, it needs to get each table size. When compiling on LoongArch,
there are unsorted table offsets of rodata if there exist many jump tables,
it will get the wrong table end and find the wrong table jump destination
instructions in add_jump_table().

Sort the rodata table offset by parsing ".rela.discard.tablejump_annotate"
and then get each table size of rodata corresponded with each table jump
instruction, it is used to check the table end and will break the process
when parsing ".rela.rodata" to avoid getting the wrong jump destination
instructions.

Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=0ee028f55640
Link: https://github.com/llvm/llvm-project/commit/4c2c17756739
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Link: https://lore.kernel.org/r/20250211115016.26913-5-yangtiezhu@loongson.cn
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/loongarch/special.c | 131 +++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/loongarch/special.c b/tools/objtool/arch/loongarch/special.c
index 87230ed..4fa6877 100644
--- a/tools/objtool/arch/loongarch/special.c
+++ b/tools/objtool/arch/loongarch/special.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
+#include <string.h>
 #include <objtool/special.h>
+#include <objtool/warn.h>
 
 bool arch_support_alt_relocation(struct special_alt *special_alt,
 				 struct instruction *insn,
@@ -8,9 +10,136 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 	return false;
 }
 
+struct table_info {
+	struct list_head jump_info;
+	unsigned long insn_offset;
+	unsigned long rodata_offset;
+};
+
+static void get_rodata_table_size_by_table_annotate(struct objtool_file *file,
+						    struct instruction *insn,
+						    unsigned long *table_size)
+{
+	struct section *rsec;
+	struct reloc *reloc;
+	struct list_head table_list;
+	struct table_info *orig_table;
+	struct table_info *next_table;
+	unsigned long tmp_insn_offset;
+	unsigned long tmp_rodata_offset;
+
+	rsec = find_section_by_name(file->elf, ".rela.discard.tablejump_annotate");
+	if (!rsec)
+		return;
+
+	INIT_LIST_HEAD(&table_list);
+
+	for_each_reloc(rsec, reloc) {
+		orig_table = malloc(sizeof(struct table_info));
+		if (!orig_table) {
+			WARN("malloc failed");
+			return;
+		}
+
+		orig_table->insn_offset = reloc->sym->offset + reloc_addend(reloc);
+		reloc++;
+		orig_table->rodata_offset = reloc->sym->offset + reloc_addend(reloc);
+
+		list_add_tail(&orig_table->jump_info, &table_list);
+
+		if (reloc_idx(reloc) + 1 == sec_num_entries(rsec))
+			break;
+	}
+
+	list_for_each_entry(orig_table, &table_list, jump_info) {
+		next_table = list_next_entry(orig_table, jump_info);
+		list_for_each_entry_from(next_table, &table_list, jump_info) {
+			if (next_table->rodata_offset < orig_table->rodata_offset) {
+				tmp_insn_offset = next_table->insn_offset;
+				tmp_rodata_offset = next_table->rodata_offset;
+				next_table->insn_offset = orig_table->insn_offset;
+				next_table->rodata_offset = orig_table->rodata_offset;
+				orig_table->insn_offset = tmp_insn_offset;
+				orig_table->rodata_offset = tmp_rodata_offset;
+			}
+		}
+	}
+
+	list_for_each_entry(orig_table, &table_list, jump_info) {
+		if (insn->offset == orig_table->insn_offset) {
+			next_table = list_next_entry(orig_table, jump_info);
+			if (&next_table->jump_info == &table_list) {
+				*table_size = 0;
+				return;
+			}
+
+			while (next_table->rodata_offset == orig_table->rodata_offset) {
+				next_table = list_next_entry(next_table, jump_info);
+				if (&next_table->jump_info == &table_list) {
+					*table_size = 0;
+					return;
+				}
+			}
+
+			*table_size = next_table->rodata_offset - orig_table->rodata_offset;
+		}
+	}
+}
+
+static struct reloc *find_reloc_by_table_annotate(struct objtool_file *file,
+						  struct instruction *insn,
+						  unsigned long *table_size)
+{
+	struct section *rsec;
+	struct reloc *reloc;
+	unsigned long offset;
+
+	rsec = find_section_by_name(file->elf, ".rela.discard.tablejump_annotate");
+	if (!rsec)
+		return NULL;
+
+	for_each_reloc(rsec, reloc) {
+		if (reloc->sym->sec->rodata)
+			continue;
+
+		if (strcmp(insn->sec->name, reloc->sym->sec->name))
+			continue;
+
+		offset = reloc->sym->offset + reloc_addend(reloc);
+		if (insn->offset == offset) {
+			get_rodata_table_size_by_table_annotate(file, insn, table_size);
+			reloc++;
+			return reloc;
+		}
+	}
+
+	return NULL;
+}
+
 struct reloc *arch_find_switch_table(struct objtool_file *file,
 				     struct instruction *insn,
 				     unsigned long *table_size)
 {
-	return NULL;
+	struct reloc *annotate_reloc;
+	struct reloc *rodata_reloc;
+	struct section *table_sec;
+	unsigned long table_offset;
+
+	annotate_reloc = find_reloc_by_table_annotate(file, insn, table_size);
+	if (!annotate_reloc)
+		return NULL;
+
+	table_sec = annotate_reloc->sym->sec;
+	table_offset = annotate_reloc->sym->offset + reloc_addend(annotate_reloc);
+
+	/*
+	 * Each table entry has a rela associated with it.  The rela
+	 * should reference text in the same function as the original
+	 * instruction.
+	 */
+	rodata_reloc = find_reloc_by_dest(file->elf, table_sec, table_offset);
+	if (!rodata_reloc)
+		return NULL;
+
+	return rodata_reloc;
 }

