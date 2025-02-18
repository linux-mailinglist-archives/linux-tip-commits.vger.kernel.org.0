Return-Path: <linux-tip-commits+bounces-3385-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D762A393D4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 08:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148DC1667DD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 07:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBCB749C;
	Tue, 18 Feb 2025 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b8oKJE+D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9UHhLyGe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43E97482;
	Tue, 18 Feb 2025 07:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864199; cv=none; b=LAo3r6rw9hTyV+qpXJ16OjmPEwQuOW1nyhbWASBtGcbLenWr3xp3oyAinWnP/82kPwEViy5apgCoihIPyqVL9bTrXHQO80MmM9nljErVkxiR/SGp8G+hUOD7fRDou/ltDxS5Hie7Y8ft6RJZKbY+FDS0LcMZfdo660wfu6os9TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864199; c=relaxed/simple;
	bh=pbSm1GwLHL8SueRMJzyGaAVGK2+er6Zf644RmNBRhNM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BI6j+wAV3wq+E2M8VfBanVVtOy4wZddbC1THer2a9rEA50TGOHF/E3EPrsx68xnatdJP0W/OqiW5v8VT7IcrRbi3o7b10hdmKUDahY0E+iJ6dn/zcH85ddGfS3Lb+ksa1ROYAQgyB2UHgUvrq1pdcg3JxqprrzlBDGZzG3AIaFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b8oKJE+D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9UHhLyGe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 07:36:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739864195;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xFJ6I6XiW/MbkNTaUToRJu702t1b+avW4iZysKkwsYE=;
	b=b8oKJE+DItRdHiM8oFK8dW7V6dQp8GvIL2bSNGQJ6tmubAjm+z0j6Wk6dSicmf6dy7YPDh
	PxV7tyFpsn+QLdJc82/uWqyn6c1XsKFQ6Rf5WGjcAwMsx8GwnAT6Hm+UWuwIN8KlLu/8NT
	MS5y3AvOeFL4rJaDwC/uVbD9dJlZpdH5Lc/4jm9/cqN7N2SECQO6rjq8gu6GCnN5VaMR5C
	1cMnyx6329QkQGENXHxV2bKAZdvup+q7dv9+u+0VDFhDARnKywLOIayBbolWLOBLdFA5rX
	oYKyMBpuhoJR4crfkoeVQoyXekVidMPdsD12D/GIkYWf3f04jhzvHGhQJWRz/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739864195;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xFJ6I6XiW/MbkNTaUToRJu702t1b+avW4iZysKkwsYE=;
	b=9UHhLyGeA8+X8ZFG+XgbnuLgvfcKLFId2/E3qlfQoJq9/zERuCq0URrVrIvRDDryh0t+cx
	R43kHSM0NU3iTyBw==
From: "tip-bot2 for Tiezhu Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Rename ".rodata..c_jump_table" to
 "..rodata.c_jump_table"
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250214125135.2172-1-yangtiezhu@loongson.cn>
References: <20250214125135.2172-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173986419190.10177.8150784597022966817.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     b8bd16a0ae060862ff6215b27ab626dd7ff12484
Gitweb:        https://git.kernel.org/tip/b8bd16a0ae060862ff6215b27ab626dd7ff12484
Author:        Tiezhu Yang <yangtiezhu@loongson.cn>
AuthorDate:    Fri, 14 Feb 2025 20:51:35 +08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Sun, 16 Feb 2025 18:57:47 -08:00

objtool: Rename ".rodata..c_jump_table" to "..rodata.c_jump_table"

Specify the attribute like ".rodata..c_jump_table,\"a\",@progbits #"
explicitly works for GCC, but this hack apparently doesn't work with
Clang, the generated section name is wrong, resulting in a warning
and missing ORC for x86. This is because there is only one arg for
section name in LLVM, even if the so called attribute is specified,
it will be recognized as a whole for section name, so it is not a
good way to specify the attribute for this section.

In the top Makefile, there is "-fno-PIE" build flag. For x86, there
is no "-fPIE" build flag in arch/x86/Makefile for 64 bit kernel. But
for LoongArch, there is "-fPIE" build flag in arch/loongarch/Makefile
to override "-fno-PIE" in top Makefile. After some test with GCC and
Clang on x86 and LoongArch, it shows that the generated "W" (writable)
attribute of the section ".rodata..c_jump_table" is related with the
compiler option "-fPIE", and then lead to the GNU assembler warning:
"setting incorrect section attributes for .rodata..c_jump_table".

Based on the above analysis, in order to avoid changing the behavior
of GNU assembler and silence the GNU assembler warning, it is better
to rename ".rodata..c_jump_table" to "..rodata.c_jump_table" without
section attribute, it works well with GCC and Clang, no GNU assembler
warning for GCC and the section name is normal for Clang.

Fixes: c5b1184decc8 ("compiler.h: specify correct attribute for .rodata..c_jump_table")
Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Link: https://lore.kernel.org/r/20250214125135.2172-1-yangtiezhu@loongson.cn
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/asm-generic/vmlinux.lds.h       | 2 +-
 include/linux/compiler.h                | 2 +-
 tools/objtool/check.c                   | 5 +++--
 tools/objtool/include/objtool/special.h | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5450401..91a7e82 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -457,7 +457,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	. = ALIGN((align));						\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
-		*(.rodata) *(.rodata.*)					\
+		*(.rodata) *(.rodata.*) *(..rodata.*)			\
 		SCHED_DATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index b087de2..3d013f1 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -110,7 +110,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 /* Unreachable code */
 #ifdef CONFIG_OBJTOOL
 /* Annotate a C jump table to allow objtool to follow the code flow */
-#define __annotate_jump_table __section(".rodata..c_jump_table,\"a\",@progbits #")
+#define __annotate_jump_table __section("..rodata.c_jump_table")
 #else /* !CONFIG_OBJTOOL */
 #define __annotate_jump_table
 #endif /* CONFIG_OBJTOOL */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 497cb8d..1398ffc 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2471,12 +2471,13 @@ static void mark_rodata(struct objtool_file *file)
 	 *
 	 * - .rodata: can contain GCC switch tables
 	 * - .rodata.<func>: same, if -fdata-sections is being used
-	 * - .rodata..c_jump_table: contains C annotated jump tables
+	 * - ..rodata.c_jump_table: contains C annotated jump tables
 	 *
 	 * .rodata.str1.* sections are ignored; they don't contain jump tables.
 	 */
 	for_each_sec(file, sec) {
-		if (!strncmp(sec->name, ".rodata", 7) &&
+		if ((!strncmp(sec->name, ".rodata", 7) ||
+		    !strncmp(sec->name, "..rodata", 8)) &&
 		    !strstr(sec->name, ".str1.")) {
 			sec->rodata = true;
 			found = true;
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index e7ee7ff..34acf4a 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -10,7 +10,7 @@
 #include <objtool/check.h>
 #include <objtool/elf.h>
 
-#define C_JUMP_TABLE_SECTION ".rodata..c_jump_table"
+#define C_JUMP_TABLE_SECTION "..rodata.c_jump_table"
 
 struct special_alt {
 	struct list_head list;

