Return-Path: <linux-tip-commits+bounces-6510-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ABCB4A634
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF70E188FDFE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 08:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7732027F728;
	Tue,  9 Sep 2025 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PdBkGgI4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xvWrmo9f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7DD2750F6;
	Tue,  9 Sep 2025 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408212; cv=none; b=IHQQwb0Rt7c3WrjRxCUPGMYyH6tWGZT7MIxu/B0IPfw97Y4VdoFJ6e3F96CZa7mndtfMks/glw3syusm3IRnzK+e7iLlRg1QmleKtxzw7T7YR35z3/SnkR3gutOcw1tc08vOf1iAgIfUBPS1twDgkvLbcn8Lhh2WDpjIam7BSUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408212; c=relaxed/simple;
	bh=Wmt6u0fxWLSdrhJKFxETJO9lcObMjrVGTyQKBrbiUcc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ee2Gzg2f9fYPYNoEkihj/l8rqwdf1IysblLyxHJ826Uj5lpwlJyX9Myxcr7ls7t8qDbw4aRcz+cTwuC2r5U4syayYiF46nXzHOFqlbWphwx04z/+nYWgHG1D8lTwxYYFidlppleh5JyJeWij64df8i87UGtpeyJ01t4Eteco1iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PdBkGgI4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xvWrmo9f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 08:56:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757408208;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhtfMCNyuoPXcWCYHG3qAuC/ZXJZalFrDbrxAfOpEJg=;
	b=PdBkGgI4ES+zxxorBVoi9qQCYcImExg7QmRRqbQCuiv35dP6iktIwIv9/+wEhloxC8bRro
	CtztbK/1FeXz3PxfEMXuz1CnzUK1cYZzS3veKvkQXRF1D6sSXKWqmMyK/rHLhjtHjrrGgN
	uPlFRy9ga2x0RP+N+CJ3Kn0D1cKW8d93yZC86X6rLmwP+0px3hUyGMX1vaYYehki90R6jO
	I7eL0RXHJI9YDovKE66IZCK5+m0Asez4PCR6/h5345XdxMTXJsKk36Qm4U+wlcHdxQKUy8
	YKV7xMlPTCTMmNVKJnuLKweGQ0Ibm8KFI09QaoYW34wHy3QK2OfVe5pQl4NSWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757408208;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhtfMCNyuoPXcWCYHG3qAuC/ZXJZalFrDbrxAfOpEJg=;
	b=xvWrmo9fVmR2wCaUQKGFuDCwYeZ8ywvRuTVBmEW1A+pIUEZXca323YnoE3jW8vM5SF1nmC
	s6NEc5UXLA42gYDA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timers/itimer: Avoid direct access to hrtimer clockbase
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250812-hrtimer-cleanup-get_time-v1-2-b962cd9d9385@linutronix.de>
References:
 <20250812-hrtimer-cleanup-get_time-v1-2-b962cd9d9385@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175740820736.1920.2868268400590730525.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     316c010c55db1f9e521abe925c9d4b70e50e47e3
Gitweb:        https://git.kernel.org/tip/316c010c55db1f9e521abe925c9d4b70e50=
e47e3
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 08:08:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 10:53:18 +02:00

timers/itimer: Avoid direct access to hrtimer clockbase

The field timer->base->get_time is a private implementation detail and
should not be accessed outside of the hrtimer core.

Switch to the equivalent helper.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250812-hrtimer-cleanup-get_time-v1-2-b962=
cd9d9385@linutronix.de

---
 kernel/time/itimer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 876d389..7c6110e 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -163,8 +163,7 @@ void posixtimer_rearm_itimer(struct task_struct *tsk)
 	struct hrtimer *tmr =3D &tsk->signal->real_timer;
=20
 	if (!hrtimer_is_queued(tmr) && tsk->signal->it_real_incr !=3D 0) {
-		hrtimer_forward(tmr, tmr->base->get_time(),
-				tsk->signal->it_real_incr);
+		hrtimer_forward_now(tmr, tsk->signal->it_real_incr);
 		hrtimer_restart(tmr);
 	}
 }

