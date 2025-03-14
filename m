Return-Path: <linux-tip-commits+bounces-4218-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A49BA61C0D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 21:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753093AD1C7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 20:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF362066F7;
	Fri, 14 Mar 2025 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iXVMRuEd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lq6u3hV/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BEC1DFDAE;
	Fri, 14 Mar 2025 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982648; cv=none; b=AJNA/ngh4tZu4Winpl/lNjptesW81wIsOXCg9HmYqOSiBt23wib91QhPtkyfjYZiyJ0JR1IHAdXuTafM9nyZ4RXN7elEUfV6bKZjUtT6/tt8uXXipjRfOPiYnkXdAlhhr1D00dv7wSAqRdbAJainFfuNwXAUeHdQAE/3smMOfmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982648; c=relaxed/simple;
	bh=VVToo5BIXaNb0MvHxyi/vyaTFTx9Z5kX+kzQfcP76Jg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RtPf3ShTkEV02pQBMoPPYub0xyJ1fGaMX6aG9VDsZhGA6r7K8rlSHkVvA1P07XwOb/DGydR5mHb9J2pDvrll64JeZqmExGu8jAjb+s5csyWmlFkswNyo44NefYfZdjVZ4Osg3AQz9qP6VBJ0wWUygrs+Vg5ExKu9Kw2ckovU1LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iXVMRuEd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lq6u3hV/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 20:04:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741982643;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dMxFRtI9juBn5viXgWXAj3JBeqz+YUjb7EbY8lNFWw4=;
	b=iXVMRuEd5hpYcDf396mE/kIDtq+Q2WfZ4MQ1B1VB+7iISN+0L537xFs81l7W3uPVzSgyrb
	o8vWxA3dxPO1R8kIBm3BUYoDkkbj+qjiRBFyw6gM11gvGi9/zIaZ7Dml8gHCC1ow+dBdno
	1B9oqJcOm2oz0kuMqctojcjarJgBmD6WkVzM8NzurEBB6QWECKXYSb2V43RVjYUj8phLRV
	y4zBBSOSFr603chHI11uTXHsgaeVodXpe83Bm+iI9T3PbvQinZnMGq9A531wK/yTbs/tCJ
	QsmiTxx84TAZLAwU/djwY2H+9FDFeOim9xQNfguandNkKWfKnH2JQKEv/LIBLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741982643;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dMxFRtI9juBn5viXgWXAj3JBeqz+YUjb7EbY8lNFWw4=;
	b=lq6u3hV/Cx8yXdnz2I6CNB7/P961G/iUo/drSKr28sDqO4Kzj4dWkDoyq+s/4q+5ErlUSW
	SsQ7QhsmpFP/G3CA==
From: "tip-bot2 for Tiezhu Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Handle different entry size of rodata
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250211115016.26913-3-yangtiezhu@loongson.cn>
References: <20250211115016.26913-3-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174198264291.14745.11158899791248573322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     091bf313f8a852a7f30c3a8dcef569edfd06f5dc
Gitweb:        https://git.kernel.org/tip/091bf313f8a852a7f30c3a8dcef569edfd06f5dc
Author:        Tiezhu Yang <yangtiezhu@loongson.cn>
AuthorDate:    Tue, 11 Feb 2025 19:50:11 +08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 12 Mar 2025 15:43:38 -07:00

objtool: Handle different entry size of rodata

In the most cases, the entry size of rodata is 8 bytes because the
relocation type is 64 bit. There are also 32 bit relocation types,
the entry size of rodata should be 4 bytes in this case.

Add an arch-specific function arch_reloc_size() to assign the entry
size of rodata for x86, powerpc and LoongArch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Link: https://lore.kernel.org/r/20250211115016.26913-3-yangtiezhu@loongson.cn
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/loongarch/decode.c | 11 +++++++++++
 tools/objtool/arch/powerpc/decode.c   | 14 ++++++++++++++
 tools/objtool/arch/x86/decode.c       | 13 +++++++++++++
 tools/objtool/check.c                 |  2 +-
 tools/objtool/include/objtool/arch.h  |  2 ++
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index 69b6699..b64205b 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -363,3 +363,14 @@ void arch_initial_func_cfi_state(struct cfi_init_state *state)
 	state->cfa.base = CFI_SP;
 	state->cfa.offset = 0;
 }
+
+unsigned int arch_reloc_size(struct reloc *reloc)
+{
+	switch (reloc_type(reloc)) {
+	case R_LARCH_32:
+	case R_LARCH_32_PCREL:
+		return 4;
+	default:
+		return 8;
+	}
+}
diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc/decode.c
index 53b5569..7c0bf24 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -106,3 +106,17 @@ void arch_initial_func_cfi_state(struct cfi_init_state *state)
 	state->regs[CFI_RA].base = CFI_CFA;
 	state->regs[CFI_RA].offset = 0;
 }
+
+unsigned int arch_reloc_size(struct reloc *reloc)
+{
+	switch (reloc_type(reloc)) {
+	case R_PPC_REL32:
+	case R_PPC_ADDR32:
+	case R_PPC_UADDR32:
+	case R_PPC_PLT32:
+	case R_PPC_PLTREL32:
+		return 4;
+	default:
+		return 8;
+	}
+}
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index fe1362c..fb9691a 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -852,3 +852,16 @@ bool arch_is_embedded_insn(struct symbol *sym)
 	return !strcmp(sym->name, "retbleed_return_thunk") ||
 	       !strcmp(sym->name, "srso_safe_ret");
 }
+
+unsigned int arch_reloc_size(struct reloc *reloc)
+{
+	switch (reloc_type(reloc)) {
+	case R_X86_64_32:
+	case R_X86_64_32S:
+	case R_X86_64_PC32:
+	case R_X86_64_PLT32:
+		return 4;
+	default:
+		return 8;
+	}
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index cfab4a1..f762d23 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1969,7 +1969,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 			break;
 
 		/* Make sure the table entries are consecutive: */
-		if (prev_offset && reloc_offset(reloc) != prev_offset + 8)
+		if (prev_offset && reloc_offset(reloc) != prev_offset + arch_reloc_size(reloc))
 			break;
 
 		sym_offset = reloc->sym->offset + reloc_addend(reloc);
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index d63b46a..396f7c6 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -97,4 +97,6 @@ int arch_rewrite_retpolines(struct objtool_file *file);
 
 bool arch_pc_relative_reloc(struct reloc *reloc);
 
+unsigned int arch_reloc_size(struct reloc *reloc);
+
 #endif /* _ARCH_H */

