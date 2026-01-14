Return-Path: <linux-tip-commits+bounces-7989-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 127EFD1E328
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F03C304790D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A8E394492;
	Wed, 14 Jan 2026 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kTK83/a6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bQfs4qRZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FCC393DF8;
	Wed, 14 Jan 2026 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387218; cv=none; b=QAOmkNfOUSa9W2NqddZGQMPEb4xb2r0DwXxmOXNy4hDQliMoD7h+njdh+43U9SeqmICGTwtaeWM0+VDoZFJ0h0pKOXa42elNO1NpC8OycnOBlzHngtF1rhwc5O5lY5/27EIol4WW6pO8SKdegNVJCJBaqYp0IJvPZcvRv0q80Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387218; c=relaxed/simple;
	bh=aGs4eSOsrUnapHkLKtcUnjdqpQGcbYEiUBjno1PyKqk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gYb0iZDPTpspRmBafxNdQEeAsSy0R18DvTn4pIMRObpxmAwWwygFUg37GaDqO2VfxvROdeYDehu7b5C0UTF7ZQQ5Nx+4lkNoEo0E+5a7IAFautGCEQkrJNd2d/mC2NZFCRbP6K571wnN6oLurw4SM+TC1/UD0Stf4Qx/ZKCf1TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kTK83/a6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bQfs4qRZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:40:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387212;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTn4nbYT9rxJaj934qNLyp9hd52peuylpfLnpfds+2M=;
	b=kTK83/a6TT8V2b0sqXe5PZwMpUupp1NYn61drl7vrM9FecbZj6W8kxZNgBPau/IWFv+ZAe
	7Wc1oe0TpJICPGeRJwWoS/aPyww8tvSUDz7XllGUOrdM90804GwUHg+MJqj09Ku5z8qUpn
	la0ti0cyHag4tA4iG8Wf0SNqshHzD+B+14RqDHnk/ui9rNbtsDBHwZ4S/6p+vaTDh2v/Sw
	xNZrrxCa389Z12MU2pNF+aMOxxFhd9KFFJdk78ljVi5uFuz4GExB1T9C/YkLjMTXwsiH0T
	JQ+3uV6I1Ob0J6zSz7OPAVP78Fy99sD8fTzM++JUHyDoHTjIi81HPhSnBgpNIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387212;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTn4nbYT9rxJaj934qNLyp9hd52peuylpfLnpfds+2M=;
	b=bQfs4qRZvxHrHzXku1hqnu0TQzGoDWomIrthK5d236wJztpSdjWSWmlb8mudAIpGF0B/nj
	oADmmXTh3hSH3tCA==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/paravirt] x86/paravirt: Use common code for paravirt_steal_clock()
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-12-jgross@suse.com>
References: <20260105110520.21356-12-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838721158.510.8626389043088172090.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     589f41f2f08bb48e041b513e49f9f61eec232d64
Gitweb:        https://git.kernel.org/tip/589f41f2f08bb48e041b513e49f9f61eec2=
32d64
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:10 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Jan 2026 16:48:26 +01:00

x86/paravirt: Use common code for paravirt_steal_clock()

Remove the arch-specific variant of paravirt_steal_clock() and use
the common one instead.

With all archs supporting Xen now having been switched to the common
variant, including paravirt.h can be dropped from drivers/xen/time.c.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260105110520.21356-12-jgross@suse.com
---
 arch/x86/Kconfig                | 1 +
 arch/x86/include/asm/paravirt.h | 7 -------
 arch/x86/kernel/paravirt.c      | 6 ------
 arch/x86/xen/time.c             | 1 +
 drivers/xen/time.c              | 3 ---
 5 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1f30358..62e1157 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -799,6 +799,7 @@ if HYPERVISOR_GUEST
 config PARAVIRT
 	bool "Enable paravirtualization code"
 	depends on HAVE_STATIC_CALL
+	select HAVE_PV_STEAL_CLOCK_GEN
 	help
 	  This changes the kernel so it can modify itself when it is run
 	  under a hypervisor, potentially improving performance significantly
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 0ef797e..766a7ce 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -17,10 +17,8 @@
 #include <linux/static_call_types.h>
 #include <asm/frame.h>
=20
-u64 dummy_steal_clock(int cpu);
 u64 dummy_sched_clock(void);
=20
-DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
 DECLARE_STATIC_CALL(pv_sched_clock, dummy_sched_clock);
=20
 void paravirt_set_sched_clock(u64 (*func)(void));
@@ -35,11 +33,6 @@ bool pv_is_native_spin_unlock(void);
 __visible bool __native_vcpu_is_preempted(long cpu);
 bool pv_is_native_vcpu_is_preempted(void);
=20
-static inline u64 paravirt_steal_clock(int cpu)
-{
-	return static_call(pv_steal_clock)(cpu);
-}
-
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 void __init paravirt_set_cap(void);
 #endif
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index a3ba474..42991d4 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -60,12 +60,6 @@ void __init native_pv_lock_init(void)
 		static_branch_enable(&virt_spin_lock_key);
 }
=20
-static u64 native_steal_clock(int cpu)
-{
-	return 0;
-}
-
-DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
 DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
=20
 void paravirt_set_sched_clock(u64 (*func)(void))
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 96521b1..e4754b2 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/pvclock_gtod.h>
 #include <linux/timekeeper_internal.h>
+#include <linux/sched/cputime.h>
=20
 #include <asm/pvclock.h>
 #include <asm/xen/hypervisor.h>
diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index 53b12f5..0b18d8a 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -10,9 +10,6 @@
 #include <linux/static_call.h>
 #include <linux/sched/cputime.h>
=20
-#ifndef CONFIG_HAVE_PV_STEAL_CLOCK_GEN
-#include <asm/paravirt.h>
-#endif
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
=20

