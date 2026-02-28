Return-Path: <linux-tip-commits+bounces-8322-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CTzBngNo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8322-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:44:56 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCC81C4157
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EE56300F9F7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA47D481225;
	Sat, 28 Feb 2026 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vZXyzGDO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SlbgQRQL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC547F2D6;
	Sat, 28 Feb 2026 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293020; cv=none; b=mFSTikEZNj1fDjy0XfWTBjFzG/lfkVBzVBufiod5rApUl7t3FWDFg+WPBoRHqAvd2fBOSRydyPdp3eTJj5YfFXp0ogR8T42qZoNuYDsMXU2/msJVa0/LI1tQfHjAeKinkyY4Wz+TYPrW0x1i8m9RwHquaMf6NnUBmZzFqhESs3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293020; c=relaxed/simple;
	bh=4NWniADRMeRD8jYslXODPYDxEKtx0SRE32nksuaQwzQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LOoOXRL1xGzgYnP8ZGB1UWUIdrrUImOIroJzCQDEMtU7XyD8IV3MNYi7xtfMyrc96iTPlHmogATpHvG82dKfUKcqt6ratqhaHO3QvAfGGzmGJggtKPyBUSSXXV/CPikTeEaPs4mM9Y0VU4zSnfN5Bic6GrTXvRK5cLRAIIVLj3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vZXyzGDO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SlbgQRQL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293012;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iub3Bcl76op4F2ZU8rVRkcDn1ysP9EYuJ0YPG271Te0=;
	b=vZXyzGDOpMuOC/Yad7BzPOKS9sfIwh9FhOiYle7whLzCzzvPR4qkcI31iAry4gTjHXqUsp
	lzl470bEzNdtbUNxmNir2+LygbyBX3VPp8vBwWWNFPZh4ghxWcPguUlvrPLlmOKwwqLpIq
	KpvM0WFEpMn61HXXbLG/OAx8urNq4iyfkHHoGy9fVdXsWLbVcE05IEJS5dm/kpQGNUXUEc
	F+761CPAIkNK0kGYNiQhUzYjosjjZTSXZm4DFWJ4xnRJ+ggPSFx4kY1hXua5wvXHaCpAQL
	tWOU4w2yR2qteCr73TWeeKTN+1q2r2LcfFo+w0IsSjZDk7xr2It/1kI80VdnDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293012;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iub3Bcl76op4F2ZU8rVRkcDn1ysP9EYuJ0YPG271Te0=;
	b=SlbgQRQLk4gJtvxnb4bVFlKkp6t+qwP6be7OCExFQL+pmazhjlN8hXR1G+XeYpaHepzdaA
	khRigiUs6lIFXIBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/hrtick] clockevents: Remove redundant CLOCK_EVT_FEAT_KTIME
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163429.609049777@kernel.org>
References: <20260224163429.609049777@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229301069.1647592.16057508711688465108.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8322-lists,linux-tip-commits=lfdr.de];
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
X-Rspamd-Queue-Id: 6CCC81C4157
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     70802807398c65f5a49b2baec87e1f6c8db43de6
Gitweb:        https://git.kernel.org/tip/70802807398c65f5a49b2baec87e1f6c8db=
43de6
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:36:15 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:06 +01:00

clockevents: Remove redundant CLOCK_EVT_FEAT_KTIME

The only real usecase for this is the hrtimer based broadcast device.
No point in using two different feature flags for this.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163429.609049777@kernel.org
---
 include/linux/clockchips.h           | 1 -
 kernel/time/clockevents.c            | 4 ++--
 kernel/time/tick-broadcast-hrtimer.c | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index b0df28d..5e8f781 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -45,7 +45,6 @@ enum clock_event_state {
  */
 # define CLOCK_EVT_FEAT_PERIODIC	0x000001
 # define CLOCK_EVT_FEAT_ONESHOT		0x000002
-# define CLOCK_EVT_FEAT_KTIME		0x000004
=20
 /*
  * x86(64) specific (mis)features:
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index eaae1ce..5abaeef 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -319,8 +319,8 @@ int clockevents_program_event(struct clock_event_device *=
dev, ktime_t expires,
 	WARN_ONCE(!clockevent_state_oneshot(dev), "Current state: %d\n",
 		  clockevent_get_state(dev));
=20
-	/* Shortcut for clockevent devices that can deal with ktime. */
-	if (dev->features & CLOCK_EVT_FEAT_KTIME)
+	/* ktime_t based reprogramming for the broadcast hrtimer device */
+	if (unlikely(dev->features & CLOCK_EVT_FEAT_HRTIMER))
 		return dev->set_next_ktime(expires, dev);
=20
 	delta =3D ktime_to_ns(ktime_sub(expires, ktime_get()));
diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcas=
t-hrtimer.c
index a88b72b..51f6a10 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -78,7 +78,6 @@ static struct clock_event_device ce_broadcast_hrtimer =3D {
 	.set_state_shutdown	=3D bc_shutdown,
 	.set_next_ktime		=3D bc_set_next,
 	.features		=3D CLOCK_EVT_FEAT_ONESHOT |
-				  CLOCK_EVT_FEAT_KTIME |
 				  CLOCK_EVT_FEAT_HRTIMER,
 	.rating			=3D 0,
 	.bound_on		=3D -1,

