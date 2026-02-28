Return-Path: <linux-tip-commits+bounces-8323-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIvXOBgPo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8323-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:51:52 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A671C4292
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 013AF300E196
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A64F48122D;
	Sat, 28 Feb 2026 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yRHdqpUq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vUE75i9K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B55648095A;
	Sat, 28 Feb 2026 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293020; cv=none; b=YZOutdJW8HfryaHQ1HKjJ3e1tmAAvZsCAAL1yVhqa9LWeJ/MIJOBM/4pIwfJhYICzdJ8qSW/U86VqHg8N7qOniBDqugrvqwYXyYAE4VLSdOCYlIsL9hKjDF16QKm7rTfgHrluwybuUer6wNSXe5ooYng8gcmOtI+nwMQXeRsy7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293020; c=relaxed/simple;
	bh=Jl40wH0NuxUrg2b3gSTqQOYrcOsk8Wn9S/Lir2cbPtc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dtiinWBxyqlMpDBSlBSvdb68NVwRGODbS3eqaYfoBCCaMJh2kR9a+ZDt9XG2iGUQlazsNItr6LcR3d2ArdDVHF2gS0xaObKslYv72cF58ow2f+RJjlY65jE8VvdW9rhQ/+ZWAbo00GT2h62LbhaWEEEe38DnxwiLezjg5KwexnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yRHdqpUq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vUE75i9K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T13+RbTHWmXWvjRQD2HFC/e4dmnwX4v5bWH6Q2wsYD0=;
	b=yRHdqpUqsLNitACGaBBONGQG2H5As4KA+PripP0VJB8rVU46jDIIjrH5gRCv72TDuTAieF
	UeWTvOi2WvS3otSyhPAECgYYxSEV9JoCZ+cn9Dye2jG/8d8YunFLY8tONslifROiAJ5rza
	DHyYfhDX8IZplp0baLahpFVs2DEEftsEBTJdovfaZyZhL09DH4l0nT6p2blVil2q37JIWz
	BlvWBSlXUcVF9kT2DqUxtcQDtcSOI7IeoOea34zcEj+C8o8xr137DGgU+PBSgzDJ1YF4SE
	0YvOmnJgwOrHEEZIFxMfxGgGPNY+UTc989iytDglNyEskknz2U0VKUrGEGaX3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T13+RbTHWmXWvjRQD2HFC/e4dmnwX4v5bWH6Q2wsYD0=;
	b=vUE75i9KmwfN5wser6YJiR/G3/UkggeUZLwwgRhrkNbwrncPNEkQ1PXZfmysHFQjfk8LZu
	BVs8UN6LpW7Q/vCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] tick/sched: Avoid hrtimer_cancel/start() sequence
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163429.542178086@kernel.org>
References: <20260224163429.542178086@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229301182.1647592.15112038585169494503.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8323-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,infradead.org:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 15A671C4292
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     adcec6a7f566aa237db211f2947b039418450b92
Gitweb:        https://git.kernel.org/tip/adcec6a7f566aa237db211f2947b0394184=
50b92
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:36:10 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:06 +01:00

tick/sched: Avoid hrtimer_cancel/start() sequence

The sequence of cancel and start is inefficient. It has to do the timer
lock/unlock twice and in the worst case has to reprogram the underlying
clock event device twice.

The reason why it is done this way is the usage of hrtimer_forward_now(),
which requires the timer to be inactive.

But that can be completely avoided as the forward can be done on a variable
and does not need any of the overrun accounting provided by
hrtimer_forward_now().

Implement a trivial forwarding mechanism and replace the cancel/reprogram
sequence with hrtimer_start(..., new_expiry).

For the non high resolution case the timer is not actually armed, but used
for storage so that code checking for expiry times can unconditially look
it up in the timer. So it is safe for that case to set the new expiry time
directly.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163429.542178086@kernel.org
---
 kernel/time/tick-sched.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index f7907fa..9e52644 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -864,19 +864,32 @@ u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_ti=
me)
 }
 EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
=20
+/* Simplified variant of hrtimer_forward_now() */
+static ktime_t tick_forward_now(ktime_t expires, ktime_t now)
+{
+	ktime_t delta =3D now - expires;
+
+	if (likely(delta < TICK_NSEC))
+		return expires + TICK_NSEC;
+
+	expires +=3D TICK_NSEC * ktime_divns(delta, TICK_NSEC);
+	if (expires > now)
+		return expires;
+	return expires + TICK_NSEC;
+}
+
 static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 {
-	hrtimer_cancel(&ts->sched_timer);
-	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
+	ktime_t expires =3D ts->last_tick;
=20
-	/* Forward the time to expire in the future */
-	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
+	if (now >=3D expires)
+		expires =3D tick_forward_now(expires, now);
=20
 	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES)) {
-		hrtimer_start_expires(&ts->sched_timer,
-				      HRTIMER_MODE_ABS_PINNED_HARD);
+		hrtimer_start(&ts->sched_timer,	expires, HRTIMER_MODE_ABS_PINNED_HARD);
 	} else {
-		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
+		hrtimer_set_expires(&ts->sched_timer, expires);
+		tick_program_event(expires, 1);
 	}
=20
 	/*

