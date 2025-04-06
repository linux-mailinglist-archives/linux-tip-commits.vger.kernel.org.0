Return-Path: <linux-tip-commits+bounces-4711-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14683A7CFA5
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Apr 2025 20:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 063643AFA48
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Apr 2025 18:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B94B1ADC7B;
	Sun,  6 Apr 2025 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yt6tWteM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vLTGHTly"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9A317A2F2;
	Sun,  6 Apr 2025 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743964391; cv=none; b=jRsOFwK9oju12/l0IxurZXqDqurtd8fsyJ4YiUNUDisPNA1V0lMyJ1JrQsxM/TT7GCcLdHYdM/7Ljvtb95T24rrIwRNolgxh9uhOrMkFSxWjfPgt1XqY4De29eGTPMkBgKW7sCXd1Bs3phoVrLAxw1XMPkFoO9b+x5AfJ4/ZfJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743964391; c=relaxed/simple;
	bh=oTo66czhSp3iirv1nQLwdoX6IY0ctCk0jgIzJpokRmA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i2Eq3gMWxpeLFagcIkL6YI9+D+B8WdlaOtJPJxu9JHq6hNaDg9ivKyL3NyZPaVnfLAiRgPT2JPqYBIsBMx38Ft6Rdk00IedMfwF4aGGicUW3mEPxfgxHnwCchCTJysxiBCnK50cbG7Vyw9Qm/iYSajs3aSNrpqWZsMapADS46O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yt6tWteM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vLTGHTly; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 06 Apr 2025 18:33:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743964387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBCIfQWnwJ6sOS0OIFIlgTdwIJXYipUrEb7a9Bv/+dk=;
	b=yt6tWteMIOs3p3Endp9IMgBfzir/exl+eSXSxDlJiNvxTT3uikI9BcigotAKx6QazG/oth
	YFH+LcOuVIlVbl/eJB8jAXMiahtEFZXQjXB/HuaIl6DlwkxJ/qH+8t/Snaxsogw6tKFD6m
	APbCh5DqzDj9/LbXx111Q340FBafGiqEdKHbq9QQKfp0lbpK3EyV01dmhKUonjR1nadv3X
	H2+DDf+XTtrWqWxBq6Yh5qlWXTtwAFBlopMD7PxghC6EEHvx/AGrp7HMPOodAVQLhkpXDp
	fqUlDSYAF7jMINwJ/4X3mA7lYsW7M2s764pDNXeUW3VRCbJVWcmGS34FTV7EoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743964387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBCIfQWnwJ6sOS0OIFIlgTdwIJXYipUrEb7a9Bv/+dk=;
	b=vLTGHTlyPbXETYeqKxdFtEqqOzD8nMzFN94L0XW459uZnDRAER6QZ9xow6EB+EfXvs1aIt
	nNev/qxgDqZGoOBg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Merge the local pgtable.h
 include into <asm/boot.h>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, "H. Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250401133416.1436741-9-ardb+git@google.com>
References: <20250401133416.1436741-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174396438722.31282.12844630124271910397.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     5d4456fc88f7aa9bd139b7c5bd4f1c03f552b973
Gitweb:        https://git.kernel.org/tip/5d4456fc88f7aa9bd139b7c5bd4f1c03f552b973
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 01 Apr 2025 15:34:18 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 06 Apr 2025 20:15:14 +02:00

x86/boot/compressed: Merge the local pgtable.h include into <asm/boot.h>

Merge the local include "pgtable.h" -which declares the API of the
5-level paging trampoline- into <asm/boot.h> so that its implementation
in la57toggle.S as well as the calling code can be decoupled from the
traditional decompressor.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250401133416.1436741-9-ardb+git@google.com
---
 arch/x86/boot/compressed/head_64.S    |  1 -
 arch/x86/boot/compressed/la57toggle.S |  1 -
 arch/x86/boot/compressed/misc.c       |  1 -
 arch/x86/boot/compressed/pgtable.h    | 18 ------------------
 arch/x86/boot/compressed/pgtable_64.c |  1 -
 arch/x86/include/asm/boot.h           | 10 ++++++++++
 6 files changed, 10 insertions(+), 22 deletions(-)
 delete mode 100644 arch/x86/boot/compressed/pgtable.h

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index eafd4f1..d9dab94 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -35,7 +35,6 @@
 #include <asm/bootparam.h>
 #include <asm/desc_defs.h>
 #include <asm/trapnr.h>
-#include "pgtable.h"
 
 /*
  * Fix alignment at 16 bytes. Following CONFIG_FUNCTION_ALIGNMENT will result
diff --git a/arch/x86/boot/compressed/la57toggle.S b/arch/x86/boot/compressed/la57toggle.S
index 9ee0023..370075b 100644
--- a/arch/x86/boot/compressed/la57toggle.S
+++ b/arch/x86/boot/compressed/la57toggle.S
@@ -5,7 +5,6 @@
 #include <asm/boot.h>
 #include <asm/msr.h>
 #include <asm/processor-flags.h>
-#include "pgtable.h"
 
 /*
  * This is the 32-bit trampoline that will be copied over to low memory. It
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 1cdcd4a..94b5991 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -14,7 +14,6 @@
 
 #include "misc.h"
 #include "error.h"
-#include "pgtable.h"
 #include "../string.h"
 #include "../voffset.h"
 #include <asm/bootparam_utils.h>
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
deleted file mode 100644
index 6d595ab..0000000
--- a/arch/x86/boot/compressed/pgtable.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef BOOT_COMPRESSED_PAGETABLE_H
-#define BOOT_COMPRESSED_PAGETABLE_H
-
-#define TRAMPOLINE_32BIT_SIZE		(2 * PAGE_SIZE)
-
-#define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
-#define TRAMPOLINE_32BIT_CODE_SIZE	0xA0
-
-#ifndef __ASSEMBLER__
-
-extern unsigned long *trampoline_32bit;
-
-extern void trampoline_32bit_src(void *trampoline, bool enable_5lvl);
-
-extern const u16 trampoline_ljmp_imm_offset;
-
-#endif /* __ASSEMBLER__ */
-#endif /* BOOT_COMPRESSED_PAGETABLE_H */
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index d8c5de4..5a6c7a1 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -4,7 +4,6 @@
 #include <asm/bootparam_utils.h>
 #include <asm/e820/types.h>
 #include <asm/processor.h>
-#include "pgtable.h"
 #include "../string.h"
 #include "efi.h"
 
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 3f02ff6..02b23aa 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -74,6 +74,11 @@
 # define BOOT_STACK_SIZE	0x1000
 #endif
 
+#define TRAMPOLINE_32BIT_SIZE		(2 * PAGE_SIZE)
+
+#define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
+#define TRAMPOLINE_32BIT_CODE_SIZE	0xA0
+
 #ifndef __ASSEMBLER__
 extern unsigned int output_len;
 extern const unsigned long kernel_text_size;
@@ -83,6 +88,11 @@ unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
 				void (*error)(char *x));
 
 extern struct boot_params *boot_params_ptr;
+extern unsigned long *trampoline_32bit;
+extern const u16 trampoline_ljmp_imm_offset;
+
+void trampoline_32bit_src(void *trampoline, bool enable_5lvl);
+
 #endif
 
 #endif /* _ASM_X86_BOOT_H */

