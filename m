Return-Path: <linux-tip-commits+bounces-3106-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BC99F6845
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015147A1ACF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E931F63D9;
	Wed, 18 Dec 2024 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M7hRXwVs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K7DL9DXe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D21F0E32;
	Wed, 18 Dec 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531763; cv=none; b=kP94fxV/ga3DHR1w9y11EbCKFl8gya0NSVuAqUFDUUQByKvVaOLzYQ+7D1oSH4JPDmdX8K/E8BCVAcIDSNnfFEz7dw/CigOT7cFEb9UBOEcYmeyFu2g5ZGgtzhsdlCeGaraKMo/Xm+F5YPcVNhbV0vv+w0Bho1xrIXMUQIrtmGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531763; c=relaxed/simple;
	bh=Eo5h+91lcPwwjyKm4on22QnnRf85UyEI6W67j0P07Ys=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=bsQKkKVSZxB28HYDFRp7lEo0tgrvH7VkG2HaTTX+CKoCyExGwbxWVYUWwMv05Lkc23ARRGtd8xJbzZaMSSDLHQTSgMrXAdYeAZ5SrUJOOpJQg80dXT6Crfl29AGHVSg5r7u+2SKfIx9WXO6+9MnUTNc3H+z8wXv5PIfHz7tXEFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M7hRXwVs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K7DL9DXe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:22:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734531760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=kaatMg64B97W1x0bcUsuO9mPsew5VNBSpTh+pUlpcZ4=;
	b=M7hRXwVslHZPxgUrbeK/wjZfWJTDaHcKtAMM/qAwJgkV2BHzpsDIu/LgcJmmStwPOcGltB
	6CcnmfT4uMACGSgbm7mSqUkyklnNd5Ie7/sOy4t3D3ul5LREtL/+ODYCZNleVGWhd8wPkP
	0EcKa7OTlBTipJ/0J2gyZEaEI/bDsJl1K+d1e6isC2PS0tnimB008Yndmz8j7Mn2LarmHp
	/SnHc+aFnluLDnCtYOt9RIGgGaFMj4XL1wjQyMdkpX/UpHcIkYzpHhxJDnr5+V+2YFzVkZ
	jQZj2nNTCkeJJz41p30mBPwCDrRhwf7dWXhWYfLjGA1c8ON86hQ3ZOHIxBzodA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734531760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=kaatMg64B97W1x0bcUsuO9mPsew5VNBSpTh+pUlpcZ4=;
	b=K7DL9DXeO0gMPh++w+lvOIFPaZRTPLRvGeCfR6tSh/zmL6lhyK1J2yeezHmtX9k/emkYmK
	8DSNb+HPA1oXKjBg==
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
Message-ID: <173453175932.7135.2704463037975501913.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     497f70284695bbb9b875e182554ef3f18b4a56e2
Gitweb:        https://git.kernel.org/tip/497f70284695bbb9b875e182554ef3f18b4a56e2
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:28 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 06:17:24 -08:00

x86/cpu: Move MWAIT leaf definition to common header

Begin constructing a common place to keep all CPUID leaf definitions.
Move CPUID_MWAIT_LEAF to the CPUID header and include it where
needed.

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

