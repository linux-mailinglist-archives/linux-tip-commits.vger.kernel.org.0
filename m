Return-Path: <linux-tip-commits+bounces-3788-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4679A4BCBB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6801893C4A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8D41F7066;
	Mon,  3 Mar 2025 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nx/Nlo5X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BDjdE1Vp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2781F4E4F;
	Mon,  3 Mar 2025 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998591; cv=none; b=aMzk7+2BOpu098uslP9vMqgP5rhAtkrlr/NWwjVuJpKmSjIayvHCyZ+tCpQ6aLWrNpeQxTYCNqPNGD+NiCdMGztAmSRtrmrqwZIziUvVpegAKt0VNMi7CFjP+q9kXQefXs7A+TC9TVFOIeRbgybvJkIP/WEIzHQ3wTlPED+4ZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998591; c=relaxed/simple;
	bh=SUPefsjZCE1Fs+miqWiTMHnxiG8Tuyz84BpiaX/biF8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=InCOuAmxevEBni5pL4P5qj1ypXSoueV+9TT6S0y7fFRLtIoVEjW5LmASDNo3GG1SG6SN8E0gSbnz2J3STqkVS5LytHk6DmqyuXZS5vFktOAdpIAjx7uqXwvwqJMnlXXc49ig13vaHWPmuI7OT5okm8FqfhE7bfRKneL+f8lLR24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nx/Nlo5X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BDjdE1Vp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:43:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6V/dzNu5iRZNWuqZzRD1XeH8g2I8xLL1au/tB00XKGk=;
	b=nx/Nlo5X1gLXi/AaYOORQ8OKIXt8fneSg69gD8qqW9pUcTJYQllyk88OcStgEA41stwe68
	izHkO/bW0UmFbf4T4xfqCfMN9kuDq7Ejs1ONH+WFrXycEzipDJw6sGX4kOlf2xRz9JKQzc
	oMn02tJirhNan4wd3M6NfnJeSKsriDjre4cv27ONcvZTQ8TPH4H5/WCHaPRHe8kLCa8Z4C
	wmENMNML2Qy/vJFYvXCAAatfjZ0zMmI/qwAyR9R1EELrL9IKg87r35YJQlLaG3cqPfFdCX
	+g6iPca2J23VRR17GWjQnF4O/8uRXaanCEUp56HbPFWMCoX6r/dlafG4I0Aylw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6V/dzNu5iRZNWuqZzRD1XeH8g2I8xLL1au/tB00XKGk=;
	b=BDjdE1VpBF7ytB8AIhD3I6/zKjly9vPNj/2rIVywdArEr0wOnGD0C26HRLHbjaiyrJydgq
	l6lyJiC1nZY9JZAg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Introduce vdso/cache.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099858725.10177.3558177025398303663.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     a753bfcac30e883cb792ee992f89b331bd14f397
Gitweb:        https://git.kernel.org/tip/a753bfcac30e883cb792ee992f89b331bd1=
4f397
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:33 +01:00

vdso: Introduce vdso/cache.h

The vDSO implementation can only include headers from the vdso/
namespace. To enable the usage of ____cacheline_aligned from
the vDSO, move it and its dependencies into a new header vdso/cache.h.
Keep compatibility by including vdso/cache.h from linux/cache.h.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/cache.h |  9 +--------
 include/vdso/cache.h  | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 8 deletions(-)
 create mode 100644 include/vdso/cache.h

diff --git a/include/linux/cache.h b/include/linux/cache.h
index ca2a056..e69768f 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -3,16 +3,13 @@
 #define __LINUX_CACHE_H
=20
 #include <uapi/linux/kernel.h>
+#include <vdso/cache.h>
 #include <asm/cache.h>
=20
 #ifndef L1_CACHE_ALIGN
 #define L1_CACHE_ALIGN(x) __ALIGN_KERNEL(x, L1_CACHE_BYTES)
 #endif
=20
-#ifndef SMP_CACHE_BYTES
-#define SMP_CACHE_BYTES L1_CACHE_BYTES
-#endif
-
 /**
  * SMP_CACHE_ALIGN - align a value to the L2 cacheline size
  * @x: value to align
@@ -63,10 +60,6 @@
 #define __ro_after_init __section(".data..ro_after_init")
 #endif
=20
-#ifndef ____cacheline_aligned
-#define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
-#endif
-
 #ifndef ____cacheline_aligned_in_smp
 #ifdef CONFIG_SMP
 #define ____cacheline_aligned_in_smp ____cacheline_aligned
diff --git a/include/vdso/cache.h b/include/vdso/cache.h
new file mode 100644
index 0000000..f89d483
--- /dev/null
+++ b/include/vdso/cache.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_CACHE_H
+#define __VDSO_CACHE_H
+
+#include <asm/cache.h>
+
+#ifndef SMP_CACHE_BYTES
+#define SMP_CACHE_BYTES L1_CACHE_BYTES
+#endif
+
+#ifndef ____cacheline_aligned
+#define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
+#endif
+
+#endif	/* __VDSO_ALIGN_H */

