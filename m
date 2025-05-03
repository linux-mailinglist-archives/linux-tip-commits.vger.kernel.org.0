Return-Path: <linux-tip-commits+bounces-5206-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BC8AA8157
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 May 2025 17:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5E51B61050
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 May 2025 15:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB37F2798E7;
	Sat,  3 May 2025 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dtTx64Gz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gCyQcvb9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96562277017;
	Sat,  3 May 2025 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285304; cv=none; b=dZ7SWU9BKYbd/8pZ7aM+n6Ka54L0MUeBDdQXZLrsc463w2YjH7VRdv2c2HFyw8YlJd4kFYp/VsWZaiqUYGVyBVzlNCWkBBV7VH8YbWM4oOhD4W97XIxkHA9ISVtRqduy+sixY5hsI47ni5k8DuWQUfbf3FImA7pAvTpB4VVRkZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285304; c=relaxed/simple;
	bh=8Pb5XTCjEDvmUtoWsSUpSGXOWwa3p8V7YsO7T7i9cTI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gsj7n7yp4J+ALN+MthHOv/PUHhyiiJtYTXikBF4kqp+snBnhL4zvtDvhpxxBU+tn5PS37nlev61NFB/pN4SZjSwnHPw4ZwoPRn3UFfC1AXttTrjr8VAQVxnNxv9s+gspY/Ko8wIGfE6RW6BmRDAxcQ9q80RFxX+gBuZaCl+5Iig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dtTx64Gz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gCyQcvb9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 03 May 2025 15:14:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746285300;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FkJuB66SV39nuptTv1fPi/pDJugIBtzqQoU1P6CNrXk=;
	b=dtTx64GzHONQhEJ/7zdpZ5EgY4toLBKg2owtp/3rrfuMCgi++yJ8VW+lGAM7p6eI/UX3HB
	FgWyNuhtUmmDUoSrfssNfHenaoRzqK9gKesN+1yGnYoKeO6alBTdTqLsPTur5RYePl9n/g
	XEnVK7Rr0tnB69ltWFjpsEPjnjp/UCmtf/N0bP6ZQ4b+AoxanNpzWLKR898fTvXmepqaMq
	cILQEAcc/u3vMSUuot8XDeOM+Yt3yHwPQGs7CmhxCzwr8OB+KxiIJGY22c133ps/4lODhv
	nIgDEJsbir8UAmm89OwWyGfNqasyk5F+5XqBYmsbfjsD/EXSZ2e3IjrtDgFwVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746285300;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FkJuB66SV39nuptTv1fPi/pDJugIBtzqQoU1P6CNrXk=;
	b=gCyQcvb9GmmpSvmKFoYCzqko0gr/H9FsvllkHoriT7aeVJanDZIEsSPxv0uXaorENuRRHW
	6GvelHK8M6xW+zCg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/microcode: Consolidate the loader enablement checking
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,  <stable@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <CANpbe9Wm3z8fy9HbgS8cuhoj0TREYEEkBipDuhgkWFvqX0UoVQ@mail.gmail.com>
References:
 <CANpbe9Wm3z8fy9HbgS8cuhoj0TREYEEkBipDuhgkWFvqX0UoVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174628529460.22196.11450380316905137027.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     eb72bdfbd0a757f30ebe4f9ec161cb246d19e5ed
Gitweb:        https://git.kernel.org/tip/eb72bdfbd0a757f30ebe4f9ec161cb246d19e5ed
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 14 Apr 2025 11:59:33 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 03 May 2025 16:40:56 +02:00

x86/microcode: Consolidate the loader enablement checking

Consolidate the whole logic which determines whether the microcode loader
should be enabled or not into a single function and call it everywhere.

Well, almost everywhere - not in mk_early_pgtbl_32() because there the kernel
is running without paging enabled and checking dis_ucode_ldr et al would
require physical addresses and uglification of the code.

But since this is 32-bit, the easier thing to do is to simply map the initrd
unconditionally especially since that mapping is getting removed later anyway
by zap_early_initrd_mapping() and avoid the uglification.

Fixes: 4c585af7180c1 ("x86/boot/32: Temporarily map initrd for microcode loading")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/CANpbe9Wm3z8fy9HbgS8cuhoj0TREYEEkBipDuhgkWFvqX0UoVQ@mail.gmail.com
---
 arch/x86/include/asm/microcode.h         |  2 +-
 arch/x86/kernel/cpu/microcode/amd.c      |  6 +-
 arch/x86/kernel/cpu/microcode/core.c     | 58 +++++++++++++----------
 arch/x86/kernel/cpu/microcode/intel.c    |  2 +-
 arch/x86/kernel/cpu/microcode/internal.h |  1 +-
 arch/x86/kernel/head32.c                 |  4 +--
 6 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 695e569..d53148f 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -17,10 +17,12 @@ struct ucode_cpu_info {
 void load_ucode_bsp(void);
 void load_ucode_ap(void);
 void microcode_bsp_resume(void);
+bool __init microcode_loader_disabled(void);
 #else
 static inline void load_ucode_bsp(void)	{ }
 static inline void load_ucode_ap(void) { }
 static inline void microcode_bsp_resume(void) { }
+bool __init microcode_loader_disabled(void) { return false; }
 #endif
 
 extern unsigned long initrd_start_early;
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 4a10d35..96cb992 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -1098,15 +1098,17 @@ static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
 
 static int __init save_microcode_in_initrd(void)
 {
-	unsigned int cpuid_1_eax = native_cpuid_eax(1);
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 	struct cont_desc desc = { 0 };
+	unsigned int cpuid_1_eax;
 	enum ucode_state ret;
 	struct cpio_data cp;
 
-	if (dis_ucode_ldr || c->x86_vendor != X86_VENDOR_AMD || c->x86 < 0x10)
+	if (microcode_loader_disabled() || c->x86_vendor != X86_VENDOR_AMD || c->x86 < 0x10)
 		return 0;
 
+	cpuid_1_eax = native_cpuid_eax(1);
+
 	if (!find_blobs_in_containers(&cp))
 		return -EINVAL;
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b3658d1..079f046 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -41,8 +41,8 @@
 
 #include "internal.h"
 
-static struct microcode_ops	*microcode_ops;
-bool dis_ucode_ldr = true;
+static struct microcode_ops *microcode_ops;
+static bool dis_ucode_ldr = false;
 
 bool force_minrev = IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV);
 module_param(force_minrev, bool, S_IRUSR | S_IWUSR);
@@ -84,6 +84,9 @@ static bool amd_check_current_patch_level(void)
 	u32 lvl, dummy, i;
 	u32 *levels;
 
+	if (x86_cpuid_vendor() != X86_VENDOR_AMD)
+		return false;
+
 	native_rdmsr(MSR_AMD64_PATCH_LEVEL, lvl, dummy);
 
 	levels = final_levels;
@@ -95,27 +98,29 @@ static bool amd_check_current_patch_level(void)
 	return false;
 }
 
