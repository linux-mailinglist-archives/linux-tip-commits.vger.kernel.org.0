Return-Path: <linux-tip-commits+bounces-3095-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E95439F67E8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F31A07A02D8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F56D1B043C;
	Wed, 18 Dec 2024 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NLCVwcJ5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dW1f4Z/n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D3B1F37DB;
	Wed, 18 Dec 2024 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530610; cv=none; b=dXnKOtAuTGJ9+bSzUNQ+0v3qM/40otkquATOm8KexPhkQVr+Hjic8o0mP1YlFS9lsmwZcrdiLMe9ZVks4kaOfkGJnZJZbYEmxLmNEpBsTmSuJvZhEvcIHS5o8advdnulFTJlI6WmjHzTfG3QTBd7MbmpcrwrQV9Oytuc+3WcUi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530610; c=relaxed/simple;
	bh=tDynEcGMDMrvDUiirbqqlXlzRAp5Xv7SkwpgCGQXfbQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=m1b68Y16BkxgIIXem/mJlVKV+rT9N97EN5t6eW04yYS1z7B6Q9yKnmaGEGAGrnt6P5CDpdIT8ppP1pvKzRhQsPrLGQdqEdjqhn6wfQsoSD79+N0ysaHFOHoJmw4nUVP0kvsxYGWiHd4KoEh9pmOZ38V3BV6dMG5R03XWPlEIFzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NLCVwcJ5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dW1f4Z/n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:03:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734530604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=olb015azSlSzhdo9v5Bk1hqnVDK7VCere2wQ6OUYmjE=;
	b=NLCVwcJ5O9zOmF+2b30rhaqZxsJXCdVJKQuZS1gPxyLffcJfC2iMklt/gCalQGDkja9/Gw
	MrM6DFbyrcJMny8VjVcJaVV6D08YxNPY5uH7cnTIjeIBNt4Qm3dH5HoU81UvN2K/f7x6oi
	xDNlIwyjVLf2O8PlohLeuNGMYRMJ0DPb++JibwWPmrz3SRZnYzX0501GVmE5pjjLT2eVIY
	mPT0Xt+KHYG8AfMfUD8yKjcSZRh7F8zX5ropxz7T9RnEVg2kjRhn6aN3xe4SuV+1u/FDgf
	h0DpQdaU7dEULgET9W+QzuFSBs9+BfdZRM2x9E9Hhgvw9OynLC+QHcGlXc/8Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734530604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=olb015azSlSzhdo9v5Bk1hqnVDK7VCere2wQ6OUYmjE=;
	b=dW1f4Z/n75NfFoqLh7YFat612a12/uizGaZiIiUFwpm0NcegwIqP0YiM3eGsemVfc/P7vG
	5kdG0b5Y0IrpHrAA==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Move MWAIT leaf definition to common header
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173453060385.7135.5067154712048214285.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     bba23e1b3291ac2356061e44463494fea495c087
Gitweb:        https://git.kernel.org/tip/bba23e1b3291ac2356061e44463494fea495c087
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:28 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 05:24:42 -08:00

x86/cpu: Move MWAIT leaf definition to common header

Begin constructing a common place to keep all CPUID leaf definitions.
Move CPUID_MWAIT_LEAF to the CPUID header and include it where
needed.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/all/20241213205028.EE94D02A%40davehans-spike.ostc.intel.com
---
 arch/x86/include/asm/cpuid.h  | 2 ++
 arch/x86/include/asm/mwait.h  | 1 -
 arch/x86/kernel/acpi/cstate.c | 1 +
 arch/x86/kernel/hpet.c        | 1 +
 arch/x86/kernel/process.c     | 1 +
 arch/x86/kernel/smpboot.c     | 1 +
 arch/x86/xen/enlighten_pv.c   | 1 +
 drivers/acpi/acpi_pad.c       | 1 +
 drivers/idle/intel_idle.c     | 1 +
 9 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index 239b9ba..13ecab9 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -21,6 +21,8 @@ enum cpuid_regs_idx {
 	CPUID_EDX,
 };
 
+#define CPUID_MWAIT_LEAF		5
+
 #ifdef CONFIG_X86_32
 bool have_cpuid_p(void);
 #else
diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 920426d..ce857ef 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -15,7 +15,6 @@
 #define MWAIT_HINT2SUBSTATE(hint)	((hint) & MWAIT_CSTATE_MASK)
 #define MWAIT_C1_SUBSTATE_MASK  0xf0
 
-#define CPUID_MWAIT_LEAF		5
 #define CPUID5_ECX_EXTENSIONS_SUPPORTED 0x1
 #define CPUID5_ECX_INTERRUPT_BREAK	0x2
 
diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index f3ffd0a..2779a93 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 
 #include <acpi/processor.h>
+#include <asm/cpuid.h>
 #include <asm/mwait.h>
 #include <asm/special_insns.h>
 
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index c96ae8f..2593504 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -7,6 +7,7 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
 
+#include <asm/cpuid.h>
 #include <asm/irq_remapping.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 58ead05..d40fc49 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -30,6 +30,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/entry-common.h>
 #include <asm/cpu.h>
+#include <asm/cpuid.h>
 #include <asm/apic.h>
 #include <linux/uaccess.h>
 #include <asm/mwait.h>
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index b5a8f08..52b0d30 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -64,6 +64,7 @@
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
+#include <asm/cpuid.h>
 #include <asm/desc.h>
 #include <asm/nmi.h>
 #include <asm/irq.h>
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index fd21690..b355070 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -49,6 +49,7 @@
 #include <xen/hvc-console.h>
 #include <xen/acpi.h>
 
+#include <asm/cpuid.h>
 #include <asm/paravirt.h>
 #include <asm/apic.h>
 #include <asm/page.h>
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 4ec20fd..b561974 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -19,6 +19,7 @@
 #include <linux/acpi.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
+#include <asm/cpuid.h>
 #include <asm/mwait.h>
 #include <xen/xen.h>
 
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ac4d8fa..5d8ed1a 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -51,6 +51,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/moduleparam.h>
+#include <asm/cpuid.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/mwait.h>

