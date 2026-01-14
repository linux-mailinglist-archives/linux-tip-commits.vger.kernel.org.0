Return-Path: <linux-tip-commits+bounces-8001-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3E8D1E2BC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16F2430243B7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC462396D34;
	Wed, 14 Jan 2026 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KCE4BG/y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZPQhEtkc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC130396B60;
	Wed, 14 Jan 2026 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387227; cv=none; b=C2qSz3Bc7rNzaefSJiZ1zvbj8MAqJKarni1hwrbhK1x0TpDAUuOCzj3dfsOX8FrDbuq596KH2Ecvkg52U1SrNuMkSvnFIAssFQe5hCxfTB7YZX1B4eDyn/ePaVF/TEUjfI/JjMlpWUeL0iPZT4DdO4Yd2vLKxmpaOGbYdTaO4tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387227; c=relaxed/simple;
	bh=jU5BgR7bWiQe2I1kSSJ7O9L5B1WpzJYha/vOznBEbZ0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QE1GN5GjidrsOK19l3CRJoY1EDmwe7bWtccpA1644HQqhQe1thnYkVftsQcz1O4HWKlzkIOjWmcgLRt0rR07HzhEc19ZsXQjvAzZEsr3WyPCrPki6kiu8yRVzPzMCL1CHs5p1gMXvItkkteikNPhbQ1Yr/JoM5vAe3w+XwOgoKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KCE4BG/y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZPQhEtkc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:40:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1EALiB+sOM9L+GmJc3uHDnDg1V56hnEM6Mq+LoiQGc=;
	b=KCE4BG/yRfOVybkLaiutc6j0pqOSBys3X5YhL8lQSQGwgDOQCTNyzqc0yBQNMzbdI0k3xZ
	JF+QgU91URxTIOauC4oRnVV6ECXZwBF97vhzNAhO1/KOjhzePDHNdNMXdzxxv61EX78xYy
	DMk8s8v6SFUoa+kpDZW3TNRSfKSCU518ASfQVM3WZDxfF6Z/e8aXJakjUBWuw0xGy8thLk
	9rJGmx0KU015UNpMNE+T+52/elOWVHfck5LpMJvwGMNj1pkC754ufys6/X10S16E+hhn2y
	bhI5n7D7F49uFSUdYGym9mMcF6AMxNbeP+6Zk7gvvA1gPZA49t6I7jdcSzy4+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1EALiB+sOM9L+GmJc3uHDnDg1V56hnEM6Mq+LoiQGc=;
	b=ZPQhEtkcehA6r8No2Kxk/M1uGrWjTpkQzEgt1brAKXFId+mVr/3poQl1fjAKk/wmcImMlM
	GoI9mUqmMSnpnMAg==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/paravirt] x86/paravirt: Remove not needed includes of paravirt.h
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-2-jgross@suse.com>
References: <20260105110520.21356-2-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838722189.510.15595259966273928422.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     07f2961235ac26da12479535cf19a82cde529865
Gitweb:        https://git.kernel.org/tip/07f2961235ac26da12479535cf19a82cde5=
29865
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:00 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Jan 2026 11:26:52 +01:00

x86/paravirt: Remove not needed includes of paravirt.h

In some places asm/paravirt.h is included without really being needed.

Remove the related #include statements.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260105110520.21356-2-jgross@suse.com
---
 arch/x86/entry/entry_64.S             | 1 -
 arch/x86/entry/vsyscall/vsyscall_64.c | 1 -
 arch/x86/hyperv/hv_spinlock.c         | 1 -
 arch/x86/include/asm/apic.h           | 4 ----
 arch/x86/include/asm/highmem.h        | 1 -
 arch/x86/include/asm/mshyperv.h       | 1 -
 arch/x86/include/asm/pgtable_32.h     | 1 -
 arch/x86/include/asm/spinlock.h       | 1 -
 arch/x86/include/asm/tlbflush.h       | 4 ----
 arch/x86/kernel/apm_32.c              | 1 -
 arch/x86/kernel/callthunks.c          | 1 -
 arch/x86/kernel/cpu/bugs.c            | 1 -
 arch/x86/kernel/vsmp_64.c             | 1 -
 arch/x86/lib/cache-smp.c              | 1 -
 arch/x86/mm/init.c                    | 1 -
 arch/x86/xen/spinlock.c               | 1 -
 16 files changed, 22 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f9983a1..42447b1 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -31,7 +31,6 @@
 #include <asm/hw_irq.h>
 #include <asm/page_types.h>
 #include <asm/irqflags.h>
-#include <asm/paravirt.h>
 #include <asm/percpu.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/=
vsyscall_64.c
index 6e6c0a7..4bd1e27 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -37,7 +37,6 @@
 #include <asm/unistd.h>
 #include <asm/fixmap.h>
 #include <asm/traps.h>
