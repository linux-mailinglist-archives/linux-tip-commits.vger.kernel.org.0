Return-Path: <linux-tip-commits+bounces-6009-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8692FAFACBF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Jul 2025 09:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD7A1893659
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Jul 2025 07:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879B3285CB9;
	Mon,  7 Jul 2025 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FCUcXUBC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HVMT5apJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E5727E7EB;
	Mon,  7 Jul 2025 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872307; cv=none; b=uDbjz07jNp3DN9I0Z2kid7CNWY3oHYxpVqI+iqcPQ3EiwlY5sUTFrOnakViHVp3pFbKhIeUXccg6iFqQaQaa+VitR4feyDlCmZgqXgLufod5W3aeNsESHtb4pJPaL9FoNahr2+9jk5iLY5gpB+A3ITUDLg2P8FeabvWQu9eQNyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872307; c=relaxed/simple;
	bh=RZnC6gJovTg/XFZw215gzf5zecBD1cQMtwwyRrOQfaE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YRDpBth0X5FW6+uU+iT2BPjvmHJcZN9cXakpedzupeWA9kKALOGwgAkOg6GFQ/r7rlkUL2GgR126H6dTyWEQbmGW6KpN3xmpFZPkeZpcRcmhf8ejrKoTIhLmnJJIpx2Wsf0g0BHyJ1iPwbITp8Vzyi7DdHZsOHjj7AfpZkyFa4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FCUcXUBC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HVMT5apJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Jul 2025 07:11:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751872304;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myKJWoGfNjyjQA3PmS2cwSqGCNnoNPB1qcdk0pIbnyo=;
	b=FCUcXUBCB33kTWfaqmST6R4ak/ZMgwEMcU8H2eSxHO9yDIN/fvyb64J1UT/G/99YzrAIbA
	pWV8rAraQ0iUuxsJ1VsmocwZc2EXcTtMIIjy3DIcdLzeOTWkLzF+swT/Ggckvra4QRLCWp
	HiWFAM+8IUIhTnKBdV3Bum33uaR8XVmOuXq7PmoV5imKVAJXMuLTbGrK1muurs8GjTWfqd
	9iFug+dtU/9ZQduKmju5KAnxjkR7f6SUWsT79TuLwkkasM6v/GZJ1Te7EQY4Hq8BO2tzLs
	R/iRkkyx22+OEtZpANCNQS0VsdMWma56PJ7+BLvzGpd/adJJ55gjXz1aixdADA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751872304;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myKJWoGfNjyjQA3PmS2cwSqGCNnoNPB1qcdk0pIbnyo=;
	b=HVMT5apJZ98tp/ajWLcMrq2Iw31Bo8CJ5bdPqidzTlpNLep8ctIU3v0DLmaUz2WlcXt6Rb
	d4hpLIApBSr81GBg==
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
Message-ID: <175187230336.406.12130309242669568798.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     8361c5bf4965e5d091e0413c4aeeb2f9dad4278f
Gitweb:        https://git.kernel.org/tip/8361c5bf4965e5d091e0413c4aeeb2f9dad=
4278f
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:58:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Jul 2025 08:58:53 +02:00

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

