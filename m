Return-Path: <linux-tip-commits+bounces-5560-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A86BAB8D7D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 19:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A0116A4CE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 17:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2121325C6F4;
	Thu, 15 May 2025 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gb2h1jsa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UkHh7Do7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C49F258CF4;
	Thu, 15 May 2025 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329444; cv=none; b=lum5tg8Y22zT62msOqQWJU09GS2a+y5CMXjPnGfPNKpmxiKkdHsZcVgft5vjLDXBjAO+MORjOpxZiZKYa9i/g/KDCu8FxcMBAT4CRJHT7U2lhMpN5SoFEcVANuRjeekVh5lwyHeO56XuhywoOJxn3ONJ2XQjfFUDA0NwezU4wZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329444; c=relaxed/simple;
	bh=DWLi+pfq8wqzoy9fxCts7QtNQgnQ2rSQjG8nmDTG4fg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BhnX42FJ6AKlKRJ066W3R6lEdVFmJLkhu2errDcXGwpnlBbjZSIYmIWIOq2XcboGvDHyG1dXbzGPgvFcKkZF6cWc3qwZWaY1XwL7sGfdh/3xJBe767KScMWch/kgl0G2jyBjdfqL4jDy7/JhHrjB1PcDvnu6H61GTb5Z3obNLkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gb2h1jsa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UkHh7Do7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 May 2025 17:17:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747329438;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9tTeSggDHomyX793xESkkRISzN7l8LzMhIpDueBFBU=;
	b=gb2h1jsaZ6AUTNMme0vLxtQvHVIBgA3oo7bLOfMRiLhxSAoTzY5CLv2bI+uCSGY5jwvJJT
	fZVJJW8Tiz8PylDJ4zOb0ICu7BPFkEV6ZOfc6Qn/CVQbPWMx7sYdtx6igx8NMBRmUEdZsq
	OQDb6yXJ1lD0XH9mSt0uwcklmEkgY8VPszHytxF2wBU5RfNOhOSoCOi6My6o1RQRmm6VWE
	Pivt9pmK/2icXBMxlyy9RpgkI7V/Xb/COX6rcI6tWiLy8IICwkuqffbcI7GcSRzQq3/U/0
	OJet5/TMucu0nZvLVt666h/9JU0x6vXsxeQv/E+CY+/VVOoWnlZ6yOfqsZdvZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747329438;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9tTeSggDHomyX793xESkkRISzN7l8LzMhIpDueBFBU=;
	b=UkHh7Do7ewNKvzSou7/b4i7mz389YdJ+VWS5Dqy9ZpDq7xv+3V24QjAUJJyrR8Q8mDRAW1
	6uwU8eS7tAMVq8Bg==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/cpuid: Set <asm/cpuid/api.h> as the main CPUID header
Cc: Ingo Molnar <mingo@kernel.org>, "Ahmed S. Darwish" <darwi@linutronix.de>,
 Andrew Cooper <andrew.cooper3@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>,
 John Ogness <john.ogness@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250508150240.172915-3-darwi@linutronix.de>
References: <20250508150240.172915-3-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174732943783.406.7046718117296673782.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     968e3000680713f712bcf02c51c4d7bb7d4d7685
Gitweb:        https://git.kernel.org/tip/968e3000680713f712bcf02c51c4d7bb7d4d7685
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 08 May 2025 17:02:31 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 15 May 2025 18:23:55 +02:00

x86/cpuid: Set <asm/cpuid/api.h> as the main CPUID header

The main CPUID header <asm/cpuid.h> was originally a storefront for the
headers:

    <asm/cpuid/api.h>
    <asm/cpuid/leaf_0x2_api.h>

Now that the latter CPUID(0x2) header has been merged into the former,
there is no practical difference between <asm/cpuid.h> and
<asm/cpuid/api.h>.

Migrate all users to the <asm/cpuid/api.h> header, in preparation of
the removal of <asm/cpuid.h>.

Don't remove <asm/cpuid.h> just yet, in case some new code in -next
started using it.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250508150240.172915-3-darwi@linutronix.de
---
 arch/x86/boot/compressed/sev.c        | 2 +-
 arch/x86/boot/startup/sev-startup.c   | 2 +-
 arch/x86/coco/sev/core.c              | 2 +-
 arch/x86/coco/sev/vc-handle.c         | 2 +-
 arch/x86/events/intel/pt.c            | 2 +-
 arch/x86/include/asm/processor.h      | 2 +-
 arch/x86/kernel/acpi/cstate.c         | 2 +-
 arch/x86/kernel/amd_nb.c              | 2 +-
 arch/x86/kernel/cpu/cacheinfo.c       | 2 +-
 arch/x86/kernel/cpu/common.c          | 2 +-
 arch/x86/kernel/cpu/intel.c           | 2 +-
 arch/x86/kernel/fpu/xstate.c          | 2 +-
 arch/x86/kernel/hpet.c                | 2 +-
 arch/x86/kernel/process.c             | 2 +-
 arch/x86/kernel/smpboot.c             | 2 +-
 arch/x86/kernel/tsc.c                 | 2 +-
 arch/x86/kvm/cpuid.c                  | 2 +-
 arch/x86/virt/svm/sev.c               | 2 +-
 arch/x86/xen/enlighten_pv.c           | 2 +-
 drivers/acpi/acpi_pad.c               | 2 +-
 drivers/dma/ioat/dca.c                | 2 +-
 drivers/idle/intel_idle.c             | 2 +-
 drivers/platform/x86/intel/pmc/core.c | 2 +-
 sound/soc/intel/avs/tgl.c             | 2 +-
 24 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 612b443..fd1b67d 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -21,7 +21,7 @@
 #include <asm/fpu/xcr.h>
 #include <asm/ptrace.h>
 #include <asm/svm.h>
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 
 #include "error.h"
 #include "sev.h"
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 435853a..0b7e3b9 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -38,7 +38,7 @@
 #include <asm/smp.h>
 #include <asm/cpu.h>
 #include <asm/apic.h>
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include <asm/cmdline.h>
 
 /* For early boot hypervisor communication in SEV-ES enabled guests */
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b40c159..5678c3f 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -42,7 +42,7 @@
 #include <asm/smp.h>
 #include <asm/cpu.h>
 #include <asm/apic.h>
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include <asm/cmdline.h>
 #include <asm/msr.h>
 
diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index b4895c6..0989d98 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -32,7 +32,7 @@
 #include <asm/smp.h>
 #include <asm/cpu.h>
 #include <asm/apic.h>
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 
 static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 					   unsigned long vaddr, phys_addr_t *paddr)
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index f37cce2..9dbc688 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -18,7 +18,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include <asm/perf_event.h>
 #include <asm/insn.h>
 #include <asm/io.h>
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 50d3469..bde58f6 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -16,7 +16,7 @@ struct vm86;
 #include <uapi/asm/sigcontext.h>
 #include <asm/current.h>
 #include <asm/cpufeatures.h>
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include <asm/page.h>
 #include <asm/pgtable_types.h>
 #include <asm/percpu.h>
diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index d5ac341..8698d66 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -14,7 +14,7 @@
 
 #include <acpi/processor.h>
 #include <asm/cpu_device_id.h>
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include <asm/mwait.h>
 #include <asm/special_insns.h>
 #include <asm/smp.h>
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 7c79c9f..c1acead 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -15,7 +15,7 @@
 #include <linux/pci_ids.h>
 
 #include <asm/amd/nb.h>
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 
 static u32 *flush_words;
 
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index f866d94..6d61f7d 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -16,7 +16,7 @@
 #include <asm/amd/nb.h>
 #include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include <asm/mtrr.h>
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 114aaaf..c14db8d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -29,7 +29,7 @@
 
 #include <asm/alternative.h>
 #include <asm/cmdline.h>
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include <asm/perf_event.h>
 #include <asm/mmu_context.h>
 #include <asm/doublefault.h>
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 584dd55..7f8ca29 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -16,7 +16,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu.h>
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include <asm/hwcap2.h>
 #include <asm/intel-family.h>
 #include <asm/microcode.h>
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 3e477a5..9aa9ac8 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -21,7 +21,7 @@
 #include <asm/fpu/signal.h>
 #include <asm/fpu/xcr.h>
 
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
 #include <asm/tlbflush.h>
 #include <asm/prctl.h>
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index c9982a7..d6387dd 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -7,7 +7,7 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
 
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include <asm/irq_remapping.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 4b668bc..c1d2dac 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -30,7 +30,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/entry-common.h>
 #include <asm/cpu.h>
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include <asm/apic.h>
 #include <linux/uaccess.h>
 #include <asm/mwait.h>
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index d6cf1e2..d7d61b3 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -64,7 +64,7 @@
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include <asm/desc.h>
 #include <asm/nmi.h>
 #include <asm/irq.h>
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 5d3a764..87e7491 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -16,7 +16,7 @@
 #include <linux/static_key.h>
 #include <linux/static_call.h>
 
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include <asm/hpet.h>
 #include <asm/timer.h>
 #include <asm/vgtod.h>
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 571c906..7f43d8d 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -21,7 +21,7 @@
 #include <asm/user.h>
 #include <asm/fpu/xstate.h>
 #include <asm/sgx.h>
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include "cpuid.h"
 #include "lapic.h"
 #include "mmu.h"
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 76926f7..942372e 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -27,7 +27,7 @@
 #include <asm/smp.h>
 #include <asm/cpu.h>
 #include <asm/apic.h>
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include <asm/cmdline.h>
 #include <asm/iommu.h>
 #include <asm/msr.h>
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 3be3835..7f9ded1 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -49,7 +49,7 @@
 #include <xen/hvc-console.h>
 #include <xen/acpi.h>
 
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include <asm/paravirt.h>
 #include <asm/apic.h>
 #include <asm/page.h>
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 3fde449..6f8bbe1 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -19,7 +19,7 @@
 #include <linux/acpi.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include <asm/mwait.h>
 #include <xen/xen.h>
 
diff --git a/drivers/dma/ioat/dca.c b/drivers/dma/ioat/dca.c
index c9aba23..5d3c0ae 100644
--- a/drivers/dma/ioat/dca.c
+++ b/drivers/dma/ioat/dca.c
@@ -10,7 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/dca.h>
 
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 
 /* either a kernel change is needed, or we need something like this in kernel */
 #ifndef CONFIG_SMP
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 6a1712b..433d858 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -51,7 +51,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/moduleparam.h>
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/mwait.h>
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index ff7f64d..9f678c7 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -22,7 +22,7 @@
 #include <linux/suspend.h>
 #include <linux/units.h>
 
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/msr.h>
diff --git a/sound/soc/intel/avs/tgl.c b/sound/soc/intel/avs/tgl.c
index 56905f2..9dbb3ad 100644
--- a/sound/soc/intel/avs/tgl.c
+++ b/sound/soc/intel/avs/tgl.c
@@ -47,7 +47,7 @@ static int avs_tgl_config_basefw(struct avs_dev *adev)
 #ifdef CONFIG_X86
 	unsigned int ecx;
 
-#include <asm/cpuid.h>
+#include <asm/cpuid/api.h>
 	ecx = cpuid_ecx(CPUID_TSC_LEAF);
 	if (ecx) {
 		ret = avs_ipc_set_fw_config(adev, 1, AVS_FW_CFG_XTAL_FREQ_HZ, sizeof(ecx), &ecx);

