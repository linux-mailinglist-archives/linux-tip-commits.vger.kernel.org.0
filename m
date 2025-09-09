Return-Path: <linux-tip-commits+bounces-6535-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B51DB4AAC1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 12:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0101F5E1454
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07781320CC0;
	Tue,  9 Sep 2025 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qhtHlC7C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XWpMGqE0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B6D31DD9B;
	Tue,  9 Sep 2025 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413870; cv=none; b=ekz4Y/geft7k1fmKydS3h4QFs3X756+s8hW7syUdlMZO+VKhTZox8msN55sTRH7cbxaa88NDNPH/FdwAuXjZtCwRr7ANKQZ7XtMTC0840CIj94SNOqTk1b2lIUUCeS4PXQrrBxjbzi5CJPkkU1pRFBIAnaRufBCQM/Wkac8Sgrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413870; c=relaxed/simple;
	bh=cLu47zuwHYf770pACoaRo3fwzwqZn1hfvg1ATx40d28=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EoUO+CrW1f6uoBq88k+UrCE3rwNb6EUMJAHE8AYofEh2EcUp57EI6oSkpCCT2d1R8vP2fgBPSYNelAKDTKPzLqXnIMZ7bq3F3mchFSfDkP0mQOxr7+InZSXBHDgkZ4ny1niigM1FpsoCIatpEz+6sYtfNE2YzJ97QgdaIst/4mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qhtHlC7C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XWpMGqE0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 10:31:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757413867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmX9/RuZmADqGPYo5VEUSyohDUSEUm53oYUPIYmQxI8=;
	b=qhtHlC7C0PHxggiP5QaKqee5UthZ4Wmfq5v06Nt+MGULpqjbE5I1Rn6FZML/1mjpgrGc2H
	LQLtesY7Ptn0je4hUCa5oTUav/8Yu9FeXodGxLhPoNGdkMEDKVUAUsCh6mky5gjBICWqiE
	A7QpuXSMihceUpTAL4ICYXRASQH+KnYlw66gYwNKVP3mp3Snl+mWTngXfENuYxKNKl7G6k
	KAlHrT100f5yZImlWNDD3XqeIJU+9oGVH1VzyFdxlDdjab3VY1h2GH/s4lUQkoCKQ5Ojxi
	oLd5yISmlr7v36qBvQQowtphFN6AIqJzBWHf94ScmLeRVt8bcAR17zif+aHu9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757413867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmX9/RuZmADqGPYo5VEUSyohDUSEUm53oYUPIYmQxI8=;
	b=XWpMGqE0d8A1VPJ0cdzHKV9lEuH3dHIgbB8nhNIsEHpIcIKZCNp/ZNu9dGwrIivFgjSfvp
	YWHfj4+FcUGromAg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timers/itimer: Avoid direct access to hrtimer clockbase
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20250821-hrtimer-cleanup-get_time-v2-2-3ae822e5bfbd@linutronix.de>
References:
 <20250821-hrtimer-cleanup-get_time-v2-2-3ae822e5bfbd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741386653.1920.3123124547864340108.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5f531fe9cb489bf63f71f6e5eee6420c57fbc049
Gitweb:        https://git.kernel.org/tip/5f531fe9cb489bf63f71f6e5eee6420c57f=
bc049
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 21 Aug 2025 15:28:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 12:27:17 +02:00

timers/itimer: Avoid direct access to hrtimer clockbase

The field timer->base->get_time is a private implementation detail and
should not be accessed outside of the hrtimer core.

Switch to the equivalent helper.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250821-hrtimer-cleanup-get_time-v2-2-3ae8=
22e5bfbd@linutronix.de

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

