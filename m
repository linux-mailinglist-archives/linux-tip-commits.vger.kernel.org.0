Return-Path: <linux-tip-commits+bounces-1361-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D9D9027D2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Jun 2024 19:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9D31F22C4B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Jun 2024 17:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D36149DE8;
	Mon, 10 Jun 2024 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ERsMF2mz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bJeUToxX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46EB145352;
	Mon, 10 Jun 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040951; cv=none; b=BLXSkj2oFZX2t5dBzBH9zHM4ITAHFekArqULgu1I0p5vfy4++zwlmOxFUZo0H8l0rBOcia22sTOVk2K8qzIbIHELmivjnGW39d4kFNhTPWL1D96Mb8ihRxwDsTIKEu0++MJHDrm2l9jEgMfpeysxXFDyVNbTHWYdfu12Wey8JWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040951; c=relaxed/simple;
	bh=gEG+O/kRTGA0aqpC27gaYWrZS67zXd5MN0Rohk5FXDM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VsVYhcQ0PpX8ODwq+e+KdHDd0aO2eWAiapYgXbcWAYNLbDI7kHsaVmCpNrO6ef1/t2Jmvw4vKGnWTc20e+oy7G22+fqPb/RMk/L49wGuDaGCgyNdhXLn879dtIEuro3eLfcVpg4AQdYwDdGlPe5WB65Ka939eV+Dk+/BGCrN6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ERsMF2mz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bJeUToxX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Jun 2024 17:35:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718040946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NffsW6uZ57Snj3nWvpu+1CVOleFQgv1NeJ/HKebzorI=;
	b=ERsMF2mz/lluYDVRJHVIwJk8ciqS/rkHMJOUzN5gFWkEL2NqYWb3CrpBmEKbOKmtkUSn7Q
	kERsDI4smW0H5BYjwVmyv45/rWJx4JDzFmPQ7FOAnKIMjxF2S9YG4S3Gs4scRZn7KzfzjS
	ugNB7bJZgwlRdlVUOEXXx55IYEgTgDcC33GAAJbt+TfhH/XQimVkiHpHuXUuPNReCZMr5Y
	Zo7ehdJURWz3TNhCN0Px7p0LXYcCU1scd1wlAznBXN4dR2yIRBRZK4Xq0TOc4Jlshqj50q
	dJvW6m9NZs/BRS3vbZQESqR/vW/5S77Nr/lUNAhKZYNdkwqYSHdsNKzqkIYUUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718040946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NffsW6uZ57Snj3nWvpu+1CVOleFQgv1NeJ/HKebzorI=;
	b=bJeUToxXjsKqkooVL/vZcw4rQ566YQ9bse9Lm4VfEOxDd4iUNDKRgNPwoFcG+QWOBGXbTn
	LCGFKOC9C3P54sBw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] cpu: Move CPU hotplug function declarations into
 their own header
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240610003927.341707-2-tony.luck@intel.com>
References: <20240610003927.341707-2-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171804094660.10875.17112044985703584861.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     195fb517ee25bfefde9c74ecd86348eccbd6d2e4
Gitweb:        https://git.kernel.org/tip/195fb517ee25bfefde9c74ecd86348eccbd6d2e4
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Sun, 09 Jun 2024 17:39:24 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 10 Jun 2024 08:50:01 +02:00

cpu: Move CPU hotplug function declarations into their own header

