Return-Path: <linux-tip-commits+bounces-6042-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8964EAFE4BC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 11:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCBC1C43A03
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EBC28B4E2;
	Wed,  9 Jul 2025 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T5axunN8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hjqygV2/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B29228A1DC;
	Wed,  9 Jul 2025 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055062; cv=none; b=StYHGTc87Sx9/wmTI2riqL2WfalnUTXRWOqPElVHCo7fXrXboIqBpwxVHZWIRa/6vnj2vTr70lcqMVWeV8KLS514cFFAGX7U27AFgTaTYsRDfKgtmg++LayhriE3ce6b8Tb55uUXNU01vmP8xeOULNc7MV2+RuNknfvdZtEE8bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055062; c=relaxed/simple;
	bh=CsP712jPA6tLvRa8pTgkbxSKtV9lBPX1i0tcmFy3tNU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J5Dt5q07KMljMSIAPeAEm2GuRiStsVhLliOcRTXmIdTbAUAM7/Pqi1NLPCmMp1Iapr/hJN+XH7+RvivCOtkA9/keWBYYxrgVhgwOF6ilIbreUr/ecAdm4BakhkOrbPYSeSS74sjRZCz2bFp39FG6909JegUTURt9V2Dl5+hK/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T5axunN8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hjqygV2/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Jul 2025 09:57:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752055059;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hm3clky29UOovmXRMHxxhLoUowDd+4QL0jcMIHr8jRw=;
	b=T5axunN86E7wQdv++dN2eWQ8DYUQh4E28rQf3RI4GpW8H0gZGoaDN71knBhsHjcyzcED5t
	7YRcxwGVQspDCLnuf7jCXV8Fx1udahSWPbIjIhJuqaGiho09iIIL+mctqASUQuSdflYmc2
	aVjeejlKDxjHSN4XJ1foo9EZH5mci99zYPZHms0SkbjVoLo3N+pNqa4Xi+P5Iwc8RsM+7c
	YFwzSEzvr/1J30qfnHPq+rrFPaOiuPxHb6JqmrMYus5hjMAS3KGX56bhMPegeTLl6iSiL6
	LjNvfIHyIgH3QDuaVRaKjE8YvLE+sJSvC+r8wbParf71q12WqZiaJu0d+4ierA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752055059;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hm3clky29UOovmXRMHxxhLoUowDd+4QL0jcMIHr8jRw=;
	b=hjqygV2/9kyb+YfwWl3BYJzmFTnZx1oGRw7YK1ax4ZtXCpDjiHrAAGrdJXTLI5UaiZ39hn
	Q6+JJK4vghZ2ZtAw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/ptp] vdso/gettimeofday: Return bool from clock_getres() helpers
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250701-vdso-auxclock-v1-5-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-5-df7d9f87b9b8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175205505801.406.2285718608794074089.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     34f888e3405acefc3a353227aa850dd0a37e709d
Gitweb:        https://git.kernel.org/tip/34f888e3405acefc3a353227aa850dd0a37=
e709d
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:57:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Jul 2025 11:52:34 +02:00

vdso/gettimeofday: Return bool from clock_getres() helpers

The internal helpers are effectively using boolean results,
while pretending to use error numbers.

Switch the return type to bool for more clarity.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250701-vdso-auxclock-v1-5-df7d9f87b9b8@li=
nutronix.de

---
 lib/vdso/gettimeofday.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 93ef801..9b77f23 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -396,8 +396,8 @@ static __maybe_unused __kernel_old_time_t __cvdso_time(__=
kernel_old_time_t *time
=20
 #ifdef VDSO_HAS_CLOCK_GETRES
 static __maybe_unused
-int __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t c=
lock,
-				struct __kernel_timespec *res)
+bool __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t =
clock,
+				 struct __kernel_timespec *res)
 {
 	const struct vdso_clock *vc =3D vd->clock_data;
 	u32 msk;
@@ -405,7 +405,7 @@ int __cvdso_clock_getres_common(const struct vdso_time_da=
ta *vd, clockid_t clock
=20
 	/* Check for negative values or invalid clocks */
 	if (unlikely((u32) clock >=3D MAX_CLOCKS))
-		return -1;
+		return false;
=20
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
 	    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
@@ -427,23 +427,25 @@ int __cvdso_clock_getres_common(const struct vdso_time_=
data *vd, clockid_t clock
 		 */
 		ns =3D LOW_RES_NSEC;
 	} else {
-		return -1;
+		return false;
 	}
=20
 	if (likely(res)) {
 		res->tv_sec =3D 0;
 		res->tv_nsec =3D ns;
 	}
-	return 0;
+	return true;
 }
=20
 static __maybe_unused
 int __cvdso_clock_getres_data(const struct vdso_time_data *vd, clockid_t clo=
ck,
 			      struct __kernel_timespec *res)
 {
-	int ret =3D __cvdso_clock_getres_common(vd, clock, res);
+	bool ok;
=20
-	if (unlikely(ret))
+	ok =3D  __cvdso_clock_getres_common(vd, clock, res);
+
+	if (unlikely(!ok))
 		return clock_getres_fallback(clock, res);
 	return 0;
 }
@@ -460,18 +462,18 @@ __cvdso_clock_getres_time32_data(const struct vdso_time=
_data *vd, clockid_t cloc
 				 struct old_timespec32 *res)
 {
 	struct __kernel_timespec ts;
-	int ret;
+	bool ok;
=20
-	ret =3D __cvdso_clock_getres_common(vd, clock, &ts);
+	ok =3D __cvdso_clock_getres_common(vd, clock, &ts);
=20
-	if (unlikely(ret))
+	if (unlikely(!ok))
 		return clock_getres32_fallback(clock, res);
=20
 	if (likely(res)) {
 		res->tv_sec =3D ts.tv_sec;
 		res->tv_nsec =3D ts.tv_nsec;
 	}
-	return ret;
+	return 0;
 }
=20
 static __maybe_unused int

