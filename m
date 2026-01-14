Return-Path: <linux-tip-commits+bounces-8002-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B43D1F4FE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 15:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE270300BBEE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 14:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0D427B34F;
	Wed, 14 Jan 2026 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YP9PyAW1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ndK/+OT4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAEF260569;
	Wed, 14 Jan 2026 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768399451; cv=none; b=mJqnFUAxTdMsnBu3Ao6FKL0wfqkx+1wKc0EjoAW29Er6HEQRJcq/Zyhd3gIgzd2LHjJGGh4Ri7fIfyTueTC6GNlcZkGLzniGmgXHCgI25RMp+v9wZm/4z2694os/3VZ1upBLEcWKjiGBimagYDxGip2RuKz28nUM4CKNMZOgQGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768399451; c=relaxed/simple;
	bh=FUtXMwBer67/3hw8migMMmf+hXyD7iW+kacUno+vkyQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=D3ev/WYjlr+Zy1H3eDineMAB7q20IBphwd9XoAa/ye+AwFoGpWmjZ+NRFLQGUhShWYhb4hllmRaLCOCYa/HbD29MkMYgRvsHDZSB6alfIrfUjxhJa3AHCj0sC0QLoXsCT5PjPpORE8UqSYSjxrHQr7SkNNZdO8mftUR2MQcevtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YP9PyAW1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ndK/+OT4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 14:04:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768399447;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sG9qe48DxORxrOlB4WxF3utCfogHLkc3trXzuzscjIg=;
	b=YP9PyAW1bIq723ENbVQv1PyuafQctIap5o+UHwSZF6McohcIEA8tiNrtq+W4LQBx5yrHiw
	pFx6Ccm7R9Od16OGGfJPIhoDcrkym+mTXEcB6M+YBuAjqa5vAd3xxzncy5+RmuGXEqA6R5
	a9nAyNidUSvFbdQDenBj/26/PPt63+3IX+HA1tjjjqCWX1va7z4w2ZSLZ+LXa6YBybdp3S
	Ag5I7cuk5JcyJN9D2Mwn0KwqzRsV49O3llfp9kJrpIhvAGEWORSQ9UDZlzd3K2OROoSD0k
	1t6jeh9fV/tW/cgpfisMOZU6/NExCsAsEUtTUA/sOTJCtVxpspbp7/aB+G/b8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768399447;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sG9qe48DxORxrOlB4WxF3utCfogHLkc3trXzuzscjIg=;
	b=ndK/+OT454lJcSWBmpxZUaIOK0Kwa0MTS6Q+vlNE+e2Jgn/mGhtxTSQkVV7JaKEDxu8Ade
	d0J1pOPk76sTzaBg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] powerpc/vdso: Provide clock_getres_time64()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@kernel.org>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260114-vdso-powerpc-align-v1-1-acf09373d568@linutronix.de>
References: <20260114-vdso-powerpc-align-v1-1-acf09373d568@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176839944572.510.2743778862864683116.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     759a1f97373f25770cf438d9fb5f2bddf4d77a54
Gitweb:        https://git.kernel.org/tip/759a1f97373f25770cf438d9fb5f2bddf4d=
77a54
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 14 Jan 2026 08:26:05 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Wed, 14 Jan 2026 14:57:39 +01:00

powerpc/vdso: Provide clock_getres_time64()

For consistency with __vdso_clock_gettime64() there should also be a
64-bit variant of clock_getres(). This will allow the extension of
CONFIG_COMPAT_32BIT_TIME to the vDSO and finally the removal of 32-bit
time types from the kernel and UAPI.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Link: https://patch.msgid.link/20260114-vdso-powerpc-align-v1-1-acf09373d568@=
linutronix.de
---
 arch/powerpc/include/asm/vdso/gettimeofday.h |  2 ++
 arch/powerpc/kernel/vdso/gettimeofday.S      | 12 ++++++++++++
 arch/powerpc/kernel/vdso/vdso32.lds.S        |  1 +
 arch/powerpc/kernel/vdso/vgettimeofday.c     |  6 ++++++
 4 files changed, 21 insertions(+)

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/incl=
ude/asm/vdso/gettimeofday.h
index ab3df12..8ea397e 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -135,6 +135,8 @@ int __c_kernel_clock_gettime64(clockid_t clock, struct __=
kernel_timespec *ts,
 			       const struct vdso_time_data *vd);
 int __c_kernel_clock_getres(clockid_t clock_id, struct old_timespec32 *res,
 			    const struct vdso_time_data *vd);
+int __c_kernel_clock_getres_time64(clockid_t clock_id, struct __kernel_times=
pec *res,
+				   const struct vdso_time_data *vd);
 #endif
 int __c_kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezone=
 *tz,
 			    const struct vdso_time_data *vd);
diff --git a/arch/powerpc/kernel/vdso/gettimeofday.S b/arch/powerpc/kernel/vd=
so/gettimeofday.S
index 79c9672..1c8e516 100644
--- a/arch/powerpc/kernel/vdso/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso/gettimeofday.S
@@ -103,6 +103,18 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 	cvdso_call __c_kernel_clock_getres
 V_FUNCTION_END(__kernel_clock_getres)
=20
+/*
+ * Exact prototype of clock_getres_time64()
+ *
+ * int __kernel_clock_getres(clockid_t clock_id, struct __timespec64 *res);
+ *
+ */
+#ifndef __powerpc64__
+V_FUNCTION_BEGIN(__kernel_clock_getres_time64)
+	cvdso_call __c_kernel_clock_getres_time64
+V_FUNCTION_END(__kernel_clock_getres_time64)
+#endif
+
=20
 /*
  * Exact prototype of time()
diff --git a/arch/powerpc/kernel/vdso/vdso32.lds.S b/arch/powerpc/kernel/vdso=
/vdso32.lds.S
index 72a1012..3f384a2 100644
--- a/arch/powerpc/kernel/vdso/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso32.lds.S
@@ -124,6 +124,7 @@ VERSION
 		__kernel_clock_gettime;
 		__kernel_clock_gettime64;
 		__kernel_clock_getres;
+		__kernel_clock_getres_time64;
 		__kernel_time;
 		__kernel_get_tbfreq;
 		__kernel_sync_dicache;
diff --git a/arch/powerpc/kernel/vdso/vgettimeofday.c b/arch/powerpc/kernel/v=
dso/vgettimeofday.c
index 6f5167d..3c194e1 100644
--- a/arch/powerpc/kernel/vdso/vgettimeofday.c
+++ b/arch/powerpc/kernel/vdso/vgettimeofday.c
@@ -35,6 +35,12 @@ int __c_kernel_clock_getres(clockid_t clock_id, struct old=
_timespec32 *res,
 {
 	return __cvdso_clock_getres_time32_data(vd, clock_id, res);
 }
+
+int __c_kernel_clock_getres_time64(clockid_t clock_id, struct __kernel_times=
pec *res,
+				   const struct vdso_time_data *vd)
+{
+	return __cvdso_clock_getres_data(vd, clock_id, res);
+}
 #endif
=20
 int __c_kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezone=
 *tz,

