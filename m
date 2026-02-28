Return-Path: <linux-tip-commits+bounces-8314-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JwnCUIOo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8314-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:48:18 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 435EB1C41E5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 785F330A3A64
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AB448033D;
	Sat, 28 Feb 2026 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OMd3Xjyj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/VWfdx4J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103047F2D4;
	Sat, 28 Feb 2026 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293009; cv=none; b=fhDHWTi6uwargkC60Kb4oO3+kJmGtiWXJhvXJ/O8YnodKp+vG0Y6MnaOyaD1T9+K3nAILcbRIPn5a0MQQm6v+angQS/jqaJdA255lXqHarLvVERy1URViWnlaTAAdS8tmZj/iomO7rLDn+gT3UbJ8g4xGDt7bL/r6gkzw4ARtpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293009; c=relaxed/simple;
	bh=xe860AWNdeBMEdc52Bfj/KHGVQzM/3jYnPvr/7Nbdas=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W1TTaZ2aFodUP2cN49zUUyIX1IB1z0iENKgP7wULQQt3t154JLGXQYd1sL97DrHdnQuovLxwJ1fmZOJ2wusYJYwDamFyzUpY9aQ45F7oYsvSZB0ubGhkewtqhQ30N3O9unPMkPcACgvRsYsqVUlx1hr9MGP2OoNZxB9u8tBeE7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OMd3Xjyj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/VWfdx4J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293004;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3S5IFvtSKiEzf13XgAPysjOPZk/0jjQ3Bn33IeUo92s=;
	b=OMd3XjyjZEyJTKPjBITUvQmXa2srfOhdvAzVBmTdjBIBVrqERMwWi4B0LiB8dDRCsokCx/
	QL+Omd9NccmlmOLk+VMg7Pblgy6k+L4s0whHeDIgYcZyJaW7UZxSP20BGfRz7kgDE39MM8
	FXtehMmMkEbxBWJGU/Mh9K+Il7SxRwXUKcw3UB91J9NYhqOcKmtNh8MwJfRKQmf6PJpLjI
	ok8GaXzHdMfXOn77dJLkB/O2sAsnd1uPo4msSu4hH46QbjbuhPyaLqukvvslSFq6hjMTqe
	Z3bIXCBNylv9lTwsli6XnPOVvPNrXLgdaaYN7bx3z07gI0TX6JUMQki0HltNaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293004;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3S5IFvtSKiEzf13XgAPysjOPZk/0jjQ3Bn33IeUo92s=;
	b=/VWfdx4JCHEFGWHbBH73sjPuBOf1vLsaKk70xgvYsK/7wbj+6NZ94BQNp22ECom4JfrBd7
	reIy8C1jU0BnN4DA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] x86/apic: Enable TSC coupled programming mode
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163430.076565985@kernel.org>
References: <20260224163430.076565985@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229300292.1647592.16500235275459715268.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8314-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:dkim,infradead.org:email,msgid.link:url,vger.kernel.org:replyto];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 435EB1C41E5
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     f246ec3478cfdab830ee0815209f48923e7ee5e2
Gitweb:        https://git.kernel.org/tip/f246ec3478cfdab830ee0815209f48923e7=
ee5e2
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:36:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:09 +01:00

x86/apic: Enable TSC coupled programming mode

The TSC deadline timer is directly coupled to the TSC and setting the next
deadline is tedious as the clockevents core code converts the
CLOCK_MONOTONIC based absolute expiry time to a relative expiry by reading
the current time from the TSC. It converts that delta to cycles and hands
the result to lapic_next_deadline(), which then has read to the TSC and add
the delta to program the timer.

The core code now supports coupled clock event devices and can provide the
expiry time in TSC cycles directly without reading the TSC at all.

This obviouly works only when the TSC is the current clocksource, but
that's the default for all modern CPUs which implement the TSC deadline
timer. If the TSC is not the current clocksource (e.g. early boot) then the
core code falls back to the relative set_next_event() callback as before.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163430.076565985@kernel.org
---
 arch/x86/Kconfig                     |  1 +
 arch/x86/include/asm/clock_inlined.h |  8 ++++++++
 arch/x86/kernel/apic/apic.c          | 12 ++++++------
 arch/x86/kernel/tsc.c                |  3 ++-
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d337d8d..560d2ce 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -164,6 +164,7 @@ config X86
 	select EDAC_SUPPORT
 	select GENERIC_CLOCKEVENTS_BROADCAST	if X86_64 || (X86_32 && X86_LOCAL_APIC)
 	select GENERIC_CLOCKEVENTS_BROADCAST_IDLE	if GENERIC_CLOCKEVENTS_BROADCAST
+	select GENERIC_CLOCKEVENTS_COUPLED_INLINE	if X86_64
 	select GENERIC_CLOCKEVENTS_MIN_ADJUST
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
diff --git a/arch/x86/include/asm/clock_inlined.h b/arch/x86/include/asm/cloc=
k_inlined.h
index 29902c5..b2dee8d 100644
--- a/arch/x86/include/asm/clock_inlined.h
+++ b/arch/x86/include/asm/clock_inlined.h
@@ -11,4 +11,12 @@ static __always_inline u64 arch_inlined_clocksource_read(s=
truct clocksource *cs)
 	return (u64)rdtsc_ordered();
 }
=20
+struct clock_event_device;
+
+static __always_inline void
+arch_inlined_clockevent_set_next_coupled(u64 cycles, struct clock_event_devi=
ce *evt)
+{
+	native_wrmsrq(MSR_IA32_TSC_DEADLINE, cycles);
+}
+
 #endif
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 5bb5b39..60cab20 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -591,14 +591,14 @@ static void setup_APIC_timer(void)
=20
 	if (this_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER)) {
 		levt->name =3D "lapic-deadline";
-		levt->features &=3D ~(CLOCK_EVT_FEAT_PERIODIC |
-				    CLOCK_EVT_FEAT_DUMMY);
+		levt->features &=3D ~(CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_DUMMY);
+		levt->features |=3D CLOCK_EVT_FEAT_CLOCKSOURCE_COUPLED;
+		levt->cs_id =3D CSID_X86_TSC;
 		levt->set_next_event =3D lapic_next_deadline;
-		clockevents_config_and_register(levt,
-						tsc_khz * (1000 / TSC_DIVISOR),
-						0xF, ~0UL);
-	} else
+		clockevents_config_and_register(levt, tsc_khz * (1000 / TSC_DIVISOR), 0xF,=
 ~0UL);
+	} else {
 		clockevents_register_device(levt);
+	}
=20
 	apic_update_vector(smp_processor_id(), LOCAL_TIMER_VECTOR, true);
 }
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 74a26fb..f31046f 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1203,7 +1203,8 @@ static struct clocksource clocksource_tsc =3D {
 				  CLOCK_SOURCE_VALID_FOR_HRES |
 				  CLOCK_SOURCE_CAN_INLINE_READ |
 				  CLOCK_SOURCE_MUST_VERIFY |
-				  CLOCK_SOURCE_VERIFY_PERCPU,
+				  CLOCK_SOURCE_VERIFY_PERCPU |
+				  CLOCK_SOURCE_HAS_COUPLED_CLOCK_EVENT,
 	.id			=3D CSID_X86_TSC,
 	.vdso_clock_mode	=3D VDSO_CLOCKMODE_TSC,
 	.enable			=3D tsc_cs_enable,

