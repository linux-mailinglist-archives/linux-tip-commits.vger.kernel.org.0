Return-Path: <linux-tip-commits+bounces-6038-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D31AFE4B2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 11:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2204163A2E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 09:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B6228982F;
	Wed,  9 Jul 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j2eraxgH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ngi7GzRA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F15A2882D0;
	Wed,  9 Jul 2025 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055059; cv=none; b=WDyS9Ld2nugldZI4fyFylnjqQNG84EOYoAulW+IxNm1972L24c3lMl3Qjh+PhrKkme6JwYAyMNBs9cmfWh4F8gyhY6/2zd5v1AooFRrdVBcZNvYuRIgiN72QDNx4z8/F1Y4Vh2lXfMm6EF56fzDqon6qGezeEK8smhae4765QUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055059; c=relaxed/simple;
	bh=Rcj1uTloacM2Q4NGa1fm75o1t6nsqyravKITpBVdoUE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jzj1bWIqtZARJR6hvwqMs/U0rO4gApepI6aFu0kazOogLRiR/496sX247Y9VG2z6EJRk6OcSBbecHFx45WK3eaHZpzEdiJ2UhiCOs8Dl7fDJ+dW7pKx5GqOpCQtn2b2tQCn+/iWQn4brAmpO0mC0XmjRdOoGXSvRNefgSj+urs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j2eraxgH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ngi7GzRA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Jul 2025 09:57:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752055055;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dueJPFOEb92N7rVQ6FIGC348OFGpEHdL24182UXXs1w=;
	b=j2eraxgHNZdS4u3+z0Eh2YqGWEl/mC0fOyTWGehAH6SgCvzn8XwuZHp8pS/2MRszw8gQ8d
	ysfpXnO/ZwKOthToeZRJ7rM9/YwvK/uepA1bHzzyALIeZ4TPhisf3gPi5tPCS6JRC4Ywe6
	MxRPez1CwsxHGuDjiP1eXqOe6ZMl6qn+JdETQ8f8Smz1MKFzNIIdXab91T6e1ezzwdtoi7
	a+QBRN8Npoq0w7pUtqh0vE1/q6XsGPLIWRNwxGE4m5t4kssp4idQYWf0yK63BhTHTepWN/
	XmbNrWoPKM0iZ/El0zYqVfbW6wBld5L+j+aNYNmRUA+Fd/hfmI1It6e5Ld4NFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752055055;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dueJPFOEb92N7rVQ6FIGC348OFGpEHdL24182UXXs1w=;
	b=Ngi7GzRAkdO0KvSZjRM/vWcx4mPRrXbeZ9P+C5ad7WMnIgJWhS5DDPQQ7TZTBAWuiG/Tm5
	gK5f75/fS5NxDDDQ==
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
Message-ID: <175205505494.406.1717550937901981135.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     b4a71f11b0ab758eb5a6d008318c80def007166b
Gitweb:        https://git.kernel.org/tip/b4a71f11b0ab758eb5a6d008318c80def00=
7166b
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:58:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Jul 2025 11:52:35 +02:00

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
index 87e7aae..296709b 100644
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

