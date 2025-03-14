Return-Path: <linux-tip-commits+bounces-4217-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 999EEA61C07
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 21:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68AE175F49
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 20:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4167E2063F9;
	Fri, 14 Mar 2025 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZOYiMIrI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w1H3V+qL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5242063C6;
	Fri, 14 Mar 2025 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982646; cv=none; b=hRTjrucNdS12E9PQ0J4zyyun5dCL7ymEOPeIWZ7+W9m6cDJkPLjcUkyNlzSqOmy8iCIst6MRvVqKS2GLoVT+aPP485kRq/gAIXPdnokGHct15UE0V++8gL4Zn+XpAph3NkZJ9P3RsQJ9gWq0tVEha8IshGuHkNNpIrn8MHbaoLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982646; c=relaxed/simple;
	bh=f93t0ylYFeqreUDog/uafU1v3H9n8Q3EOKqa5aTt7Bo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SslaG5HDM1qbhMJ2C2Hn67/CLXEyQ0I7pNO7qeFIuI44e/PeQj5KOyDdX2vq/EjvKqj4BKjKxSKZj7j5yGdhS90GhMYvhGYPc/KWydj1QaKBvpvbgfNHlscbAGd4jAWD4cgP0jcE/4F4BEQJjB9HHOHDqLB4JvevWZXZD7Z7DMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZOYiMIrI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w1H3V+qL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 20:04:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741982642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8zoXieHQ7WBGX+NBxUp+J8UShKHDAjzWpBLcbaUlp8=;
	b=ZOYiMIrIgNNsZrmS9KyEm6ol5blRdLB3ohUUkOUIt5HzVjKuwKo3CcD/8rEZ1/XN1bQCnS
	VPuZC9m/Fgo3IdjmyiyVJCOxvBuicgS3yvdAfZ4rpsrp6Uvl9wSeE9rnZ85jJhZnj9XWF+
	5sixLMchmdpvoOEYyX8hrg2fPdzz/tCcCqMJTKTSyZ4a1ckfIhbSSrHj3HnE8zaXtpT/gn
	LyVtoH58zuuj52JFYdshulkrzTVUix01BKPxFMC2XO0I94z6aMdZDJfO33h6aLcOXc8eBQ
	BXUIJMeAzw3Ec1uCaDAmvyGTG6HGeGiWqu48SGpCi9B8oOXdqNOYZJ02wGopHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741982642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8zoXieHQ7WBGX+NBxUp+J8UShKHDAjzWpBLcbaUlp8=;
	b=w1H3V+qL9K0g/byfQkW8102GXNqQaYYx1t3SNwMJArFmve3iMSkIL0wSEpc1BZchYC3y6r
	zdUYrH3LbKtzI6Dw==
From: "tip-bot2 for Tiezhu Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Handle PC relative relocation type
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250211115016.26913-4-yangtiezhu@loongson.cn>
References: <20250211115016.26913-4-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174198264190.14745.11242987232838483115.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     c4b93b06230ae49870187189d9f7342f6ad4f14e
Gitweb:        https://git.kernel.org/tip/c4b93b06230ae49870187189d9f7342f6ad4f14e
Author:        Tiezhu Yang <yangtiezhu@loongson.cn>
AuthorDate:    Tue, 11 Feb 2025 19:50:12 +08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 12 Mar 2025 15:43:38 -07:00

objtool: Handle PC relative relocation type

For the most part, an absolute relocation type is used for rodata.
In the case of STT_SECTION, reloc->sym->offset is always zero, for
the other symbol types, reloc_addend(reloc) is always zero, thus it
can use a simple statement "reloc->sym->offset + reloc_addend(reloc)"
to obtain the symbol offset for various symbol types.

When compiling on LoongArch, there exist PC relative relocation types
for rodata, it needs to calculate the symbol offset with "S + A - PC"
according to the spec of "ELF for the LoongArch Architecture".

