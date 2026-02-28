Return-Path: <linux-tip-commits+bounces-8329-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMFXIAURo2kf9gQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8329-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 17:00:05 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B8B1C4318
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 17:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 064E03070DCB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89840481A9E;
	Sat, 28 Feb 2026 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bENjfcTc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zy0NMiZV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F096248123C;
	Sat, 28 Feb 2026 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293028; cv=none; b=DbNAM3Gst4OGY04EHeoWpxvCtKvyf6z4tNTgaAAfEk6tnXUXqPtvwjlPzYdlRFzzKovem0iZuzKarcBR1xtn2rXwjd14fmHvRvKI0bcvbQ1I3QjI/K8COHn7voNE3pIHrevxVDN6STy80btO1sM1ZIm7K83DqIlxcaOMgJUiBo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293028; c=relaxed/simple;
	bh=dyo7Ictp9aQ4U/6VnBPw8rqs71KsLGbG/iV5WBpScp8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VA54v+1d96scfuGZOtd8SPPr6o+2libLjGn0Up0eZTQ4WmsK/960L1utxMezYuASZTAZIAAMDIq9BanqmKImNOynKpS+g4j/FLtvWXL+pK0wofnlJNiN16ijmMcCu9/ImAS6iEaf/KwkJcLPFPSLt0Tog+hcRs/3DUTGr4pQXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bENjfcTc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zy0NMiZV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293020;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MpDD/+/RKkvKsUrszxgFtHqYfBvEjeGG2w4/znaSDOM=;
	b=bENjfcTcVtiPfCqXqqBk3t5V4xsGN4zQnw54eI3BytEQwB9Bln8SCe9KZKWCLjJVbFeBz0
	f/ywRKxV3JC+u0s2WVs3+SbTQEKCRCRNN5tF4p9MIpe3K1bQbBflCASzAEmxUfNK0MxoRo
	TIqyn0d98Qf9D4mwKIYa42BJ0HmPqw4Hnj7Mjp0V+BP983cv02YP5y7yaX1qNmp+y2RXWz
	YHtZqOS1TpK3BoGyMuj9tyv6tDC6SjEzLxfqSRf3O9mYqWkCcXQqq5MLfpLPXcWXobAjf0
	u2jTc4JAFi9D+i3OlFyeaTa7zsF0aa6tT+h+ZozswBHLEHMutfmutU6V4eSPuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293020;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MpDD/+/RKkvKsUrszxgFtHqYfBvEjeGG2w4/znaSDOM=;
	b=zy0NMiZVhO2otnwZvgmm0BY/TvTRyQa1jjiFx3uvRk0x7BVqoBZ4HeAOQwyavs8QNCiB3H
	6UL2WnBGNl9SzYAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Avoid pointless reprogramming in
 __hrtimer_start_range_ns()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260224163429.069535561@kernel.org>
References: <20260224163429.069535561@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229301912.1647592.5477764775060482953.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8329-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:replyto,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: C8B8B1C4318
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     d19ff16c11db38f3ee179d72751fb9b340174330
Gitweb:        https://git.kernel.org/tip/d19ff16c11db38f3ee179d72751fb9b3401=
74330
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 24 Feb 2026 17:35:37 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:04 +01:00

hrtimer: Avoid pointless reprogramming in __hrtimer_start_range_ns()

Much like hrtimer_reprogram(), skip programming if the cpu_base is running
the hrtimer interrupt.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260224163429.069535561@kernel.org
---
 kernel/time/hrtimer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 860af7a..3088db4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1269,6 +1269,14 @@ static int __hrtimer_start_range_ns(struct hrtimer *ti=
mer, ktime_t tim,
 	}
=20
 	first =3D enqueue_hrtimer(timer, new_base, mode);
+
+	/*
+	 * If the hrtimer interrupt is running, then it will reevaluate the
+	 * clock bases and reprogram the clock event device.
+	 */
+	if (new_base->cpu_base->in_hrtirq)
+		return false;
+
 	if (!force_local) {
 		/*
 		 * If the current CPU base is online, then the timer is

