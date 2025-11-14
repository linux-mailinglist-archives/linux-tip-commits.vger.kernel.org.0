Return-Path: <linux-tip-commits+bounces-7355-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C446C5E3C3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 17:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87BE6504888
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 15:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA7338F54;
	Fri, 14 Nov 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oz6Wv7ge";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j8qRjyNe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3902248A8;
	Fri, 14 Nov 2025 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134427; cv=none; b=XniZVSja1raypC/074zIHv2haZ6c9mbm06Q1oIotHU443aEBA7A7BHcPPLH5bnfrsKWHEsAF94jQ6O3onwhq3QxyJCsce7x1IY8kiRHiyB9fzre0Udn4w3NYwAmmvWgjG9bMBNJOkWMHwlkRoQATGyw34DU9Zwo+lsyZJbfQGPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134427; c=relaxed/simple;
	bh=++CCDL/8PfyhJAqLRdVtVeKwypXSo+B45lysw+Bsh8A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GUKtQNxE34ALqpsYsmtBOXzwAWv4ArDakxOO6qOqY2zv6kmkhP7KLD9k1B/EB0e9fSaPfKxJuuhA1+BmWLimXUKvfseqg4L6DLbdyI7039d0sf8H+dPMdH22oPQAPt36p9kJ+ASLzwLSxg1nWQtIMhIrBnqHjdocg7RkYOgzx+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oz6Wv7ge; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j8qRjyNe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 15:33:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763134422;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwlNhv24L9hp7onhzYTy+kAelcPFrueVeJyKGS6X6Fs=;
	b=oz6Wv7geZ2L5MKtXtnzcvYmAy5yUIuxT7AVVNsVwEOcPge/RrgjXZLnQiopWhzjSacwE59
	R45L3xcWDevgJr0HsIiyb/mKTtiQ/N1lDaeFiYdkGFToSpTHxBYy4xrRVHRrJGAQ4VI+qp
	8aDw/l1BsjWly8B8hmv2Xy58vvsIEOFHtyHG9x+L67wlVqYvDQa4cpscqz3cIkhsMeJOlW
	zBmX5XvYLpxzH+RJrcI3f6Iu5QLMHQXS898j3o+0rSznhVR468syVwcF63MFm6l7eI9n4c
	3PaD4xv15xhUHpcslx6fAYE+lnKTCRt03PkuDBQvK/7UZ8jCfN1fBgJC0jpMWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763134422;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwlNhv24L9hp7onhzYTy+kAelcPFrueVeJyKGS6X6Fs=;
	b=j8qRjyNeo6MOwQf3IIuMWjEB8mMie921jcKqxY3Pk/vE4xnGgPlQDu3U+7o+Gd6RV+XQ1V
	WUtDYKR41GTzWoCw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Store time as ktime_t in restart block
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20251110-restart-block-expiration-v1-3-5d39cc93df4f@linutronix.de>
References:
 <20251110-restart-block-expiration-v1-3-5d39cc93df4f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176313442159.498.13436910080822366785.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4702f4eceb639b6af199151e352e570943619d98
Gitweb:        https://git.kernel.org/tip/4702f4eceb639b6af199151e352e5709436=
19d98
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Mon, 10 Nov 2025 10:38:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 14 Nov 2025 16:31:19 +01:00

hrtimer: Store time as ktime_t in restart block

The hrtimer core uses ktime_t to represent times, use that also for the
restart block. CPU timers internally use nanoseconds instead of ktime_t
but use the same restart block, so use the correct accessors for those.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251110-restart-block-expiration-v1-3-5d39cc9=
3df4f@linutronix.de
---
 include/linux/restart_block.h  | 2 +-
 kernel/time/hrtimer.c          | 4 ++--
 kernel/time/posix-cpu-timers.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index 7e50bbc..36ddfa1 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -43,7 +43,7 @@ struct restart_block {
 				struct __kernel_timespec __user *rmtp;
 				struct old_timespec32 __user *compat_rmtp;
 			};
-			u64 expires;
+			ktime_t expires;
 		} nanosleep;
 		/* For poll */
 		struct {
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 7e7b2b4..9c77e5c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2145,7 +2145,7 @@ static long __sched hrtimer_nanosleep_restart(struct re=
start_block *restart)
 	int ret;
=20
 	hrtimer_setup_sleeper_on_stack(&t, restart->nanosleep.clockid, HRTIMER_MODE=
_ABS);
-	hrtimer_set_expires_tv64(&t.timer, restart->nanosleep.expires);
+	hrtimer_set_expires(&t.timer, restart->nanosleep.expires);
 	ret =3D do_nanosleep(&t, HRTIMER_MODE_ABS);
 	destroy_hrtimer_on_stack(&t.timer);
 	return ret;
@@ -2172,7 +2172,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer=
_mode mode,
=20
 	restart =3D &current->restart_block;
 	restart->nanosleep.clockid =3D t.timer.base->clockid;
-	restart->nanosleep.expires =3D hrtimer_get_expires_tv64(&t.timer);
+	restart->nanosleep.expires =3D hrtimer_get_expires(&t.timer);
 	set_restart_fn(restart, hrtimer_nanosleep_restart);
 out:
 	destroy_hrtimer_on_stack(&t.timer);
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 2e5b89d..0de2bb7 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1557,7 +1557,7 @@ static int do_cpu_nanosleep(const clockid_t which_clock=
, int flags,
 		 * Report back to the user the time still remaining.
 		 */
 		restart =3D &current->restart_block;
-		restart->nanosleep.expires =3D expires;
+		restart->nanosleep.expires =3D ns_to_ktime(expires);
 		if (restart->nanosleep.type !=3D TT_NONE)
 			error =3D nanosleep_copyout(restart, &it.it_value);
 	}
@@ -1599,7 +1599,7 @@ static long posix_cpu_nsleep_restart(struct restart_blo=
ck *restart_block)
 	clockid_t which_clock =3D restart_block->nanosleep.clockid;
 	struct timespec64 t;
=20
-	t =3D ns_to_timespec64(restart_block->nanosleep.expires);
+	t =3D ktime_to_timespec64(restart_block->nanosleep.expires);
=20
 	return do_cpu_nanosleep(which_clock, TIMER_ABSTIME, &t);
 }