If there is only one jump table in the rodata, the "PC" is the entry
address which is equal with the value of reloc_offset(reloc), at this
time, reloc_offset(table) is 0.

If there are many jump tables in the rodata, the "PC" is the offset
of the jump table's base address which is equal with the value of
reloc_offset(reloc) - reloc_offset(table).

So for LoongArch, if the relocation type is PC relative, it can use a
statement "reloc_offset(reloc) - reloc_offset(table)" to get the "PC"
value when calculating the symbol offset with "S + A - PC" for one or
many jump tables in the rodata.

Add an arch-specific function arch_jump_table_sym_offset() to assign
the symbol offset, for the most part that is an absolute relocation,
the default value is "reloc->sym->offset + reloc_addend(reloc)" in
the weak definition, it can be overridden by each architecture that
has different requirements.

Link: https://github.com/loongson/la-abi-specs/blob/release/laelf.adoc
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Link: https://lore.kernel.org/r/20250211115016.26913-4-yangtiezhu@loongson.cn
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/loongarch/decode.c           | 17 ++++++++++++----
 tools/objtool/arch/loongarch/include/arch/elf.h |  7 +++++++-
 tools/objtool/check.c                           |  7 ++++++-
 tools/objtool/include/objtool/arch.h            |  1 +-
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index b64205b..02e4905 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -5,10 +5,7 @@
 #include <asm/inst.h>
 #include <asm/orc_types.h>
 #include <linux/objtool_types.h>
-
-#ifndef EM_LOONGARCH
-#define EM_LOONGARCH	258
-#endif
+#include <arch/elf.h>
 
 int arch_ftrace_match(char *name)
 {
@@ -374,3 +371,15 @@ unsigned int arch_reloc_size(struct reloc *reloc)
 		return 8;
 	}
 }
+
+unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *table)
+{
+	switch (reloc_type(reloc)) {
+	case R_LARCH_32_PCREL:
+	case R_LARCH_64_PCREL:
+		return reloc->sym->offset + reloc_addend(reloc) -
+		       (reloc_offset(reloc) - reloc_offset(table));
+	default:
+		return reloc->sym->offset + reloc_addend(reloc);
+	}
+}
diff --git a/tools/objtool/arch/loongarch/include/arch/elf.h b/tools/objtool/arch/loongarch/include/arch/elf.h
index 9623d66..ec79062 100644
--- a/tools/objtool/arch/loongarch/include/arch/elf.h
+++ b/tools/objtool/arch/loongarch/include/arch/elf.h
@@ -18,6 +18,13 @@
 #ifndef R_LARCH_32_PCREL
 #define R_LARCH_32_PCREL	99
 #endif
+#ifndef R_LARCH_64_PCREL
+#define R_LARCH_64_PCREL	109
+#endif
+
+#ifndef EM_LOONGARCH
+#define EM_LOONGARCH		258
+#endif
 
 #define R_NONE			R_LARCH_NONE
 #define R_ABS32			R_LARCH_32
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f762d23..7dbf22c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1944,6 +1944,11 @@ out:
 	return ret;
 }
 
+__weak unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *table)
+{
+	return reloc->sym->offset + reloc_addend(reloc);
+}
+
 static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 			  struct reloc *next_table)
 {
@@ -1972,7 +1977,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		if (prev_offset && reloc_offset(reloc) != prev_offset + arch_reloc_size(reloc))
 			break;
 
-		sym_offset = reloc->sym->offset + reloc_addend(reloc);
+		sym_offset = arch_jump_table_sym_offset(reloc, table);
 
 		/* Detect function pointers from contiguous objects: */
 		if (reloc->sym->sec == pfunc->sec && sym_offset == pfunc->offset)
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 396f7c6..089a1ac 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -98,5 +98,6 @@ int arch_rewrite_retpolines(struct objtool_file *file);
 bool arch_pc_relative_reloc(struct reloc *reloc);
 
 unsigned int arch_reloc_size(struct reloc *reloc);
+unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *table);
 
 #endif /* _ARCH_H */

