Return-Path: <linux-tip-commits+bounces-8082-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BLNHWavcGmKZAAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8082-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 11:50:14 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC4455838
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 11:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 329025037DB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 10:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FD83B8D4D;
	Wed, 21 Jan 2026 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vZYNHQsl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FmB8qQFO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF92328627;
	Wed, 21 Jan 2026 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768991838; cv=none; b=f9GK4KEWTpbLe2sbUWB63srW6v1arAKboHm/5LLRid+xKBs2FbvfKDf62+KkiTtl/pxI5nuFKcnnZusDcWkFo1g9S0y4q6hD68rEZ33l893aFVexVAILXESo2VpgdDvxI/O1EBuJkbkI5GcqNMNqwsQ2mMFAv/148WXDGWSJdeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768991838; c=relaxed/simple;
	bh=Hg+WPbjikTmQJ82KhCwopAAkEFEZFLZ4iJjZiyPJ+o0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eXySOGbkAqJxo9sf4EiP7qLaWx57GzByozjI61m4KO3UCLCTCwUQQ4qOv5X4jRDLbAOClmiG1YDr8LHIdIwWsDeyfqJGE/Jl9L4L0HFD78nHcFDxvDYrqUARD8LrwghKSiCE4HAocbVXTbsFdDNqqh5LEWKiVXEIyVdt8YxpsMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vZYNHQsl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FmB8qQFO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 Jan 2026 10:37:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768991830;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFbv3innd7HXx9Lftsndv4Fl9YuV0CRxqdAvyD+Stn4=;
	b=vZYNHQslw8AhwEDuemOPLdGFop5zB98tU/DRyGWrJGc03+MYmiSwiFXZQRF3a/9eOwlGXY
	haegcOuRUBeqqvlLCtuNDxVL1IIY/WzE1fS9iBCn++6Xvnsrg7Pmb+viVK0d0XdDyW2FMb
	6Pg2H3dwB7NiLf/dY6L6OdhU1yOKOBCXBpc8EUL8f02G/5ibHROD6jZ7lgs1JlJXxwKlLC
	yPE7sSdZRJsPv/KSbFucr11LO/s4mGHz7JElVPxiJ8JKybe4ZwaWqWsO81A/8fZ43EPFzq
	Frb/qwPgjsh9WQS4kqJuVmj5Dqu1s1LJIUuTpPBUREJo5GBFUD1OL0azBHoTWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768991830;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFbv3innd7HXx9Lftsndv4Fl9YuV0CRxqdAvyD+Stn4=;
	b=FmB8qQFOXkqPezliC7PazAxhbIqoqq89jDdomOyo/VGDego9OTqbGuF0z5HuSRAM7zmiyE
	MmLUWygaNMbSvRBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource: Reduce watchdog readout delay limit
 to prevent false positives
Cc: Daniel J Blueman <daniel@quora.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87bjjxc9dq.ffs@tglx>
References: <87bjjxc9dq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176899182593.510.16384647073619939928.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,quora.org:email,msgid.link:url,linutronix.de:email,linutronix.de:dkim,vger.kernel.org:replyto];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8082-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: EBC4455838
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     c06343be0b4e03fe319910dd7a5d5b9929e1c0cb
Gitweb:        https://git.kernel.org/tip/c06343be0b4e03fe319910dd7a5d5b9929e=
1c0cb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 17 Dec 2025 18:21:05 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Wed, 21 Jan 2026 11:33:11 +01:00

clocksource: Reduce watchdog readout delay limit to prevent false positives

The "valid" readout delay between the two reads of the watchdog is larger
than the valid delta between the resulting watchdog and clocksource
intervals, which results in false positive watchdog results.

Assume TSC is the clocksource and HPET is the watchdog and both have a
uncertainty margin of 250us (default). The watchdog readout does:

  1) wdnow =3D read(HPET);
  2) csnow =3D read(TSC);
  3) wdend =3D read(HPET);

The valid window for the delta between #1 and #3 is calculated by the
uncertainty margins of the watchdog and the clocksource:

   m =3D 2 * watchdog.uncertainty_margin + cs.uncertainty margin;

which results in 750us for the TSC/HPET case.

The actual interval comparison uses a smaller margin:

   m =3D watchdog.uncertainty_margin + cs.uncertainty margin;

which results in 500us for the TSC/HPET case.

That means the following scenario will trigger the watchdog:

 Watchdog cycle N:

 1)       wdnow[N] =3D read(HPET);
 2)       csnow[N] =3D read(TSC);
 3)       wdend[N] =3D read(HPET);

Assume the delay between #1 and #2 is 100us and the delay between #1 and

 Watchdog cycle N + 1:

 4)       wdnow[N + 1] =3D read(HPET);
 5)       csnow[N + 1] =3D read(TSC);
 6)       wdend[N + 1] =3D read(HPET);

If the delay between #4 and #6 is within the 750us margin then any delay
between #4 and #5 which is larger than 600us will fail the interval check
and mark the TSC unstable because the intervals are calculated against the
previous value:

    wd_int =3D wdnow[N + 1] - wdnow[N];
    cs_int =3D csnow[N + 1] - csnow[N];

Putting the above delays in place this results in:

    cs_int =3D (wdnow[N + 1] + 610us) - (wdnow[N] + 100us);
 -> cs_int =3D wd_int + 510us;

which is obviously larger than the allowed 500us margin and results in
marking TSC unstable.

Fix this by using the same margin as the interval comparison. If the delay
between two watchdog reads is larger than that, then the readout was either
disturbed by interconnect congestion, NMIs or SMIs.

Fixes: 4ac1dd3245b9 ("clocksource: Set cs_watchdog_read() checks based on .un=
certainty_margin")
Reported-by: Daniel J Blueman <daniel@quora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/lkml/20250602223251.496591-1-daniel@quora.org/
Link: https://patch.msgid.link/87bjjxc9dq.ffs@tglx
---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index a1890a0..df71949 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -252,7 +252,7 @@ enum wd_read_status {
=20
 static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csn=
ow, u64 *wdnow)
 {
-	int64_t md =3D 2 * watchdog->uncertainty_margin;
+	int64_t md =3D watchdog->uncertainty_margin;
 	unsigned int nretries, max_retries;
 	int64_t wd_delay, wd_seq_delay;
 	u64 wd_end, wd_end2;

