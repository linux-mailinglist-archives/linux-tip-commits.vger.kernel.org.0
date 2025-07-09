Return-Path: <linux-tip-commits+bounces-6036-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E97AFE4B0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 11:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0421625E7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 09:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE4028852B;
	Wed,  9 Jul 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wm6Wkph9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/bBUH/oz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A80D2882CA;
	Wed,  9 Jul 2025 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055059; cv=none; b=h5kC0iV2T4sSQdwar07cz1coQ+10XUkPEyrI8ZYnYSV1XKAaxAw3wHcHRb4vhbxIDMFEiicJzKMznDB56ddxXjv+3fdoy+TdZtOLM1GSPIIGvH4VQUGmMTHKCR0LrN85a+CY2WAYC1t99ZE8FmPlFKTnIzZoykKCu+eFrslarJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055059; c=relaxed/simple;
	bh=/jOcbHuOaOUuxWUAHxWFxCVo8PzdCE6urjXijm4YInw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u6yk75V53zRB8Rxs6U+G5CwXhmiKRBE7DlMecdubfanKnQDFhsKAd/Hf87zKxQcagxt8wsKGG++CWlAj4RwRgvGMD5dEFrFAviwLmI9NWYtFT1lNOk05AxwPhoIL+f0UPkydeqy/wkniA2M1alsMBc+svWMvN5j7AYvDtdA2Jso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wm6Wkph9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/bBUH/oz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Jul 2025 09:57:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752055054;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aFkvfKlOQxiKuPLLmORTszXbJwvJJ0mWjTjkNx1jX64=;
	b=wm6Wkph9Wjbk9JeSMwrTQJGlv2xRx2g9Tj8+UvVfJx1jjsunaBiF4vPLTdDDQCcqJwkjDn
	/7gCGZlABUfNPVjObcwLDwg69eZ+a34W9nhj9NJ6OXzzZ3tgNHL0kdqlcfrbL2c1nVe5re
	luSoCS1m8Pi1oQjG3pgVXeSx6qHisZ5ka6e+gxiHItRk3JQ642nlsE/YGDRM9iwfqAr6GK
	pu8pSRGor8S3himjycG1QxDeaEd7N5eMHxxfVOW8UDzh6nIKYgL2cSb77PM7QbWq3jtH+F
	sOuDiwx/42e8Ga0RVaYy9moYFLZk7Fu1/96UDV22V8cHQnGIRUsvHcUtaAHuDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752055054;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aFkvfKlOQxiKuPLLmORTszXbJwvJJ0mWjTjkNx1jX64=;
	b=/bBUH/ozAdlY2vJiNI7Dkk6LUpGQ3UdFuR6EjuCJrDToXf+RSUoiEeFIBRfUQAY9UKQV4Z
	dNdIu49T5B6VwWDA==
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
Message-ID: <175205505303.406.4049292742194809149.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     e654315fa273e456964ef51ad6983374613e0a0f
Gitweb:        https://git.kernel.org/tip/e654315fa273e456964ef51ad6983374613=
e0a0f
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:58:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Jul 2025 11:52:35 +02:00

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

