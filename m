Return-Path: <linux-tip-commits+bounces-6133-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A040BB0A3B7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 13:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E46107BD5D0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 11:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EFF2D9ECF;
	Fri, 18 Jul 2025 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xmKeCun3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+M2SRnjA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553862D979D;
	Fri, 18 Jul 2025 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839788; cv=none; b=rsNs5EZmCvpzo8GYLIQu36sZUqpmepxDWD93s1u8v6Suod9j9J7WDZ2SSvQxOyUV/TFQPMmhsgwfevFYTJ83PwrX5tqRipZdaPrSSNucIt6yLvJdwZOd5oTrUcwEJ+iufNNHqCTQUvAMkyf8WlWLwa863YFqypiE41tdrJC0KOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839788; c=relaxed/simple;
	bh=hIDZYhn25I4nv4w9yFmnKPVkSKMq8rbDSEdSUGQA7ME=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AjgQ8uAcOnxk8kJvrMZ8NmD9KkU97N+GxmkEDpKaHgXTfPiIU8duB5WGK2Fd64+u6p9SoRT3B0JH+5Mux5e9ZqEpMpsij3L+EX2NvrYM0ZLqRRXAy4Z6aKZWR5rUZMuYG3rT2vKynrzM/RvK0PHmQWOSqowisPZ0vfIPLc8stiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xmKeCun3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+M2SRnjA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Jul 2025 11:56:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752839785;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w92ix49+eNn2AZxyo/Ji9Hj4nclljfOY/suMCcXZaJE=;
	b=xmKeCun37/ujg7Gnc/+9LmBY2xcczR6fhMLYErX8pwzk2FSIZbP54hXjVYdAlLEYLcTCGa
	Gy/fRkdCIzMr1BgEyn9e0EVUmglcLVyS2OhJMLHY8Znd8cSG9Q/4v/3YHooZ/GY8WY5m0Y
	SxkVEWFH2YweesNpZ4RKj3s2mRuo6Kui2RVwnKAjpbuUnySLDqLsukOqLqbgXH9emWX34B
	Wx4jgN9FrRBckajwvABVkRYAMHb3hdb0+s44mWG/PQsAOUEyta2SMaX1Kx9IZ1uy/hEVYv
	8k6PzoGroSL9yMpn9yvsDF+xvbnnlfDAGJToeZyourBWnywAzI8UD4E7uBJrVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752839785;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w92ix49+eNn2AZxyo/Ji9Hj4nclljfOY/suMCcXZaJE=;
	b=+M2SRnjAZI72Ys5x2JZQmpVpi5ZxZYzECbutF2ocmeg01hapfU85StM4M+CqqpQLI/Tqnz
	EpADRZTqGP01vvCw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] vdso: Introduce aux_clock_resolution_ns()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250701-vdso-auxclock-v1-10-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-10-df7d9f87b9b8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175283978425.406.4317870262269329813.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     9b7fc3f14576c268f62fe0b882fac5e61239b659
Gitweb:        https://git.kernel.org/tip/9b7fc3f14576c268f62fe0b882fac5e6123=
9b659
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:58:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 18 Jul 2025 13:45:32 +02:00

vdso: Introduce aux_clock_resolution_ns()

Move the constant resolution to a shared header,
so the vDSO can use it and return it without going through a syscall.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250701-vdso-auxclock-v1-10-df7d9f87b9b8@l=
inutronix.de

---
 include/vdso/auxclock.h   | 13 +++++++++++++
 kernel/time/timekeeping.c |  6 ++++--
 2 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 include/vdso/auxclock.h

diff --git a/include/vdso/auxclock.h b/include/vdso/auxclock.h
new file mode 100644
index 0000000..6d6e74c
--- /dev/null
+++ b/include/vdso/auxclock.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _VDSO_AUXCLOCK_H
+#define _VDSO_AUXCLOCK_H
+
+#include <uapi/linux/time.h>
+#include <uapi/linux/types.h>
+
+static __always_inline u64 aux_clock_resolution_ns(void)
+{
+	return 1;
+}
+
+#endif /* _VDSO_AUXCLOCK_H */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index c6fe89b..cbcf090 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -26,6 +26,8 @@
 #include <linux/audit.h>
 #include <linux/random.h>
=20
+#include <vdso/auxclock.h>
+
 #include "tick-internal.h"
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
@@ -2876,8 +2878,8 @@ static int aux_get_res(clockid_t id, struct timespec64 =
*tp)
 	if (!clockid_aux_valid(id))
 		return -ENODEV;
=20
-	tp->tv_sec =3D 0;
-	tp->tv_nsec =3D 1;
+	tp->tv_sec =3D aux_clock_resolution_ns() / NSEC_PER_SEC;
+	tp->tv_nsec =3D aux_clock_resolution_ns() % NSEC_PER_SEC;
 	return 0;
 }
=20

