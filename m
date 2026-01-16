Return-Path: <linux-tip-commits+bounces-8036-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F25D38844
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Jan 2026 22:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48A803083C64
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Jan 2026 21:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA1A3081BD;
	Fri, 16 Jan 2026 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FDUDe1/x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CfwEmgsM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA422FB09A;
	Fri, 16 Jan 2026 21:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598525; cv=none; b=W7v4jmW7mhmD6PKnfHlQXmJV+wrq2fht2vvOEKA1Sjw7smgx2VXhOT5byanFIgSND0XfmRtPzx3Hyn5TUz67OrA2lkSE1EbpNibDorWAvX57GrzjSPt9yhKrmUQMLIyJjYrVYPk9D8K+OOyWXYy0DnxQgLlW65CcT7YY1KiqaAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598525; c=relaxed/simple;
	bh=A5AJHEdtJIrDlhT/Ty0gyT0kiCO9Yc6mB5bIkHDx7Wc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bU2HBL8Krs5DkkOtD1kefIyr+ccn6JOFfz7FBVoBMclJEn6mF576ODnrfiYfGKEteoxLcDly36gN9nJs4eB2E68Z/NIN5ayHTTtbpPVuo+z5V9N9KyENK8sFDTR/FPnrj3rGL/q/SCHqBEV2fM77swE0oGJhayZ7yB6BL9qTieQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FDUDe1/x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CfwEmgsM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Jan 2026 21:22:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768598522;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6naSeJkPF68828IGAOh99v+fdCKPPPYxBArrL3t96AY=;
	b=FDUDe1/xEIS3/klECMAZxUTM7dJnyCKNDDRDuhMtbEva1LtA05Kb4D3cQKt5dZ+C84dSVs
	fteW7uOjXjzkg6ezggK6y9PiTZCZ6Ik/WlbXDuYUxjiIQsFH3AV9jPzLxTA/NvewX7sVYo
	ZYGDbLC9PxmLawDE5VNFyjS1K64JgJ0fLhN8SOSLcJsrGo6DrVFwHfQgmoNBfWuj4y5RJ+
	CrQc4I6Zd2kjKK41U7L3GY5B7veoIKfV1PgL2SZQeRIfqPemp+usm3uk+WwddTJiEZWbbp
	NlDL8vCm2LgkETMiDFjAdp/YgharBa8+1qKc+mp273f4y7EihfH58LEz4dSKMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768598522;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6naSeJkPF68828IGAOh99v+fdCKPPPYxBArrL3t96AY=;
	b=CfwEmgsMUs7tDbD2xvszkHQQDXH+kJnpUMs47MauA5UcelYWmNQBFlAyl7VNfTuJcAzdKC
	mbfs7vJo5d2Rw+Cw==
From: "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/smp: Use static_call for
 arch_send_call_function_single_ipi()
Cc: Eric Dumazet <edumazet@google.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251222201406.3725665-2-edumazet@google.com>
References: <20251222201406.3725665-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176859852127.510.14673879450025915501.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     7c76769ce0d985597c189ff9a6194e3151396ee7
Gitweb:        https://git.kernel.org/tip/7c76769ce0d985597c189ff9a6194e31513=
96ee7
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Mon, 22 Dec 2025 20:14:04=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Jan 2026 20:26:52 +01:00

x86/smp: Use static_call for arch_send_call_function_single_ipi()

Use static_call to avoid an indirect call, especially expensive
with retpoline.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251222201406.3725665-2-edumazet@google.com
---
 arch/x86/include/asm/smp.h | 10 ++++++++--
 arch/x86/kernel/smp.c      | 10 ++++++++++
 arch/x86/xen/smp_hvm.c     |  1 +
 arch/x86/xen/smp_pv.c      |  1 +
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 8495157..891a5d1 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -4,6 +4,7 @@
 #ifndef __ASSEMBLER__
 #include <linux/cpumask.h>
 #include <linux/thread_info.h>
+#include <linux/static_call_types.h>
=20
 #include <asm/cpumask.h>
=20
@@ -42,6 +43,12 @@ struct smp_ops {
 	void (*send_call_func_single_ipi)(int cpu);
 };
=20
+void x86_smp_ops_static_call_update(void);
+
+void native_send_call_func_single_ipi(int cpu);
+DECLARE_STATIC_CALL(x86_send_call_func_single_ipi,
+		    native_send_call_func_single_ipi);
+
 /* Globals due to paravirt */
 extern void set_cpu_sibling_map(int cpu);
=20
@@ -92,7 +99,7 @@ static inline void arch_smp_send_reschedule(int cpu)
=20
 static inline void arch_send_call_function_single_ipi(int cpu)
 {
-	smp_ops.send_call_func_single_ipi(cpu);
+	static_call(x86_send_call_func_single_ipi)(cpu);
 }
=20
 static inline void arch_send_call_function_ipi_mask(const struct cpumask *ma=
sk)
@@ -122,7 +129,6 @@ void __noreturn mwait_play_dead(unsigned int eax_hint);
=20
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
-void native_send_call_func_single_ipi(int cpu);
=20
 asmlinkage __visible void smp_reboot_interrupt(void);
 __visible void smp_reschedule_interrupt(struct pt_regs *regs);
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index b014e6d..2c8fdf1 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -300,6 +300,16 @@ struct smp_ops smp_ops =3D {
 };
 EXPORT_SYMBOL_GPL(smp_ops);
=20
+DEFINE_STATIC_CALL(x86_send_call_func_single_ipi,
+		   native_send_call_func_single_ipi);
+
+void x86_smp_ops_static_call_update(void)
+{
+	static_call_update(x86_send_call_func_single_ipi,
+			   smp_ops.send_call_func_single_ipi);
+}
+EXPORT_SYMBOL_GPL(x86_smp_ops_static_call_update);
+
 int arch_cpu_rescan_dead_smt_siblings(void)
 {
 	enum cpuhp_smt_control old =3D cpu_smt_control;
diff --git a/arch/x86/xen/smp_hvm.c b/arch/x86/xen/smp_hvm.c
index 485c1d8..5ea0f53 100644
--- a/arch/x86/xen/smp_hvm.c
+++ b/arch/x86/xen/smp_hvm.c
@@ -85,4 +85,5 @@ void __init xen_hvm_smp_init(void)
 	smp_ops.smp_send_reschedule =3D xen_smp_send_reschedule;
 	smp_ops.send_call_func_ipi =3D xen_smp_send_call_function_ipi;
 	smp_ops.send_call_func_single_ipi =3D xen_smp_send_call_function_single_ipi;
+	x86_smp_ops_static_call_update();
 }
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 9bb8ff8..91f9d68 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -442,6 +442,7 @@ static const struct smp_ops xen_smp_ops __initconst =3D {
 void __init xen_smp_init(void)
 {
 	smp_ops =3D xen_smp_ops;
+	x86_smp_ops_static_call_update();
=20
 	/* Avoid searching for BIOS MP tables */
 	x86_init.mpparse.find_mptable		=3D x86_init_noop;

