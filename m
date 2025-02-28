Return-Path: <linux-tip-commits+bounces-3735-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA8DA497B5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 11:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895F61894CAD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 10:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C2B26037B;
	Fri, 28 Feb 2025 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pbbyCmK6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Ppc9LE1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FC9260367;
	Fri, 28 Feb 2025 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739654; cv=none; b=kfZUwzSeAK5Q4UdUwJJOsiikvYg7ndr30a5Rgsp5yNxNOhOt1FT5ec2vY8J0RkOY/wXDzxedsQ8sbVgqyOTUHmXimT7gqXj0a1RfqIDs1m+x3fSBx7qoG1BGkp2bPfLU4mx10as2NPurrTtdka/aG9HCNJIQCO2+iNPaz2ThVJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739654; c=relaxed/simple;
	bh=L68s6VwS54ddihqbAee1YcryRUuoHMpen2El/jr8MM8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Hvbz8JaPUvKgPCkDa/wlsJSeEFVf7WiyTgDMb03vL7gRyqjie9gU2OT/9/ytlbfCqWNRfpsFimBwTuFZQmPhk4L+TFGS8yLJshDqUBVvs95zjNOB/0PvwD7mgzCxJK7I5SJmQHJDVAMyfJ0NcRxuPikTA6VOPj9qToo89ZqjBjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pbbyCmK6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/Ppc9LE1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Feb 2025 10:47:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740739650;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PdcCEaxdspq2IpsD6PF5Mz6/40hsfx0ji8945Y8s7FM=;
	b=pbbyCmK65BTsPKJdVcncvJWK6ZWQiM6CUyN68jXh78tfHfK3VkM8YEuStflfq86wdY8kt+
	qxTtFeGKgJrbepemDvfLfbnr9v3KFAcTA3CbHXR3Bic/kVnR5rMDwOgETwZZP+CRpY8icm
	MGmuGdw3oXEDB6WGb6Q2eKAmyAmYjTKdSWcEbx5DsYxrbbi9OsbwOiAafixz+c9YHi0b9f
	8L/tccTsEqQz4gsThu06ggtjPGIAxprRn3Wmk+x79lwipsY+fgiWve7WbPFf0nOn4si7R+
	Maroe8eY4+XM1QCv3YHjf5N68NZ8b0/5SHceMoCZnwjBpw9+dc/GhtNzQOzPmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740739650;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PdcCEaxdspq2IpsD6PF5Mz6/40hsfx0ji8945Y8s7FM=;
	b=/Ppc9LE1R4IycA4Zl0FK8uPNoHdFbInjV8uiBi3wqfSnYJBMzq7n0e9m1pbQo7zani3YXA
	N2FQzT2kijLRVrAw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix C jump table annotations for Clang
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Ard Biesheuvel <ardb@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250221135704.431269-6-ardb+git@google.com>
References: <20250221135704.431269-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174073964983.10177.9041277746788147688.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     73cfc53cc3b6380eccf013049574485f64cb83ca
Gitweb:        https://git.kernel.org/tip/73cfc53cc3b6380eccf013049574485f64cb83ca
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Fri, 21 Feb 2025 14:57:07 +01:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 25 Feb 2025 09:46:16 -08:00

objtool: Fix C jump table annotations for Clang

A C jump table (such as the one used by the BPF interpreter) is a const
global array of absolute code addresses, and this means that the actual
values in the table may not be known until the kernel is booted (e.g.,
when using KASLR or when the kernel VA space is sized dynamically).

When using PIE codegen, the compiler will default to placing such const
global objects in .data.rel.ro (which is annotated as writable), rather
than .rodata (which is annotated as read-only). As C jump tables are
explicitly emitted into .rodata, this used to result in warnings for
LoongArch builds (which uses PIE codegen for the entire kernel) like

  Warning: setting incorrect section attributes for .rodata..c_jump_table

due to the fact that the explicitly specified .rodata section inherited
the read-write annotation that the compiler uses for such objects when
using PIE codegen.

This warning was suppressed by explicitly adding the read-only
annotation to the __attribute__((section(""))) string, by commit

  c5b1184decc8 ("compiler.h: specify correct attribute for .rodata..c_jump_table")

Unfortunately, this hack does not work on Clang's integrated assembler,
which happily interprets the appended section type and permission
specifiers as part of the section name, which therefore no longer
matches the hard-coded pattern '.rodata..c_jump_table' that objtool
expects, causing it to emit a warning

  kernel/bpf/core.o: warning: objtool: ___bpf_prog_run+0x20: sibling call from callable instruction with modified stack frame

Work around this, by emitting C jump tables into .data.rel.ro instead,
which is treated as .rodata by the linker script for all builds, not
just PIE based ones.

Fixes: c5b1184decc8 ("compiler.h: specify correct attribute for .rodata..c_jump_table")
Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn> # on LoongArch
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20250221135704.431269-6-ardb+git@google.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/compiler.h                | 2 +-
 tools/objtool/check.c                   | 7 ++++---
 tools/objtool/include/objtool/special.h | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index b087de2..0c25f3e 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -110,7 +110,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 /* Unreachable code */
 #ifdef CONFIG_OBJTOOL
 /* Annotate a C jump table to allow objtool to follow the code flow */
-#define __annotate_jump_table __section(".rodata..c_jump_table,\"a\",@progbits #")
+#define __annotate_jump_table __section(".data.rel.ro.c_jump_table")
 #else /* !CONFIG_OBJTOOL */
 #define __annotate_jump_table
 #endif /* CONFIG_OBJTOOL */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 497cb8d..1b5a1b3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2471,13 +2471,14 @@ static void mark_rodata(struct objtool_file *file)
 	 *
 	 * - .rodata: can contain GCC switch tables
 	 * - .rodata.<func>: same, if -fdata-sections is being used
-	 * - .rodata..c_jump_table: contains C annotated jump tables
+	 * - .data.rel.ro.c_jump_table: contains C annotated jump tables
 	 *
 	 * .rodata.str1.* sections are ignored; they don't contain jump tables.
 	 */
 	for_each_sec(file, sec) {
-		if (!strncmp(sec->name, ".rodata", 7) &&
-		    !strstr(sec->name, ".str1.")) {
+		if ((!strncmp(sec->name, ".rodata", 7) &&
+		     !strstr(sec->name, ".str1.")) ||
+		    !strncmp(sec->name, ".data.rel.ro", 12)) {
 			sec->rodata = true;
 			found = true;
 		}
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index e7ee7ff..e049679 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -10,7 +10,7 @@
 #include <objtool/check.h>
 #include <objtool/elf.h>
 
-#define C_JUMP_TABLE_SECTION ".rodata..c_jump_table"
+#define C_JUMP_TABLE_SECTION ".data.rel.ro.c_jump_table"
 
 struct special_alt {
 	struct list_head list;

