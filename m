Return-Path: <linux-tip-commits+bounces-8318-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOr/IlQNo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8318-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:44:20 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E523C1C4141
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7724B314F988
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5643847F2F8;
	Sat, 28 Feb 2026 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZA1QrqwM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g3PBD+Fb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7599E47F2C2;
	Sat, 28 Feb 2026 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293014; cv=none; b=XCAl3PetQs7DBUGswK0u/LqFnt4VYr2UuMzogNBBsxdBtYjp85ABVKPFsJJzAXVhtDa0NBnZj7HRCS9js+eaGiqsAQvq7IreB6FAXM4aUb5Ap/RMZiJltjrpEiZ3EH0K1rJs8lwtMOL53QAjoFNF1iP9SNv4EbSJW88AOdz8L5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293014; c=relaxed/simple;
	bh=Mr0lpZDcacS/ldmTDzJVIjXuiMnNeEhwrpwWTE8lv2s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m84G4iWQCfhBB2JkGSoHlFnnTx+HtIAGiSasc4gX1X6JfrecbMXrL23lfSCYTudBgCEF19W/n0Ga2npQ7kE2FXiSILSsTlKcqwnODQNaqJii2d5JMdyCnK6rRU8mfMp7W5UUOpnodY9C/k12HFnkoZiN0NWVttyBAoGa8zsa6A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZA1QrqwM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g3PBD+Fb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMuv0rZwpf2DNCZ87B3a7ufjG1/38ur9iXNalsJlFW4=;
	b=ZA1QrqwMpg5hQVQFOObrYs3+hYwj3t5Ytc2gAXNeQD4dm3EFu1rSfgjAOr0WBcMIsljV6J
	2MBB60gKuoTe7aGkR/nM9gwU4Xmev4gje8ERw9WSJ199Fi9IdbfigFGZEd6hKk6R00e/an
	tDBfiCwVCdsrAH2ePMfpYv5ymC86XrxEy13zNQL4X1nGzLV98fWtyj4L/F1tYuM4qoodPH
	LuaeYFK0vhNxpBViMinWZTcXgaAx9hMZGxXeqUogvRAfUdjbp66fB9Pz0Etqm2gkqLnOlN
	M9/xAPXu63jXlnyEnjdGLydx4K3Q1+E1ywQd0gZhfIOGwDtFChaDb6SUzOyEXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMuv0rZwpf2DNCZ87B3a7ufjG1/38ur9iXNalsJlFW4=;
	b=g3PBD+Fbx92esblGQOHomuiwZ4poF9Vp8puMm9vCUtf1lNJ6lZEDu3ehQ9swSQWxMUDof8
	Y+bbkGwZ4aAmVGBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] x86/apic: Avoid the PVOPS indirection for the TSC
 deadline timer
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163429.877429827@kernel.org>
References: <20260224163429.877429827@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229300650.1647592.11420568589261852657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8318-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: E523C1C4141
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     23028286128d817a414eee0c0a2c6cdc57a83e6f
Gitweb:        https://git.kernel.org/tip/23028286128d817a414eee0c0a2c6cdc57a=
83e6f
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:36:34 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:08 +01:00

x86/apic: Avoid the PVOPS indirection for the TSC deadline timer

XEN PV does not emulate the TSC deadline timer, so the PVOPS indirection
for writing the deadline MSR can be avoided completely.

Use native_wrmsrq() instead.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163429.877429827@kernel.org
---
 arch/x86/kernel/apic/apic.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 18208be..5bb5b39 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -426,7 +426,7 @@ static int lapic_next_deadline(unsigned long delta, struc=
t clock_event_device *e
 	 */
 	u64 tsc =3D rdtsc();
=20
-	wrmsrq(MSR_IA32_TSC_DEADLINE, tsc + (((u64) delta) * TSC_DIVISOR));
+	native_wrmsrq(MSR_IA32_TSC_DEADLINE, tsc + (((u64) delta) * TSC_DIVISOR));
 	return 0;
 }
=20
@@ -450,7 +450,7 @@ static int lapic_timer_shutdown(struct clock_event_device=
 *evt)
 	 * the timer _and_ zero the counter registers:
 	 */
 	if (v & APIC_LVT_TIMER_TSCDEADLINE)
-		wrmsrq(MSR_IA32_TSC_DEADLINE, 0);
+		native_wrmsrq(MSR_IA32_TSC_DEADLINE, 0);
 	else
 		apic_write(APIC_TMICT, 0);
=20
@@ -547,6 +547,11 @@ static __init bool apic_validate_deadline_timer(void)
=20
 	if (!boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER))
 		return false;
+
+	/* XEN_PV does not support it, but be paranoia about it */
+	if (boot_cpu_has(X86_FEATURE_XENPV))
+		goto clear;
+
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return true;
=20
@@ -559,9 +564,11 @@ static __init bool apic_validate_deadline_timer(void)
 	if (boot_cpu_data.microcode >=3D rev)
 		return true;
=20
-	setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 	pr_err(FW_BUG "TSC_DEADLINE disabled due to Errata; "
 	       "please update microcode to version: 0x%x (or later)\n", rev);
+
+clear:
+	setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 	return false;
 }
=20

