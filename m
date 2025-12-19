Return-Path: <linux-tip-commits+bounces-7770-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4FBCCEDD5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Dec 2025 08:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0202B3015A8A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Dec 2025 07:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9033B261B9B;
	Fri, 19 Dec 2025 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yauCMQGv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7lVl/uP6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82AD23A58B;
	Fri, 19 Dec 2025 07:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766131139; cv=none; b=uHj9bnn/I/d2hXMNDAw349Go0nKSWHcm8k7277fn/qMp54L5t/GMZQCyM8mUp3Bj7FuWwapfdR2qUF2Fv75PvdF6Zlbv2c4Zvx5WBfIg28XtRkcerlO5VQewqWiaCpbYek99U/sn/dxFzUPxKhHHVOmqmloht9Wtnr+9sH2euEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766131139; c=relaxed/simple;
	bh=9P5CU4kx4WVO6CgGXByT5ru2tzKDRvPmpRoqueWaCyQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mem2N8dLqTZyRRsSAO+0/jLKNkpT2d8AkObZzhru6X7R2jNK6Ab/Y6UlBZPfFZeFAoyQ75QffQEcyxPcMZbd5RFs9+64MYIDkmkEPcxmt8Iis5z2NVLai5R1D/qu5/5tCofZrQHRhYhaKDfzt6j4LEARERPeyfaHebQ5rK6oSC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yauCMQGv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7lVl/uP6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 19 Dec 2025 07:58:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766131135;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGf3Cz8Y6ww7zyHXjJu02nugfKUbQo+fv1YvoPUEJqs=;
	b=yauCMQGvUQY11YSGHbItCZJFDxiAZ2TqS8PfA9P1Ko7iJyQSgMIt/Q+lN3INwyFiVn40dV
	ap5IuDL5za/CquiPaVNmhUl0mB1NShJNeskam5JpImkY5CyGJ9NFLqTAB1yCPEaRcNTb+9
	iQsChjNtOgMM6971mh2ZcVfSQgdg+YbmCPItZ4n8rbxL7O2VNm3LMHtlZRgvTAIVNAFMXk
	3d0lqVgH/u1HWKS9VXGEVoicYXXkjS4+1EWwNaZiMyfV1TGnH8oxCcjggU89T4ZY3bIIj4
	e+UVLMj+zo9i+hvVAhLrlXtgM9rgbF3o5iQ1lJmhIeOAgJVXL7SpQHlfJMmWQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766131135;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGf3Cz8Y6ww7zyHXjJu02nugfKUbQo+fv1YvoPUEJqs=;
	b=7lVl/uP6jVmvnkfwB1IVq0dx/iBfcAp1QoC5hcO5uAFxozPjrPLotY9ruJf8TarJ60A4K7
	W+gvEdYGTM4aOpBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf: Use EXPORT_SYMBOL_FOR_KVM() for the mediated APIs
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251208115156.GE3707891@noisy.programming.kicks-ass.net>
References: <20251208115156.GE3707891@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176613113429.510.12164733589030394212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     01122b89361e565b3c88b9fbebe92dc5c7420cb7
Gitweb:        https://git.kernel.org/tip/01122b89361e565b3c88b9fbebe92dc5c74=
20cb7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 17 Dec 2025 13:23:59 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 19 Dec 2025 08:54:59 +01:00

perf: Use EXPORT_SYMBOL_FOR_KVM() for the mediated APIs

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251208115156.GE3707891@noisy.programming.kic=
ks-ass.net
---
 arch/x86/events/core.c     | 5 +++--
 include/asm-generic/Kbuild | 1 +
 kernel/events/core.c       | 5 +++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index df7a32b..0ecac94 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -30,6 +30,7 @@
 #include <linux/device.h>
 #include <linux/nospec.h>
 #include <linux/static_call.h>
+#include <linux/kvm_types.h>
=20
 #include <asm/apic.h>
 #include <asm/stacktrace.h>
@@ -1771,14 +1772,14 @@ void perf_load_guest_lvtpc(u32 guest_lvtpc)
 		   APIC_DM_FIXED | PERF_GUEST_MEDIATED_PMI_VECTOR | masked);
 	this_cpu_write(guest_lvtpc_loaded, true);
 }
-EXPORT_SYMBOL_FOR_MODULES(perf_load_guest_lvtpc, "kvm");
+EXPORT_SYMBOL_FOR_KVM(perf_load_guest_lvtpc);
=20
 void perf_put_guest_lvtpc(void)
 {
 	this_cpu_write(guest_lvtpc_loaded, false);
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 }
-EXPORT_SYMBOL_FOR_MODULES(perf_put_guest_lvtpc, "kvm");
+EXPORT_SYMBOL_FOR_KVM(perf_put_guest_lvtpc);
 #endif /* CONFIG_PERF_GUEST_MEDIATED_PMU */
=20
 static int
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 295c94a..9aff61e 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -32,6 +32,7 @@ mandatory-y +=3D irq_work.h
 mandatory-y +=3D kdebug.h
 mandatory-y +=3D kmap_size.h
 mandatory-y +=3D kprobes.h
+mandatory-y +=3D kvm_types.h
 mandatory-y +=3D linkage.h
 mandatory-y +=3D local.h
 mandatory-y +=3D local64.h
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e6a4b1e..376fb07 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -57,6 +57,7 @@
 #include <linux/task_work.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/unwind_deferred.h>
+#include <linux/kvm_types.h>
=20
 #include "internal.h"
=20
@@ -6388,7 +6389,7 @@ int perf_create_mediated_pmu(void)
 	atomic_inc(&nr_mediated_pmu_vms);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(perf_create_mediated_pmu);
+EXPORT_SYMBOL_FOR_KVM(perf_create_mediated_pmu);
=20
 void perf_release_mediated_pmu(void)
 {
@@ -6397,7 +6398,7 @@ void perf_release_mediated_pmu(void)
=20
 	atomic_dec(&nr_mediated_pmu_vms);
 }
-EXPORT_SYMBOL_GPL(perf_release_mediated_pmu);
+EXPORT_SYMBOL_FOR_KVM(perf_release_mediated_pmu);
=20
 /* When loading a guest's mediated PMU, schedule out all exclude_guest event=
s. */
 void perf_load_guest_context(void)

