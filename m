Return-Path: <linux-tip-commits+bounces-6011-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517BDAFACC6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Jul 2025 09:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822403A627C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Jul 2025 07:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9920286D7A;
	Mon,  7 Jul 2025 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d7aLCoD1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9J6ALgQ6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F33A286424;
	Mon,  7 Jul 2025 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872309; cv=none; b=ACGBHR/tJxAzT1bRK4jIy7CfVupJ0gaHNNBQ8tyoEjLJ08HbwkJhLnZqyhs1OgG0W4doi+9uTOFKqPegIM/q4gF4+pc2zsvwWiM67w1QrTCg43SrI2HwWbEgoEwpRlPldmh6/PuDqADfsi8ge1tuiyRUqFkFO0DE7fEgVqfPvI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872309; c=relaxed/simple;
	bh=zcEDpqAhAuGeYUxylpp8kxp7pQuTKQGKv7uzF8sEvMM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eDDEH62rHJhpOB+lap9l4bT57V5zb2rnAAvOEeHOQnIkryS4TBZtriPnqiCVx8nP9YaM9ZgH9L7EhDYGRxObgFTaQ9ZphfG9zt73YJyTasAw7pxo3ag2T0ayVFrsqCtTK4SqYFIQEPTmmx9Tn4kHxBkzZpLkvKxowPO3Rk1DZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d7aLCoD1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9J6ALgQ6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Jul 2025 07:11:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751872306;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UA7IZBDYsVnOs9H8W9+8qBOhgOvsyfqCRLnNVTV9lvM=;
	b=d7aLCoD1EhJShLxkF62tXfQvoX/+xv9f6g8Sumu0pwU8KEoRIyGOZhKUwKpPiiYbv3uHqW
	5QYJrE2Ess7nX8QifI0jQOe8OVhzov2qaV+HFXuk/9vsci8qNE9BAypZYCh0SWf41X6mEi
	bkrvCSt9o/y+3ERej3OGWiNkbdMmjZeDBz6lrJ5YgypJcmHI1qwU1DGHy9+lzCwdfNUDT0
	9fwQFXgGQg/TD88sbA2ItoVPU2WKfK9640XtBPmgvmsyjpVJsvPxV0MgrscNARildtmPTe
	3XK682gYHxHO46dapl3ag8cLXtd2yT/4vJxP0ZL8hmkwRRo3BE+e/palWlLZvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751872306;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UA7IZBDYsVnOs9H8W9+8qBOhgOvsyfqCRLnNVTV9lvM=;
	b=9J6ALgQ6zIe/KBWyF1fFFSlfMZal2ngJfdI5+wcZPCNKORWBagFQhPZn3SYtNBTjPjgSTr
	QCoGjMNDksyA9XDw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] vdso/gettimeofday: Introduce vdso_set_timespec()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250701-vdso-auxclock-v1-8-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-8-df7d9f87b9b8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175187230533.406.1947358758210448503.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     3313cfe7e3d0f9ac0782f566db52a084cba45894
Gitweb:        https://git.kernel.org/tip/3313cfe7e3d0f9ac0782f566db52a084cba=
45894
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:58:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Jul 2025 08:58:52 +02:00

vdso/gettimeofday: Introduce vdso_set_timespec()

This code is duplicated and with the introduction of auxiliary clocks will
be duplicated even more.

Introduce a helper.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250701-vdso-auxclock-v1-8-df7d9f87b9b8@li=
nutronix.de

---
 lib/vdso/gettimeofday.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 215151b..50611ba 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -77,6 +77,16 @@ static __always_inline bool vdso_clockid_valid(clockid_t c=
lock)
 	return likely((u32) clock < MAX_CLOCKS);
 }
=20
+/*
+ * Must not be invoked within the sequence read section as a race inside
+ * that loop could result in __iter_div_u64_rem() being extremely slow.
+ */
+static __always_inline void vdso_set_timespec(struct __kernel_timespec *ts, =
u64 sec, u64 ns)
+{
+	ts->tv_sec =3D sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec =3D ns;
+}
+
 #ifdef CONFIG_TIME_NS
=20
 #ifdef CONFIG_GENERIC_VDSO_DATA_STORE
@@ -122,12 +132,7 @@ bool do_hres_timens(const struct vdso_time_data *vdns, c=
onst struct vdso_clock *
 	sec +=3D offs->sec;
 	ns +=3D offs->nsec;
=20
-	/*
-	 * Do this outside the loop: a race inside the loop could result
-	 * in __iter_div_u64_rem() being extremely slow.
-	 */
-	ts->tv_sec =3D sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec =3D ns;
+	vdso_set_timespec(ts, sec, ns);
=20
 	return true;
 }
@@ -188,12 +193,7 @@ bool do_hres(const struct vdso_time_data *vd, const stru=
ct vdso_clock *vc,
 		sec =3D vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vc, seq)));
=20
-	/*
-	 * Do this outside the loop: a race inside the loop could result
-	 * in __iter_div_u64_rem() being extremely slow.
-	 */
-	ts->tv_sec =3D sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec =3D ns;
+	vdso_set_timespec(ts, sec, ns);
=20
 	return true;
 }
@@ -223,12 +223,8 @@ bool do_coarse_timens(const struct vdso_time_data *vdns,=
 const struct vdso_clock
 	sec +=3D offs->sec;
 	nsec +=3D offs->nsec;
=20
-	/*
-	 * Do this outside the loop: a race inside the loop could result
-	 * in __iter_div_u64_rem() being extremely slow.
-	 */
-	ts->tv_sec =3D sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
-	ts->tv_nsec =3D nsec;
+	vdso_set_timespec(ts, sec, nsec);
+
 	return true;
 }
 #else

