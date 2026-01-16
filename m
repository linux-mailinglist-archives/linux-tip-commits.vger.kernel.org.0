Return-Path: <linux-tip-commits+bounces-8035-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22460D38842
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Jan 2026 22:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E12A30695D0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Jan 2026 21:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F333930594F;
	Fri, 16 Jan 2026 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kbP9vcXV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bwiT52Qy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B103F2D6E6C;
	Fri, 16 Jan 2026 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598524; cv=none; b=LZAnmJ3QRTVcGBhJ9hohL2Sx7pdesEoi95C9YAgSkjTXIbHvo1FDzqsw2A2jCKYxqpLtqJw3EZ8fwyWjyur9vkT2hj97+VXLfp6LM6tZdHvJW06eZpH0NavV2E7kYYAa9slo414Fk0H55P4g5eCTxbIsbkOlBqs/s7H3CELgw7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598524; c=relaxed/simple;
	bh=9FM4wzU5p4TqNz+Z4XnOK5KuwWIk+HjQ3fzLNXUgBOQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gSZMwj2/V8yU4UNoCBpBsgrIfiAYx5uhtrdrCINDVl2bD4Og6TqZf8WuXOcw/j65FQ8RvmM9EJVbSEkvqNcjwhciLjDHSIWWG2mM4DczySdwE3GBzzlTYNIHL2cXayEf1z+I0RDvGzef5wRvQxXBEDOoRoK62+/QzD7mqc7EiNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kbP9vcXV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bwiT52Qy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Jan 2026 21:22:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768598521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3wk6NC1iLjpwj1TJDhhf93tvpJcaRaN1PA5W+ljkFs=;
	b=kbP9vcXVYUPQZoBj4IYBW6/yswvqInv7Gq+TXtmxUM1fEWg4u4KA9Jx3ZWNYqHYNHwEeYa
	sHeZK50gi+BTHFM6OC7AXCpu6dnrPLRQP2TRQA+KtGl/fJax0zX63PZQUfpT96GUCXZkI/
	YJA6/GiHOUTV+Po/MAxWgw9DugECvXaTweaG0eD8wXgr2yT3RN1uYkvFRWyQnsHYkK7O+u
	DpE7fzcstQXdoDQtHeiXD1mKpSNIKOfySlXhH0HBYehjwfo6I2xsnjhtt7OowSBPiw+sC3
	uT844X9HHYU/1UFt9VFEFdSc8StUAARSF7cLiYqXw5NCDspH9uK1c3IIY+9uag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768598521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3wk6NC1iLjpwj1TJDhhf93tvpJcaRaN1PA5W+ljkFs=;
	b=bwiT52QyBAf307y75GChiIWJk/wXuv1gPLSdf2ULz4e9hVlcUk4z2BQIDkjArggTJ6XsYQ
	5wOEjdYTDYOwyyDg==
From: "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/smp: Use static_call for arch_smp_send_reschedule()
Cc: Eric Dumazet <edumazet@google.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251222201406.3725665-3-edumazet@google.com>
References: <20251222201406.3725665-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176859852017.510.2868283334488670420.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     83408307cf374038c5df199dde2e3fc11b3e27c2
Gitweb:        https://git.kernel.org/tip/83408307cf374038c5df199dde2e3fc11b3=
e27c2
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Mon, 22 Dec 2025 20:14:05=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Jan 2026 20:52:41 +01:00

x86/smp: Use static_call for arch_smp_send_reschedule()

Use static_call to avoid an indirect call, especially expensive
with retpoline.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251222201406.3725665-3-edumazet@google.com
---
 arch/x86/include/asm/smp.h | 7 +++++--
 arch/x86/kernel/smp.c      | 5 +++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 891a5d1..3b3ff77 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -49,6 +49,10 @@ void native_send_call_func_single_ipi(int cpu);
 DECLARE_STATIC_CALL(x86_send_call_func_single_ipi,
 		    native_send_call_func_single_ipi);
=20
+void native_smp_send_reschedule(int cpu);
+DECLARE_STATIC_CALL(x86_smp_send_reschedule,
+		    native_smp_send_reschedule);
+
 /* Globals due to paravirt */
 extern void set_cpu_sibling_map(int cpu);
=20
@@ -94,7 +98,7 @@ static inline void __noreturn play_dead(void)
=20
 static inline void arch_smp_send_reschedule(int cpu)
 {
-	smp_ops.smp_send_reschedule(cpu);
+	static_call(x86_smp_send_reschedule)(cpu);
 }
=20
 static inline void arch_send_call_function_single_ipi(int cpu)
@@ -127,7 +131,6 @@ void wbnoinvd_on_cpus_mask(struct cpumask *cpus);
 void smp_kick_mwait_play_dead(void);
 void __noreturn mwait_play_dead(unsigned int eax_hint);
=20
-void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
=20
 asmlinkage __visible void smp_reboot_interrupt(void);
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 2c8fdf1..6e25a86 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -302,11 +302,16 @@ EXPORT_SYMBOL_GPL(smp_ops);
=20
 DEFINE_STATIC_CALL(x86_send_call_func_single_ipi,
 		   native_send_call_func_single_ipi);
+DEFINE_STATIC_CALL(x86_smp_send_reschedule,
+		   native_smp_send_reschedule);
+EXPORT_STATIC_CALL(x86_smp_send_reschedule);
=20
 void x86_smp_ops_static_call_update(void)
 {
 	static_call_update(x86_send_call_func_single_ipi,
 			   smp_ops.send_call_func_single_ipi);
+	static_call_update(x86_smp_send_reschedule,
+			   smp_ops.smp_send_reschedule);
 }
 EXPORT_SYMBOL_GPL(x86_smp_ops_static_call_update);
=20

