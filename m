Return-Path: <linux-tip-commits+bounces-7732-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 831CBCC7B1E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27960306C560
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 12:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70E733B6E5;
	Wed, 17 Dec 2025 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZFSRFGx3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dJM06PZv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053CE33D6E4;
	Wed, 17 Dec 2025 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975082; cv=none; b=smaeIKCiFqwnruKlrX1nW8XpBjRkn/XuPEadpJHi1SAWmbO3d3i89N0p69uHOG5qJwcxOupidATHviJpBT9vHwFrv/Nzi33aboLDDNPrrz8kt669BsZbnTOps62/voELWoe/ylzsTpaOLouj8i+49exhDP38WdHnIDiNn+YCkoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975082; c=relaxed/simple;
	bh=OTcI5VVVaYPWFcv65UCVTXhXMagfy5Uj+zu+16WcvwU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rbgMOo4x/Rv6De8s4DFcmW/asn2XARhTw3xR3suqRQNXVwLQl20J57z6hLet6aPATnoLQhNxLquGZC+ghzRYRnmadskt5Qeerm8DXDNdOSx5EoVoJNZXSQKCZw4TWQiBTOXqH7OrkN9X/0Z/FHvG7eZoU1NhRQPJHdVAXC4a1oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZFSRFGx3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dJM06PZv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:37:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975078;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z79kxBcOo+8rbo90vQcrOlHYkFwXnKUSiCeztwHNtiE=;
	b=ZFSRFGx3gWt2IrXm/Rp1D+Brt2vwwJESd6YnkhhlbeZKqHg1SoOewKrJG0Bi2webpdmV1n
	HhP5tSpjNCJJCF8SSWTqh1Qp1pNq6b7OoOjVo5E35C09GNXd3QvHvkcGMjRMRaWx14+kiH
	AEGpctt6J1nlpEQvIPAH6Td4rlxwnfJCWfoJF1Lhw1ILlYoYODp0Grv5T5trkoxyxWz7ax
	wLXOLKzQfIDkhYRVxoTJhCL+WoEMfiYKxgYJiHNus/gwB0AEPrXrU0LPAwFfNigsujVttc
	YjSVGJn2smMjc7fTk8FOJMNtM7yQP/P5O7Dc1aaJwtOD/5W2xGWmHuVq3bexRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975078;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z79kxBcOo+8rbo90vQcrOlHYkFwXnKUSiCeztwHNtiE=;
	b=dJM06PZv2mQwd0sloscDlT0Kbx5tkpcuFZaq7t1ShGHHX/J6oBmD+QlvfFyCzgBWeQDlwX
	E082IVkgarkJTbCQ==
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
Message-ID: <176597507731.510.6380001909229389563.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     23faa33d88df6d126cebd3121ea2cff3586e7b95
Gitweb:        https://git.kernel.org/tip/23faa33d88df6d126cebd3121ea2cff3586=
e7b95
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 17 Dec 2025 13:23:59 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:09 +01:00

perf: Use EXPORT_SYMBOL_FOR_KVM() for the mediated APIs

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251208115156.GE3707891@noisy.programming.kic=
ks-ass.net
---
 arch/x86/events/core.c | 5 +++--
 kernel/events/core.c   | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

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

