Return-Path: <linux-tip-commits+bounces-8293-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CJXAv4Lo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8293-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:38:38 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 622291C407C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77C153146ABC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D2E47CC62;
	Sat, 28 Feb 2026 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cNfZwJRm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S2T2zq1u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC4F47D924;
	Sat, 28 Feb 2026 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292982; cv=none; b=Hh4BPBbMe/0zdN3aj5tHkyAlaDMmBbviOumdkRccgTpXaynVZCic5aVBpGk3VauJiXOCSHOWTnApG9ycy8VBsAD5IKhh58wcE+m8EVPbJlvPGmHL6gyYE5TYcVCArzo3KV2WRvg+VFOIimf8GUjK6BCPsYRh4cXETqJzz2Fut7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292982; c=relaxed/simple;
	bh=wI6uis0nxSG3KYaMIPJG3eu2T2OBMajO3EBM4BwPCvg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mu3+jmgwT9hBFBkqPWMRqtUQpKGh/WbiPIPHO+uJEl+dxPMiH46f5wMYEOIxeBL+fa2Fws2EPj1iUjNA66RlS8KXmkWjZNehWJwI0WvFExMfpKguGSrYNoptMF93QFnpqedHmMm5MuwbwFMoJDfduN8hxrlaK3l4QaZ47D8fCu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cNfZwJRm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S2T2zq1u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292979;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2QIzvgNmWekuQXwpXbtmOBthiVvkq3EUYOwRT0dcX0=;
	b=cNfZwJRmYqK5ugBfdUrsyHvwq5ZW19YglPnL3Z8oREs14eTkQIlOd2gRSkKjvzvuRjGNW2
	sj9kWZWQG+j3s55HPxGz+REHtBd/2Mv6u940KeVaDzfdCFuF8Gr5+GQiQM2rzuNqoN6V3A
	/sJBNhdZpMuHiCKODD2QbTdDrL3PSoVUj6ARb2zzUS8jR4pzq6QWG4xTFp+EVtPP6/rmOR
	hav8+VBCkMi9kxNGv4HsugFemlVUFWe9lSHGqaCv+0HW/3+PqEvkKKgKaOfSUDEO0hM9lj
	l8zsk2sia0g2GF9cv41LfI1RrrDemUdSbIQOAkGQYuckEL8dYNUshpjeM1czRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292979;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2QIzvgNmWekuQXwpXbtmOBthiVvkq3EUYOwRT0dcX0=;
	b=S2T2zq1u7nrrOR2YbXe3QckWQXYZbNe/1ZJwVEpFMoXMtxUF3jDKSpLBrcVQt7j8JNLQDp
	gN+oE3nY+JSMfcDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Simplify run_hrtimer_queues()
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163431.532927977@kernel.org>
References: <20260224163431.532927977@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229297854.1647592.9990802234060463418.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8293-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 622291C407C
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     a64ad57e41c7e3daadbc2c1bc252d9a90c87222f
Gitweb:        https://git.kernel.org/tip/a64ad57e41c7e3daadbc2c1bc252d9a90c8=
7222f
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:38:37 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:15 +01:00

hrtimer: Simplify run_hrtimer_queues()

Replace the open coded container_of() orgy with a trivial
clock_base_next_timer() helper.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163431.532927977@kernel.org
---
 kernel/time/hrtimer.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index aa1cb4f..b0e7e29 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1933,6 +1933,13 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu=
_base, struct hrtimer_cloc
 	base->running =3D NULL;
 }
=20
+static __always_inline struct hrtimer *clock_base_next_timer_safe(struct hrt=
imer_clock_base *base)
+{
+	struct timerqueue_node *next =3D timerqueue_getnext(&base->active);
+
+	return next ? container_of(next, struct hrtimer, node) : NULL;
+}
+
 static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t =
now,
 				 unsigned long flags, unsigned int active_mask)
 {
@@ -1940,16 +1947,10 @@ static void __hrtimer_run_queues(struct hrtimer_cpu_b=
ase *cpu_base, ktime_t now,
 	struct hrtimer_clock_base *base;
=20
 	for_each_active_base(base, cpu_base, active) {
-		struct timerqueue_node *node;
-		ktime_t basenow;
-
-		basenow =3D ktime_add(now, base->offset);
-
-		while ((node =3D timerqueue_getnext(&base->active))) {
-			struct hrtimer *timer;
-
-			timer =3D container_of(node, struct hrtimer, node);
+		ktime_t basenow =3D ktime_add(now, base->offset);
+		struct hrtimer *timer;
=20
+		while ((timer =3D clock_base_next_timer(base))) {
 			/*
 			 * The immediate goal for using the softexpires is
 			 * minimizing wakeups, not running timers at the

