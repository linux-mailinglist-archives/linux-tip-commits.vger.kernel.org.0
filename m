Return-Path: <linux-tip-commits+bounces-6131-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5FEB0A3A9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 13:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8B85A7397
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 11:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0922D9789;
	Fri, 18 Jul 2025 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hm805RFo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kc5oho2W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95704221297;
	Fri, 18 Jul 2025 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839787; cv=none; b=rg153Ijuv+UH5DalkiI/eKb+0WX7UNLkJesDNGZwFGjQivrh4TjVst0Za5bQNoGwZPcVVPy5QwTpYS/qGBpiVrC729V3A7uKYTUBY7an8K83wKfmFzXY6fnNoykNHvD0Zi+M3z3hR8+MK8dWrmzEFMc/pKkY/ychtq0GQ5IQi4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839787; c=relaxed/simple;
	bh=az0q3YAkoWd3U1XV188ciWjnQaSclO9oA8lk22XofQs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GZk6CTmvW64ueRm15aVxMBNJHWvb3lLZvTqCguzGNGpezo/qK15SWwY/EXmDfhLnQvYeO+BuXsgJ8ugNl8HNJPb7JVeU+qhw2FlNfNSEX/6Nd2A/5PAjX08xIzzRuD/dUv0DvK2EhahBr8BVt5+RjJvKn3fkwYv9uXafM44kVOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hm805RFo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kc5oho2W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Jul 2025 11:56:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752839783;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/Mln5SvSw8RDBiAjJ/76BOLXbzGi0rWP62Hnk194fs=;
	b=Hm805RFoWhdejSjcVfbDOFfhfKAHbCxMNpt5/0aKd9DauhEhE0hvsegVdrm/2AF9j5Vzy3
	xq6KOckAmx1h+xdAMlQ/Qjgp0I8yoiVwVFkKMiXD/+xP7QkdoLzE/vFixlLrqK3GdoTkxy
	gZTd4JijK0GkQjGNOSckbKbj0S+hPh76y6oiQ4C+EtNN5w2G8Se/m25BTtBrJpI7iqMAP+
	E/Mt/DTfO4mNfhjyYW8bpzTuFFDwdVDpoh4hi29WtXGP4IfslYnLOrH9AjGN5aeCJAiNA8
	pd/WvYY2QjjiiZl+gUq00HeHzLwNMtOiWmHrVAFNitdKp48RzDuATklu6TJVKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752839783;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/Mln5SvSw8RDBiAjJ/76BOLXbzGi0rWP62Hnk194fs=;
	b=kc5oho2WZOmgM/ATE3ePEdDsVqJS87vPwLj2Ew+m3BBZn4zU02W7BYSBtxI869prWKAM5w
	BqHSGlOUVnXvJRCA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] vdso/gettimeofday: Add support for auxiliary clocks
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250701-vdso-auxclock-v1-12-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-12-df7d9f87b9b8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175283978207.406.5236820210383914428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     5b8c75d424fad4d7b295f50021e9fd9c1022e6a8
Gitweb:        https://git.kernel.org/tip/5b8c75d424fad4d7b295f50021e9fd9c102=
2e6a8
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:58:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 18 Jul 2025 13:45:33 +02:00

vdso/gettimeofday: Add support for auxiliary clocks

Expose the auxiliary clocks through the vDSO.

Architectures not using the generic vDSO time framework,
namely SPARC64, are not supported.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250701-vdso-auxclock-v1-12-df7d9f87b9b8@l=
inutronix.de

---
 include/vdso/datapage.h |  2 ++-
 lib/vdso/gettimeofday.c | 49 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index f4c96d9..0253303 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -5,6 +5,7 @@
 #ifndef __ASSEMBLY__
=20
 #include <linux/compiler.h>
+#include <uapi/linux/bits.h>
 #include <uapi/linux/time.h>
 #include <uapi/linux/types.h>
 #include <uapi/asm-generic/errno-base.h>
@@ -46,6 +47,7 @@ struct vdso_arch_data {
 #define VDSO_COARSE	(BIT(CLOCK_REALTIME_COARSE)	| \
 			 BIT(CLOCK_MONOTONIC_COARSE))
 #define VDSO_RAW	(BIT(CLOCK_MONOTONIC_RAW))
+#define VDSO_AUX	__GENMASK(CLOCK_AUX_LAST, CLOCK_AUX)
=20
 #define CS_HRES_COARSE	0
 #define CS_RAW		1
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index fc0038e..487e345 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -2,6 +2,7 @@
 /*
  * Generic userspace implementations of gettimeofday() and similar.
  */
+#include <vdso/auxclock.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
=20
@@ -74,7 +75,7 @@ static inline bool vdso_cycles_ok(u64 cycles)
 static __always_inline bool vdso_clockid_valid(clockid_t clock)
 {
 	/* Check for negative values or invalid clocks */
-	return likely((u32) clock < MAX_CLOCKS);
+	return likely((u32) clock < CLOCK_AUX_LAST);
 }
=20
 /*
@@ -268,6 +269,48 @@ bool do_coarse(const struct vdso_time_data *vd, const st=
ruct vdso_clock *vc,
 	return true;
 }
=20
+static __always_inline
+bool do_aux(const struct vdso_time_data *vd, clockid_t clock, struct __kerne=
l_timespec *ts)
+{
+	const struct vdso_clock *vc;
+	u32 seq, idx;
+	u64 sec, ns;
+
+	if (!IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS))
+		return false;
+
+	idx =3D clock - CLOCK_AUX;
+	vc =3D &vd->aux_clock_data[idx];
+
+	do {
+		/*
+		 * Open coded function vdso_read_begin() to handle
+		 * VDSO_CLOCK_TIMENS. See comment in do_hres().
+		 */
+		while ((seq =3D READ_ONCE(vc->seq)) & 1) {
+			if (IS_ENABLED(CONFIG_TIME_NS) && vc->clock_mode =3D=3D VDSO_CLOCKMODE_TI=
MENS) {
+				vd =3D __arch_get_vdso_u_timens_data(vd);
+				vc =3D &vd->aux_clock_data[idx];
+				/* Re-read from the real time data page */
+				continue;
+			}
+			cpu_relax();
+		}
+		smp_rmb();
+
+		/* Auxclock disabled? */
+		if (vc->clock_mode =3D=3D VDSO_CLOCKMODE_NONE)
+			return false;
+
+		if (!vdso_get_timestamp(vd, vc, VDSO_BASE_AUX, &sec, &ns))
+			return false;
+	} while (unlikely(vdso_read_retry(vc, seq)));
+
+	vdso_set_timespec(ts, sec, ns);
+
+	return true;
+}
+
 static __always_inline bool
 __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t cloc=
k,
 			     struct __kernel_timespec *ts)
@@ -289,6 +332,8 @@ __cvdso_clock_gettime_common(const struct vdso_time_data =
*vd, clockid_t clock,
 		return do_coarse(vd, &vc[CS_HRES_COARSE], clock, ts);
 	else if (msk & VDSO_RAW)
 		vc =3D &vc[CS_RAW];
+	else if (msk & VDSO_AUX)
+		return do_aux(vd, clock, ts);
 	else
 		return false;
=20
@@ -433,6 +478,8 @@ bool __cvdso_clock_getres_common(const struct vdso_time_d=
ata *vd, clockid_t cloc
 		 * Preserves the behaviour of posix_get_coarse_res().
 		 */
 		ns =3D LOW_RES_NSEC;
+	} else if (msk & VDSO_AUX) {
+		ns =3D aux_clock_resolution_ns();
 	} else {
 		return false;
 	}

