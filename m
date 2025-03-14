Return-Path: <linux-tip-commits+bounces-4215-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA03A61C05
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 21:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2361C7AFAD0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 20:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65242063D1;
	Fri, 14 Mar 2025 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="03UJSN3t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AljCFgP+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBECD530;
	Fri, 14 Mar 2025 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982644; cv=none; b=LXKp2EyHJtiZPJ3RqBDUbz/462wXLKWw64Gopo/uborIjwHAbuqyiGP4LcOscGeX4JgGg4W8vw/DQHuyYlxWNcPgL+nk5nd1zz4fq5p5hvtQoBVW4tnJzTtEdcjzEUQNBer/WBunvm5zMki/mLTo3iIL/vk/hxid8oFWsZYU+dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982644; c=relaxed/simple;
	bh=M1KfpW+r2Gg6BsJXBKm1oUP3jUcDa8yNDJiNm0+jyug=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dZEXcNhzf+rXV+IEhlFPo2kitqBm28OS+Di/fWix2SEGM/rR/UO8MRuRnKPpLOqBKs8hxHtMTpaH1HG38TAmYJEvhlymcHHi/T9zhTdXOE/nrmKlcaD3edwqqEv3k0OeANtWJrOfVOyeiplioS0wIQkev2ySCmy5ymvvlc/cAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=03UJSN3t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AljCFgP+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 20:04:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741982640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDZemfn0Tzwmt8S6J0TBvq6Eu73mEDZBCPgMPeCmcjE=;
	b=03UJSN3t2OrEzR/GPcHyRx+BZB736BkUczmTyh1AGezr8vfQ+hoBJs4GDhMDDMGS8BAcSF
	10QOdaSHdE2ZJhnINC7SIIc+1nzltfENdVQr3X3xLxFRq+76O3egq0QdCpAd2Dxi/NKeP7
	jaLbM1/cm6RBsi/F2/aCk4EsxaLw2x0SbV5K2S4xZYj8zBEbNcThlIZ48wu6mqfcYWxWvg
	91RKlEq0DAEpRg3S3nuCYCMF9mSMn9io8NbEcWIkzMk1dex1Cl/NRZoWeVQYESFDJR7F3O
	BXzJzXGpV4U9HJMoh9TFWHiyu52v8EdgIe5GrGneaG9iw+7IEDRAEdOj79xhKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741982640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDZemfn0Tzwmt8S6J0TBvq6Eu73mEDZBCPgMPeCmcjE=;
	b=AljCFgP+AyM8P42CA0FK+5P+9X390SO0jCKLGe8F/sNX4t5iCtpOhY1ScyOoH34wX9s063
	XM6Uz5Y7wECyh2Ag==
From: "tip-bot2 for Tiezhu Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool/LoongArch: Add support for goto table
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250211115016.26913-6-yangtiezhu@loongson.cn>
References: <20250211115016.26913-6-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174198264000.14745.17559738726347127621.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     88cbb468d4545526a33126f8a41352cac6dd0f3c
Gitweb:        https://git.kernel.org/tip/88cbb468d4545526a33126f8a41352cac6dd0f3c
Author:        Tiezhu Yang <yangtiezhu@loongson.cn>
AuthorDate:    Tue, 11 Feb 2025 19:50:14 +08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 12 Mar 2025 15:43:39 -07:00

objtool/LoongArch: Add support for goto table

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

For the jump table of switch cases, a GCC patch "LoongArch: Add support
to annotate tablejump" and a Clang patch "[LoongArch] Add options for
annotate tablejump" have been merged into the upstream mainline, it can
parse the additional section ".discard.tablejump_annotate" which stores
the jump info as pairs of addresses, each pair contains the address of
jump instruction and the address of jump table.

For the jump table of computed gotos, it is indeed not easy to implement
in the compiler, especially if there is more than one computed goto in a
function such as ___bpf_prog_run(). objdump kernel/bpf/core.o shows that
there are many table jump instructions in ___bpf_prog_run(), but there are
no relocations on the table jump instructions and to the table directly on
LoongArch.

Without the help of compiler, in order to figure out the address of goto
table for the special case of ___bpf_prog_run(), since the instruction
sequence is relatively single and stable, it makes sense to add a helper
find_reloc_of_rodata_c_jump_table() to find the relocation which points
to the section ".rodata..c_jump_table".

If find_reloc_by_table_annotate() failed, it means there is no relocation
info of switch table address in ".rela.discard.tablejump_annotate", then
objtool may find the relocation info of goto table ".rodata..c_jump_table"
with find_reloc_of_rodata_c_jump_table().

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Link: https://lore.kernel.org/r/20250211115016.26913-6-yangtiezhu@loongson.cn
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/loongarch/special.c | 32 +++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/arch/loongarch/special.c b/tools/objtool/arch/loongarch/special.c
index 4fa6877..e39f86d 100644
--- a/tools/objtool/arch/loongarch/special.c
+++ b/tools/objtool/arch/loongarch/special.c
@@ -116,6 +116,30 @@ static struct reloc *find_reloc_by_table_annotate(struct objtool_file *file,
 	return NULL;
 }
 
+static struct reloc *find_reloc_of_rodata_c_jump_table(struct section *sec,
+						       unsigned long offset,
+						       unsigned long *table_size)
+{
+	struct section *rsec;
+	struct reloc *reloc;
+
+	rsec = sec->rsec;
+	if (!rsec)
+		return NULL;
+
+	for_each_reloc(rsec, reloc) {
+		if (reloc_offset(reloc) > offset)
+			break;
+
+		if (!strcmp(reloc->sym->sec->name, C_JUMP_TABLE_SECTION)) {
+			*table_size = 0;
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
@@ -126,8 +150,12 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	unsigned long table_offset;
 
 	annotate_reloc = find_reloc_by_table_annotate(file, insn, table_size);
-	if (!annotate_reloc)
-		return NULL;
+	if (!annotate_reloc) {
+		annotate_reloc = find_reloc_of_rodata_c_jump_table(
+				 insn->sec, insn->offset, table_size);
+		if (!annotate_reloc)
+			return NULL;
+	}
 
 	table_sec = annotate_reloc->sym->sec;
 	table_offset = annotate_reloc->sym->offset + reloc_addend(annotate_reloc);

