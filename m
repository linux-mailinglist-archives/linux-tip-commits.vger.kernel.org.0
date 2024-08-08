Return-Path: <linux-tip-commits+bounces-2021-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29FB94C1EE
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 17:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5020AB27148
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1E71917E5;
	Thu,  8 Aug 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="il+KQlB7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4LdoeHW3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0318FC8C;
	Thu,  8 Aug 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132158; cv=none; b=VjsEqdZYkf2UI+v4opgZo57w4UlLxTIK8v1eGHTBCcdtLNopvyF6F5YcOSlTIgCTNZt6Q/VeGtIs7N23EQ2dDPrQdU11GqiHXdaJD6QljqdUzpkgx56TjWWsUhXYZP1fCYavCtJk9E6caTzp+jTtdW7PnfTrekXsBOg9JHO7T0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132158; c=relaxed/simple;
	bh=Dkbmwww4C3M/JOucetcdJwFwwAlbPDAq4Q3mQpM6RWQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p6oHsvqHjAJ6y/4JxFQz/NV+bjQxIzzNYZlaPpb/L8WI9HDzOv7N+frMJcZVp0HjqRKokjWnhMrHkOe/SKDZpg/jM0lRkIIIfV6Wa6QX2JhUiKCFAji1E7u8fwVEw4qCF8BoSL9vZb/5sU2b7nGvhc09kccQLEYbJ/OFZbO2Q0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=il+KQlB7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4LdoeHW3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:49:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723132154;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0XMX7wdOqrwBo4zRK8fr6O7kgpPxnECYQBzcc6A7oeU=;
	b=il+KQlB7oTAuqj1+GsYN5BKvG5DLKAd8602Pai+NhoUprskd1KHFrAfvqjccfaZOUtl5IX
	17qumvDVZR4LINlPDUcvMZu3HwfmvOY284QgzlPg1YzJ1vrt7Nfko9EuMzTq/j4dW0VbiR
	UEGiTtoFHmAppGC0HYsCRd+fTt94mnDIDUSsA3aetbIGNilKcF+0wE4/vjrRlzc0GAkebF
	jwD2xUWEu58L9ZWUr++g454Fyt5dwCnob/rX3D0X/cubXp9ua6/YzzNJhMS5izFvHHdQU9
	RxfGAWhWAe5M3MP6cG/JXOYrbNTMxhaKg3ww8p3VFX5VWuMxdSjA7tRq0K8gmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723132154;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0XMX7wdOqrwBo4zRK8fr6O7kgpPxnECYQBzcc6A7oeU=;
	b=4LdoeHW3YEI7kVQWsZhr11MWWRCmGIU4VnkFmKyZvWul2QGg9WiRtvKqGpdxFx3c4ENc5v
	zUUr5WODgv7pzBDg==
From: "tip-bot2 for Dmitry Vyukov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] kcov: Add interrupt handling self test
Cc: Dmitry Vyukov <dvyukov@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <7662127c97e29da1a748ad1c1539dd7b65b737b2.1718092070.git.dvyukov@google.com>
References:
 <7662127c97e29da1a748ad1c1539dd7b65b737b2.1718092070.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313215445.2215.13998287534078096064.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     6cd0dd934b03d4ee4094ac474108723e2f2ed7d6
Gitweb:        https://git.kernel.org/tip/6cd0dd934b03d4ee4094ac474108723e2f2ed7d6
Author:        Dmitry Vyukov <dvyukov@google.com>
AuthorDate:    Tue, 11 Jun 2024 09:50:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:36:35 +02:00

kcov: Add interrupt handling self test

Add a boot self test that can catch sprious coverage from interrupts.
The coverage callback filters out interrupt code, but only after the
handler updates preempt count. Some code periodically leaks out
of that section and leads to spurious coverage.
Add a best-effort (but simple) test that is likely to catch such bugs.
If the test is enabled on CI systems that use KCOV, they should catch
any issues fast.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Link: https://lore.kernel.org/all/7662127c97e29da1a748ad1c1539dd7b65b737b2.1718092070.git.dvyukov@google.com


---
 kernel/kcov.c     | 31 +++++++++++++++++++++++++++++++
 lib/Kconfig.debug |  8 ++++++++
 2 files changed, 39 insertions(+)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index f0a69d4..d9d4a0c 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/hashtable.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 #include <linux/kmsan-checks.h>
 #include <linux/mm.h>
 #include <linux/preempt.h>
@@ -1058,6 +1059,32 @@ u64 kcov_common_handle(void)
 }
 EXPORT_SYMBOL(kcov_common_handle);
 
+#ifdef CONFIG_KCOV_SELFTEST
+static void __init selftest(void)
+{
+	unsigned long start;
+
+	pr_err("running self test\n");
+	/*
+	 * Test that interrupts don't produce spurious coverage.
+	 * The coverage callback filters out interrupt code, but only
+	 * after the handler updates preempt count. Some code periodically
+	 * leaks out of that section and leads to spurious coverage.
+	 * It's hard to call the actual interrupt handler directly,
+	 * so we just loop here for a bit waiting for a timer interrupt.
+	 * We set kcov_mode to enable tracing, but don't setup the area,
+	 * so any attempt to trace will crash. Note: we must not call any
+	 * potentially traced functions in this region.
+	 */
+	start = jiffies;
+	current->kcov_mode = KCOV_MODE_TRACE_PC;
+	while ((jiffies - start) * MSEC_PER_SEC / HZ < 300)
+		;
+	current->kcov_mode = 0;
+	pr_err("done running self test\n");
+}
+#endif
+
 static int __init kcov_init(void)
 {
 	int cpu;
@@ -1077,6 +1104,10 @@ static int __init kcov_init(void)
 	 */
 	debugfs_create_file_unsafe("kcov", 0600, NULL, NULL, &kcov_fops);
 
+#ifdef CONFIG_KCOV_SELFTEST
+	selftest();
+#endif
+
 	return 0;
 }
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a..270e367 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2173,6 +2173,14 @@ config KCOV_IRQ_AREA_SIZE
 	  soft interrupts. This specifies the size of those areas in the
 	  number of unsigned long words.
 
+config KCOV_SELFTEST
+	bool "Perform short selftests on boot"
+	depends on KCOV
+	help
+	  Run short KCOV coverage collection selftests on boot.
+	  On test failure, causes the kernel to panic. Recommended to be
+	  enabled, ensuring critical functionality works as intended.
+
 menuconfig RUNTIME_TESTING_MENU
 	bool "Runtime Testing"
 	default y