-#include <asm/paravirt.h>
=20
 #define CREATE_TRACE_POINTS
 #include "vsyscall_trace.h"
diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index 81b0066..2a3c2af 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -13,7 +13,6 @@
 #include <linux/spinlock.h>
=20
 #include <asm/mshyperv.h>
-#include <asm/paravirt.h>
 #include <asm/apic.h>
 #include <asm/msr.h>
=20
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index a26e66d..9cd493d 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -90,10 +90,6 @@ static inline bool apic_from_smp_config(void)
 /*
  * Basic functions accessing APICs.
  */
-#ifdef CONFIG_PARAVIRT
-#include <asm/paravirt.h>
-#endif
-
 static inline void native_apic_mem_write(u32 reg, u32 v)
 {
 	volatile u32 *addr =3D (volatile u32 *)(APIC_BASE + reg);
diff --git a/arch/x86/include/asm/highmem.h b/arch/x86/include/asm/highmem.h
index 585bdad..decfaaf 100644
--- a/arch/x86/include/asm/highmem.h
+++ b/arch/x86/include/asm/highmem.h
@@ -24,7 +24,6 @@
 #include <linux/interrupt.h>
 #include <linux/threads.h>
 #include <asm/tlbflush.h>
-#include <asm/paravirt.h>
 #include <asm/fixmap.h>
 #include <asm/pgtable_areas.h>
=20
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index eef4c3a..f64393e 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -8,7 +8,6 @@
 #include <linux/io.h>
 #include <linux/static_call.h>
 #include <asm/nospec-branch.h>
-#include <asm/paravirt.h>
 #include <asm/msr.h>
 #include <hyperv/hvhdk.h>
 #include <asm/fpu/types.h>
diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable=
_32.h
index b612cc5..acea0cf 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -16,7 +16,6 @@
 #ifndef __ASSEMBLER__
 #include <asm/processor.h>
 #include <linux/threads.h>
-#include <asm/paravirt.h>
=20
 #include <linux/bitops.h>
 #include <linux/list.h>
diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 5b6bc70..934632b 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -7,7 +7,6 @@
 #include <asm/page.h>
 #include <asm/processor.h>
 #include <linux/compiler.h>
-#include <asm/paravirt.h>
 #include <asm/bitops.h>
=20
 /*
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 00daedf..238a6b8 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -300,10 +300,6 @@ static inline void mm_clear_asid_transition(struct mm_st=
ruct *mm) { }
 static inline bool mm_in_asid_transition(struct mm_struct *mm) { return fals=
e; }
 #endif /* CONFIG_BROADCAST_TLB_FLUSH */
=20
-#ifdef CONFIG_PARAVIRT
-#include <asm/paravirt.h>
-#endif
-
 #define flush_tlb_mm(mm)						\
 		flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL, true)
=20
diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index b37ab10..3175d7c 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -229,7 +229,6 @@
 #include <linux/uaccess.h>
 #include <asm/desc.h>
 #include <asm/olpc.h>
-#include <asm/paravirt.h>
 #include <asm/reboot.h>
 #include <asm/nospec-branch.h>
 #include <asm/ibt.h>
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index a951333..e37728f 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -15,7 +15,6 @@
 #include <asm/insn.h>
 #include <asm/kexec.h>
 #include <asm/nospec-branch.h>
-#include <asm/paravirt.h>
 #include <asm/sections.h>
 #include <asm/switch_to.h>
 #include <asm/sync_core.h>
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d0a2847..83f51ca 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -26,7 +26,6 @@
 #include <asm/fpu/api.h>
 #include <asm/msr.h>
 #include <asm/vmx.h>
-#include <asm/paravirt.h>
 #include <asm/cpu_device_id.h>
 #include <asm/e820/api.h>
 #include <asm/hypervisor.h>
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index 7351133..25625e3 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -18,7 +18,6 @@
 #include <asm/apic.h>
 #include <asm/pci-direct.h>
 #include <asm/io.h>
-#include <asm/paravirt.h>
 #include <asm/setup.h>
=20
 #define TOPOLOGY_REGISTER_OFFSET 0x10
diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
index 824664c..7d3edd6 100644
--- a/arch/x86/lib/cache-smp.c
+++ b/arch/x86/lib/cache-smp.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <asm/paravirt.h>
 #include <linux/smp.h>
 #include <linux/export.h>
 #include <linux/kvm_types.h>
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 8bf6ad4..76537d4 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -27,7 +27,6 @@
 #include <asm/pti.h>
 #include <asm/text-patching.h>
 #include <asm/memtype.h>
-#include <asm/paravirt.h>
 #include <asm/mmu_context.h>
=20
 /*
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 8e4efe0..fe56646 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 #include <linux/atomic.h>
=20
-#include <asm/paravirt.h>
 #include <asm/qspinlock.h>
=20
 #include <xen/events.h>