-static bool __init check_loader_disabled_bsp(void)
+bool __init microcode_loader_disabled(void)
 {
-	static const char *__dis_opt_str = "dis_ucode_ldr";
-	const char *cmdline = boot_command_line;
-	const char *option  = __dis_opt_str;
+	if (dis_ucode_ldr)
+		return true;
 
 	/*
-	 * CPUID(1).ECX[31]: reserved for hypervisor use. This is still not
-	 * completely accurate as xen pv guests don't see that CPUID bit set but
-	 * that's good enough as they don't land on the BSP path anyway.
+	 * Disable when:
+	 *
+	 * 1) The CPU does not support CPUID.
+	 *
+	 * 2) Bit 31 in CPUID[1]:ECX is clear
+	 *    The bit is reserved for hypervisor use. This is still not
+	 *    completely accurate as XEN PV guests don't see that CPUID bit
+	 *    set, but that's good enough as they don't land on the BSP
+	 *    path anyway.
+	 *
+	 * 3) Certain AMD patch levels are not allowed to be
+	 *    overwritten.
 	 */
-	if (native_cpuid_ecx(1) & BIT(31))
-		return true;
-
-	if (x86_cpuid_vendor() == X86_VENDOR_AMD) {
-		if (amd_check_current_patch_level())
-			return true;
-	}
-
-	if (cmdline_find_option_bool(cmdline, option) <= 0)
-		dis_ucode_ldr = false;
+	if (!have_cpuid_p() ||
+	    native_cpuid_ecx(1) & BIT(31) ||
+	    amd_check_current_patch_level())
+		dis_ucode_ldr = true;
 
 	return dis_ucode_ldr;
 }
@@ -125,7 +130,10 @@ void __init load_ucode_bsp(void)
 	unsigned int cpuid_1_eax;
 	bool intel = true;
 
-	if (!have_cpuid_p())
+	if (cmdline_find_option_bool(boot_command_line, "dis_ucode_ldr") > 0)
+		dis_ucode_ldr = true;
+
+	if (microcode_loader_disabled())
 		return;
 
 	cpuid_1_eax = native_cpuid_eax(1);
@@ -146,9 +154,6 @@ void __init load_ucode_bsp(void)
 		return;
 	}
 
-	if (check_loader_disabled_bsp())
-		return;
-
 	if (intel)
 		load_ucode_intel_bsp(&early_data);
 	else
@@ -159,6 +164,11 @@ void load_ucode_ap(void)
 {
 	unsigned int cpuid_1_eax;
 
+	/*
+	 * Can't use microcode_loader_disabled() here - .init section
+	 * hell. It doesn't have to either - the BSP variant must've
+	 * parsed cmdline already anyway.
+	 */
 	if (dis_ucode_ldr)
 		return;
 
@@ -810,7 +820,7 @@ static int __init microcode_init(void)
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 	int error;
 
-	if (dis_ucode_ldr)
+	if (microcode_loader_disabled())
 		return -EINVAL;
 
 	if (c->x86_vendor == X86_VENDOR_INTEL)
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 819199b..2a397da 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -389,7 +389,7 @@ static int __init save_builtin_microcode(void)
 	if (xchg(&ucode_patch_va, NULL) != UCODE_BSP_LOADED)
 		return 0;
 
-	if (dis_ucode_ldr || boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (microcode_loader_disabled() || boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
 	uci.mc = get_microcode_blob(&uci, true);
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 5df6217..50a9702 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -94,7 +94,6 @@ static inline unsigned int x86_cpuid_family(void)
 	return x86_family(eax);
 }
 
-extern bool dis_ucode_ldr;
 extern bool force_minrev;
 
 #ifdef CONFIG_CPU_SUP_AMD
diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index de001b2..375f2d7 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -145,10 +145,6 @@ void __init __no_stack_protector mk_early_pgtbl_32(void)
 	*ptr = (unsigned long)ptep + PAGE_OFFSET;
 
 #ifdef CONFIG_MICROCODE_INITRD32
-	/* Running on a hypervisor? */
-	if (native_cpuid_ecx(1) & BIT(31))
-		return;
-
 	params = (struct boot_params *)__pa_nodebug(&boot_params);
 	if (!params->hdr.ramdisk_size || !params->hdr.ramdisk_image)
 		return;

