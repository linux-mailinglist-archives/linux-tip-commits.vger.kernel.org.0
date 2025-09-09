Return-Path: <linux-tip-commits+bounces-6534-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CF3B4AAC0
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 12:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22FBC1C60983
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5783203A0;
	Tue,  9 Sep 2025 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="icp0CR+k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6JKukkT8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EE531B13F;
	Tue,  9 Sep 2025 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413870; cv=none; b=jfho9BQ+kVoq1CAslxqVs9MprDEukiGgGut015BfpuB1KXBcVRFM5Hal78E8+4WrtOopWFfQV/aB3virFVY7k6S5Kj07fg7lMdWcelw5H8cimvyuxMqNVMZv11dj42BgwPhN/cGMMohPsEpbGo1Du/O1bCb0p5K3H2t8oIw2/zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413870; c=relaxed/simple;
	bh=KWuxuOVQzNLMNE+oduZFqy2VcFy+qMc8t7MPVT2Uwig=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WP0ET4z2ZG4bNiRjcaB59vDnvTPfwhp476akM7HEjANES4xHKzro6ka9j9/x62j/G57sFLNun1buQaoUXgYPcWFDI4QBnRXaL00mbMLy+SPtFl5K9lc9xU46kv1WeR+I0TXaMbyWKPLVHIxg3vnQFJT8QFveDi0oSasLVmwt5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=icp0CR+k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6JKukkT8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 10:31:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757413866;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ukvp6iBJkMsXXWrNI97SJSAL2gbAuZ/fYfH+5PIybf8=;
	b=icp0CR+kTqnD16mF9IK6BbZJUF7AGtHhEWI1ZEiZTZSlGqWPiJyTG1LX4wpiK7pGq6dJ51
	N5yqAxWTj5Nb2mojkhMimOm234WhviKUPYVQBTCaKSW/3RluEMlnthJJXZE/pHivPVsesR
	CfVbcWHXXzpCSt5rsgDFagxL9aQKYwKw4w0FqtbNAhxfBg8Fz+M/2VHZT4OfXzhMrTO5g9
	oHvmKVusvprIu2vzt9pE7YVyFQIxtdlzE3jo0bCT5LPeruji92SM2tfejy1f67mn0gq7g3
	u/ytvHOaVlfTa6WuvemNTRuJRWdPLXwsEUDcmvEiwoVtzJbWDV68Z2QkHeITvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757413866;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ukvp6iBJkMsXXWrNI97SJSAL2gbAuZ/fYfH+5PIybf8=;
	b=6JKukkT8e9bCBNCcZaaTf7Jmwdb9wfzEBbiRGfxxAkQcNgg42m/UgTs/9MGC+xFldmp+hV
	djy90ZzK1YNclWCA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] sched/core: Avoid direct access to hrtimer clockbase
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20250821-hrtimer-cleanup-get_time-v2-3-3ae822e5bfbd@linutronix.de>
References:
 <20250821-hrtimer-cleanup-get_time-v2-3-3ae822e5bfbd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741386543.1920.11280065730475512879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b68b7f3e9b50747b88ba211080d27310430c928b
Gitweb:        https://git.kernel.org/tip/b68b7f3e9b50747b88ba211080d27310430=
c928b
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 21 Aug 2025 15:28:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 12:27:18 +02:00

sched/core: Avoid direct access to hrtimer clockbase

The field timer->base->get_time is a private implementation detail and
should not be accessed outside of the hrtimer core.

Switch to the equivalent helper.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250821-hrtimer-cleanup-get_time-v2-3-3ae8=
22e5bfbd@linutronix.de

---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629..4dc1283 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -917,7 +917,7 @@ void hrtick_start(struct rq *rq, u64 delay)
 	 * doesn't make sense and can cause timer DoS.
 	 */
 	delta =3D max_t(s64, delay, 10000LL);
-	rq->hrtick_time =3D ktime_add_ns(timer->base->get_time(), delta);
+	rq->hrtick_time =3D ktime_add_ns(hrtimer_cb_get_time(timer), delta);
=20
 	if (rq =3D=3D this_rq())
 		__hrtick_restart(rq);

