Return-Path: <linux-tip-commits+bounces-3511-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C9FA39BD6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 13:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DABFD174256
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 12:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36499245030;
	Tue, 18 Feb 2025 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P8mvk+sB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G1h3b2iR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64927243957;
	Tue, 18 Feb 2025 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880711; cv=none; b=S0V5u650eWSpOHpN/4iRcp5CsTGIQDuQw9lrgpTkCerMw6icGIr1Kt3Tnu0JlWDE5xg4TKMLfUsz4T0reCs+dWNzNkfCxEyydZABt8TB556UxpVVEZybrwee3/HPQ7NJKy/h8sQRCe0aJ77zUE3Xr3kuLIXfuWXxi32y/xz7WSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880711; c=relaxed/simple;
	bh=NoHdIk4EV5sSHAOhhSPvu1Cb7ZVBX4cVfmLjcpopYz8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YClxSMT9h3qdlkf1/4P6tisprAJZPxkZL+y+c0Wt/tMRaU5lPolwtOM5DUDRNOzwUWB8oM5Q44y3vFTCHRut1dh1o3K8VSZOa1vCiPvBR/vsr+rti3omk2254dJeibouItZWco8cNtdosyPQdWL64AqwRmm5ETj2lsMNQyjDh/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P8mvk+sB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G1h3b2iR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 12:11:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739880707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9zIFHiroFiDjjwfx9BFaQ+i1JVCScdiFMkvKxT9Eak=;
	b=P8mvk+sB0al0FDgtKduzy3/k8dLNu0F11uD8R+sXaBjnmt8VcOcAmBDPJmEv316Yf1ZN0f
	wRLIwhCatyVDhToqU3IIAbjT+FANt0MOv0RNWfYvALQqOSmERECG4o8IO4dF7y3fZtWrqF
	zzLSSpcU6XDmqSfKhPoKLoEEqvpnl1/ueUmmOP3Gu42Mqxvi9O8tsXQavmKhPHFPZnKca3
	Z9rqGiCtlcQxa3s7CJBfpNia2PYFQanFypSW7JDdviCxeeyPPFNeczRlz5AhhVKWeg6t6n
	0Ij4jM8ot/WgbFqLUWbLeDqmSqo/UHHLgcicKneJqLCYNKjcKeF6mwqbrx5Kcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739880707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9zIFHiroFiDjjwfx9BFaQ+i1JVCScdiFMkvKxT9Eak=;
	b=G1h3b2iRbjZyNH7dwOYP+NMblYcD7fx8E4ZDX01AGaz7VtLHd+3A4hlXqk3ChaDL51uI6X
	D0tjYP2iGcPVVAAA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/module: Deal with GOT based stack cookie load on
 Clang < 17
Cc: Ard Biesheuvel <ardb@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250123190747.745588-7-brgerst@gmail.com>
References: <20250123190747.745588-7-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173988070725.10177.4322931046833384865.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     78c4374ef8b842c6abf195d6f963853c7ec464d2
Gitweb:        https://git.kernel.org/tip/78c4374ef8b842c6abf195d6f963853c7ec464d2
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 23 Jan 2025 14:07:38 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Feb 2025 10:15:05 +01:00

x86/module: Deal with GOT based stack cookie load on Clang < 17

Clang versions before 17 will not honour -fdirect-access-external-data
for the load of the stack cookie emitted into each function's prologue
and epilogue.

This is not an issue for the core kernel, as the linker will relax these
loads into LEA instructions that take the address of __stack_chk_guard
directly. For modules, however, we need to work around this, by dealing
with R_X86_64_REX_GOTPCRELX relocations that refer to __stack_chk_guard.

In this case, given that this is a GOT load, the reference should not
refer to __stack_chk_guard directly, but to a memory location that holds
its address. So take the address of __stack_chk_guard into a static
variable, and fix up the relocations to refer to that.

[ mingo: Fix broken R_X86_64_GOTPCRELX definition. ]

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250123190747.745588-7-brgerst@gmail.com
---
 arch/x86/include/asm/elf.h |  5 +++--
 arch/x86/kernel/module.c   | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 1fb83d4..1286026 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -54,8 +54,9 @@ typedef struct user_i387_struct elf_fpregset_t;
 #define R_X86_64_GLOB_DAT	6	/* Create GOT entry */
 #define R_X86_64_JUMP_SLOT	7	/* Create PLT entry */
 #define R_X86_64_RELATIVE	8	/* Adjust by program base */
-#define R_X86_64_GOTPCREL	9	/* 32 bit signed pc relative
-					   offset to GOT */
+#define R_X86_64_GOTPCREL	9	/* 32 bit signed pc relative offset to GOT */
+#define R_X86_64_GOTPCRELX	41
+#define R_X86_64_REX_GOTPCRELX	42
 #define R_X86_64_32		10	/* Direct 32 bit zero extended */
 #define R_X86_64_32S		11	/* Direct 32 bit sign extended */
 #define R_X86_64_16		12	/* Direct 16 bit zero extended */
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 8984abd..a286f32 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -19,6 +19,7 @@
 #include <linux/jump_label.h>
 #include <linux/random.h>
 #include <linux/memory.h>
+#include <linux/stackprotector.h>
 
 #include <asm/text-patching.h>
 #include <asm/page.h>
@@ -130,6 +131,20 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
 				goto overflow;
 			size = 4;
 			break;
+#if defined(CONFIG_STACKPROTECTOR) && \
+    defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 170000
+		case R_X86_64_REX_GOTPCRELX: {
+			static unsigned long __percpu *const addr = &__stack_chk_guard;
+
+			if (sym->st_value != (u64)addr) {
+				pr_err("%s: Unsupported GOTPCREL relocation\n", me->name);
+				return -ENOEXEC;
+			}
+
+			val = (u64)&addr + rel[i].r_addend;
+			fallthrough;
+		}
+#endif
 		case R_X86_64_PC32:
 		case R_X86_64_PLT32:
 			val -= (u64)loc;

