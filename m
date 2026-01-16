Return-Path: <linux-tip-commits+bounces-8034-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F30A7D38840
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Jan 2026 22:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 809033057442
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Jan 2026 21:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2830B2FE07D;
	Fri, 16 Jan 2026 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gOFwIEsb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vz9mHSG2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FCD28C009;
	Fri, 16 Jan 2026 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598524; cv=none; b=tXkiJhSUKOJqH2tcKNEEVUnM4fjn2V0pv14f9StAGrHGfcH7RU8JBeHAcQytoouy+fo25y2lwIXt9ir35dEvBYkhCRqVMjlXEzK8Mak91QhrNhi4RnQG+kb/4CdkIJk8+ONXqu7PfqvnHn1l4tS+Darg0OMu83u2VQL/5ayf2q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598524; c=relaxed/simple;
	bh=LjSMjwrMR+U5HGSP2fe055042ArOhgvAnJ9cLI9fqcc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eIB+PhuoYOQ7gTfBVl4vK0LtBULdG4BvbuX1k4SRxogLtqN9eXfAr6RdIdl/m8QSxkr9tpqBRNaDkyIeOCRpkPZZm+IwHMgICoxep74lhKdGPA7odJLDS2f8y3Guh4jS9mbLEXnRRs5AQrN7Ik9McXJII47qCMrWfu8+nhk4AjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gOFwIEsb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vz9mHSG2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Jan 2026 21:21:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768598520;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0FF3jQw4B7O+LAqhD9gVxcNLC4aqDFEme/r+rODHbA=;
	b=gOFwIEsb33yEKKzkh1tDKb3pqqkJo1yVWlrV2OJPEl4CHbFy8dScfjDkDFu4IF9F35gzut
	9WZHdqI1duHZKlLnNUmEWK6YNvABccYQJkAZTTiN/lsV2PeGJe9UqvO3hh7l8P9PdL49BT
	UAXjd4poWDYYeSfkk1dsm0AqaurzIMDp66p2OuKjLyy8WCuBrNyXzJNo3ANoq5QoTUZTYk
	p2M7LKSurQLo9hZoIEQlDIvM4nuJkiIm7Eg+Y44COxpGben9BeH/jbgCWqem19IsHiil3X
	V7+bD0j2bnStEDc3wmXPFTS4XzwaSIW+BscEAs+BS104u4qUoLaM45PI5g4qDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768598520;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0FF3jQw4B7O+LAqhD9gVxcNLC4aqDFEme/r+rODHbA=;
	b=vz9mHSG2o+pI8mzbkUZjC424gUSb3IKBITYzkD8kXfvQbtjA13ph8xFmTUc4ABTyS5NhgZ
	fOk0WfYiNgwLD+AQ==
From: "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/smp: Use static_call for arch_send_call_function_ipi()
Cc: Eric Dumazet <edumazet@google.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251222201406.3725665-4-edumazet@google.com>
References: <20251222201406.3725665-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176859851861.510.3781533884828804968.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     1f60230cdc6342d37e7a9eec261ac3c392131688
Gitweb:        https://git.kernel.org/tip/1f60230cdc6342d37e7a9eec261ac3c3921=
31688
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Mon, 22 Dec 2025 20:14:06=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Jan 2026 21:32:57 +01:00

x86/smp: Use static_call for arch_send_call_function_ipi()

Use static_call to avoid an indirect call, especially expensive
with retpoline.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251222201406.3725665-4-edumazet@google.com
---
 arch/x86/include/asm/smp.h | 6 ++++--
 arch/x86/kernel/smp.c      | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 3b3ff77..f7305c4 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -49,6 +49,9 @@ void native_send_call_func_single_ipi(int cpu);
 DECLARE_STATIC_CALL(x86_send_call_func_single_ipi,
 		    native_send_call_func_single_ipi);
=20
+void native_send_call_func_ipi(const struct cpumask *mask);
+DECLARE_STATIC_CALL(x86_send_call_func_ipi, native_send_call_func_ipi);
+
 void native_smp_send_reschedule(int cpu);
 DECLARE_STATIC_CALL(x86_smp_send_reschedule,
 		    native_smp_send_reschedule);
@@ -108,7 +111,7 @@ static inline void arch_send_call_function_single_ipi(int=
 cpu)
=20
 static inline void arch_send_call_function_ipi_mask(const struct cpumask *ma=
sk)
 {
-	smp_ops.send_call_func_ipi(mask);
+	static_call(x86_send_call_func_ipi)(mask);
 }
=20
 void cpu_disable_common(void);
@@ -131,7 +134,6 @@ void wbnoinvd_on_cpus_mask(struct cpumask *cpus);
 void smp_kick_mwait_play_dead(void);
 void __noreturn mwait_play_dead(unsigned int eax_hint);
=20
-void native_send_call_func_ipi(const struct cpumask *mask);
=20
 asmlinkage __visible void smp_reboot_interrupt(void);
 __visible void smp_reschedule_interrupt(struct pt_regs *regs);
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 6e25a86..4633ade 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -302,6 +302,8 @@ EXPORT_SYMBOL_GPL(smp_ops);
=20
 DEFINE_STATIC_CALL(x86_send_call_func_single_ipi,
 		   native_send_call_func_single_ipi);
+DEFINE_STATIC_CALL(x86_send_call_func_ipi,
+		   native_send_call_func_ipi);
 DEFINE_STATIC_CALL(x86_smp_send_reschedule,
 		   native_smp_send_reschedule);
 EXPORT_STATIC_CALL(x86_smp_send_reschedule);
@@ -310,6 +312,8 @@ void x86_smp_ops_static_call_update(void)
 {
 	static_call_update(x86_send_call_func_single_ipi,
 			   smp_ops.send_call_func_single_ipi);
+	static_call_update(x86_send_call_func_ipi,
+			   smp_ops.send_call_func_ipi);
 	static_call_update(x86_smp_send_reschedule,
 			   smp_ops.smp_send_reschedule);
 }

