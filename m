Return-Path: <linux-tip-commits+bounces-4091-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C279A57ABD
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E0A3AB4E9
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E4F1FF1B4;
	Sat,  8 Mar 2025 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pQ6ltJSN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ngGMpylb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5F61E834E;
	Sat,  8 Mar 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441509; cv=none; b=iLF2858ozHqnik04BZ3BygzqOZzpFQKBT1IDkpTim0mkID2zmpzkGFxB5rO2vSYjCpW9tOcV7J+M8FO8MjInwy0Akt4UiBCl2d52AkVRSEdlW/rwPgoEj5K7UvQtllCTIO9Lzx8AZiWmnYn+4/YYoT3fuMv9UEL3+0DlI9QprYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441509; c=relaxed/simple;
	bh=PTGGTwQHbmcw6maPgXJ6MshJpmilgN/F4FuNTtdqzMM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DUCSQvpGbdJ9cT3IwKP9ewnLmwGlvg3hefq53nHtawVUTIVGF7yDTy2JFPYIoa7ioAoaXXl3afsufH3+LUaVYtmCCTffcR1JMn3qGn+dC71OL3umm2sEPpQhh9AT4BDncC8FKWEIPbFjfKbXdqZYAvKiJxFXcKeOgOWnE0OpVc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pQ6ltJSN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ngGMpylb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:45:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HXDsuw8LMwBBTORNyVOO8/FUJ+Sg2Bz7iYScforWVFQ=;
	b=pQ6ltJSNX8qMq9ZzAHNX9EmwgCFN+YC2moFlrB558+A9o2NnjThDUJ3PC3OPRUcRE4SD+h
	gHzzBrtFQ7gEGsOoYFLTEjMEbCGwyWjCjIDNAQrq4LR22UXJxRvoSvJCtYt8XQPKZGox8q
	TrkkiE/HL20v8eDSYqw6i81qmVjIHhtEXZ55CQMglZU6D4KCUzNuiT1lFr0lNAgv7Sm3ln
	AHE3lBbzxAS/Xnw5v66q66xF0V4faYKntSDPuBIri2THg8l5mVlP7Gakib+TDsUqrW8h8E
	wlGiyNJaDvM8XFvPtRskmzegTo96TFdjYPabjgtS1Ym/UGya+nn+nAb3Lj5dCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HXDsuw8LMwBBTORNyVOO8/FUJ+Sg2Bz7iYScforWVFQ=;
	b=ngGMpylbgVFI15d998DR4prOg4vVB0O7ErTpKezqtLwpR28zTiVxs9EsZ6Rxz/Bn8JVZGN
	dtH4zVB/mCks1sAQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Introduce vdso/cache.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250303-vdso-clock-v1-1-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-1-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144150586.14745.11473965032857056650.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     0704bf439655c1f82ff7e623b1124a3c1cb8c907
Gitweb:        https://git.kernel.org/tip/0704bf439655c1f82ff7e623b1124a3c1cb=
8c907
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:39 +01:00

vdso: Introduce vdso/cache.h

The vDSO implementation can only include headers from the vdso/
namespace. To enable the usage of ____cacheline_aligned from
the vDSO, move it and its dependencies into a new header vdso/cache.h.
Keep compatibility by including vdso/cache.h from linux/cache.h.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-1-c1b5c69a166f@linut=
ronix.de

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