Avoid upcoming #include hell when <linux/cachinfo.h> wants to use
lockdep_assert_cpus_held() and creates a #include loop that would
break the build for arch/riscv.

  [ bp: s/cpu/CPU/g ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240610003927.341707-2-tony.luck@intel.com
---
 include/linux/cpu.h       | 33 +---------------------------
 include/linux/cpuhplock.h | 47 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 32 deletions(-)
 create mode 100644 include/linux/cpuhplock.h

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 861c3bf..a8926d0 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -18,6 +18,7 @@
 #include <linux/compiler.h>
 #include <linux/cpumask.h>
 #include <linux/cpuhotplug.h>
+#include <linux/cpuhplock.h>
 #include <linux/cpu_smt.h>
 
 struct device;
@@ -132,38 +133,6 @@ static inline int add_cpu(unsigned int cpu) { return 0;}
 #endif /* CONFIG_SMP */
 extern const struct bus_type cpu_subsys;
 
-extern int lockdep_is_cpus_held(void);
-
-#ifdef CONFIG_HOTPLUG_CPU
-extern void cpus_write_lock(void);
-extern void cpus_write_unlock(void);
-extern void cpus_read_lock(void);
-extern void cpus_read_unlock(void);
-extern int  cpus_read_trylock(void);
-extern void lockdep_assert_cpus_held(void);
-extern void cpu_hotplug_disable(void);
-extern void cpu_hotplug_enable(void);
-void clear_tasks_mm_cpumask(int cpu);
-int remove_cpu(unsigned int cpu);
-int cpu_device_down(struct device *dev);
-extern void smp_shutdown_nonboot_cpus(unsigned int primary_cpu);
-
-#else /* CONFIG_HOTPLUG_CPU */
-
-static inline void cpus_write_lock(void) { }
-static inline void cpus_write_unlock(void) { }
-static inline void cpus_read_lock(void) { }
-static inline void cpus_read_unlock(void) { }
-static inline int  cpus_read_trylock(void) { return true; }
-static inline void lockdep_assert_cpus_held(void) { }
-static inline void cpu_hotplug_disable(void) { }
-static inline void cpu_hotplug_enable(void) { }
-static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
-static inline void smp_shutdown_nonboot_cpus(unsigned int primary_cpu) { }
-#endif	/* !CONFIG_HOTPLUG_CPU */
-
-DEFINE_LOCK_GUARD_0(cpus_read_lock, cpus_read_lock(), cpus_read_unlock())
-
 #ifdef CONFIG_PM_SLEEP_SMP
 extern int freeze_secondary_cpus(int primary);
 extern void thaw_secondary_cpus(void);
diff --git a/include/linux/cpuhplock.h b/include/linux/cpuhplock.h
new file mode 100644
index 0000000..386abc4
--- /dev/null
+++ b/include/linux/cpuhplock.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * include/linux/cpuhplock.h - CPU hotplug locking
+ *
+ * Locking functions for CPU hotplug.
+ */
+#ifndef _LINUX_CPUHPLOCK_H_
+#define _LINUX_CPUHPLOCK_H_
+
+#include <linux/cleanup.h>
+#include <linux/errno.h>
+
+struct device;
+
+extern int lockdep_is_cpus_held(void);
+
+#ifdef CONFIG_HOTPLUG_CPU
+extern void cpus_write_lock(void);
+extern void cpus_write_unlock(void);
+extern void cpus_read_lock(void);
+extern void cpus_read_unlock(void);
+extern int  cpus_read_trylock(void);
+extern void lockdep_assert_cpus_held(void);
+extern void cpu_hotplug_disable(void);
+extern void cpu_hotplug_enable(void);
+void clear_tasks_mm_cpumask(int cpu);
+int remove_cpu(unsigned int cpu);
+int cpu_device_down(struct device *dev);
+extern void smp_shutdown_nonboot_cpus(unsigned int primary_cpu);
+
+#else /* CONFIG_HOTPLUG_CPU */
+
+static inline void cpus_write_lock(void) { }
+static inline void cpus_write_unlock(void) { }
+static inline void cpus_read_lock(void) { }
+static inline void cpus_read_unlock(void) { }
+static inline int  cpus_read_trylock(void) { return true; }
+static inline void lockdep_assert_cpus_held(void) { }
+static inline void cpu_hotplug_disable(void) { }
+static inline void cpu_hotplug_enable(void) { }
+static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
+static inline void smp_shutdown_nonboot_cpus(unsigned int primary_cpu) { }
+#endif	/* !CONFIG_HOTPLUG_CPU */
+
+DEFINE_LOCK_GUARD_0(cpus_read_lock, cpus_read_lock(), cpus_read_unlock())
+
+#endif /* _LINUX_CPUHPLOCK_H_ */

