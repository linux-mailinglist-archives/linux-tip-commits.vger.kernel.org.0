Return-Path: <linux-tip-commits+bounces-3339-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB942A299B8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Feb 2025 20:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4FE169FC3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Feb 2025 19:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894341FF61B;
	Wed,  5 Feb 2025 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WbRpkfN5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qv+w56Gk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22721FECD4;
	Wed,  5 Feb 2025 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782456; cv=none; b=K9Jh74lnOnC0Hwm1tX7+AcMDxvCcEWNt1L7MD6WuYMBTJACHvZD4Ydku9a5jFj+1Ef2IDPvJa3C914QCqWGwy9Yfnx9HYiSs4J6OrJvcdxPClLf48mFRkUEwNdTFBLZlfz1Q2qTM3vrW4KvvWrjUQ3Rku/Y+BgS7wjWVXGa+2P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782456; c=relaxed/simple;
	bh=7o4TV8Xkc+3qmt4QUi00B4hcI6yX9rdepRCVR7zSaHw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=OhRl4ZBqJZ50NG2xajuu8zKXof/P3XCfwPvTMEoPTGfMl4jdsX8sTFxu1mF/YZkz6ltMLvxd/1eh4nHC1fv1MqfGLhx9i3zEV6kVVWLPlyNRsTNgbfVCidQIAWOfDTn+ASWwW7W3+EViNuJtFYswY1/P9/Q2vNDriLnMk4M7Eeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WbRpkfN5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qv+w56Gk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Feb 2025 19:07:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738782452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=s8pMFazR6bYtF1EP09YRTG0azGpTVUDiugks/OqiOfM=;
	b=WbRpkfN5Hz17NbYXZ9fnYAfUU7EhpPQemNmKhQGXPoJMS9wroKdiknx9CbKLxUQgIVEtHh
	5wyi9v9zrWWn714ofbBP8yvvxlai+MJVP722T43KkaImjQG2qZ3ka1P11JiLehfVD9bu2f
	zJQ54fZnQl72ojvbHyNY4jOQbObqkNYr+ySBuZEA9PLTuOzPFcZIFthuib22lWictN241L
	Ea3o99KDPdILDBFkzzC+knuA562oWvEkrUOvGgq4tWyVvqOdn5cF3Iw7tcjtyu0GDyzPmQ
	YR2n3/P5pyWpQEq0z1wzOpzlD/fFjXZEXMyK/RzIY3x6kup6RPEnx7f7uheHNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738782452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=s8pMFazR6bYtF1EP09YRTG0azGpTVUDiugks/OqiOfM=;
	b=qv+w56GkDne09Uq0V5z31Nm2zPJmiui0gV+nxSYBW3EVo0/61Ikfyz7+zR0eZ/G/eDh809
	gbf0g1VA0Ykgp5BQ==
From: "tip-bot2 for Patryk Wlazlyn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] ACPI/processor_idle: Add FFH state handling
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173878245221.10177.9564511094350626139.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     541ddf31e30022b8e6f44b3a943964e8f0989d15
Gitweb:        https://git.kernel.org/tip/541ddf31e30022b8e6f44b3a943964e8f0989d15
Author:        Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
AuthorDate:    Wed, 05 Feb 2025 17:52:09 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 05 Feb 2025 10:44:52 -08:00

ACPI/processor_idle: Add FFH state handling

Recent Intel platforms will depend on the idle driver to pass the
correct hint for playing dead via mwait_play_dead_with_hint(). Expand
the existing enter_dead interface with handling for FFH states and pass
the MWAIT hint to the mwait_play_dead code.

Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/all/20250205155211.329780-3-artem.bityutskiy%40linux.intel.com
---
 arch/x86/kernel/acpi/cstate.c | 10 ++++++++++
 drivers/acpi/processor_idle.c |  2 ++
 include/acpi/processor.h      |  5 +++++
 3 files changed, 17 insertions(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 5854f0b..5bdb655 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -16,6 +16,7 @@
 #include <asm/cpuid.h>
 #include <asm/mwait.h>
 #include <asm/special_insns.h>
+#include <asm/smp.h>
 
 /*
  * Initialize bm_flags based on the CPU cache properties
@@ -205,6 +206,15 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 }
 EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_probe);
 
+void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
+{
+	unsigned int cpu = smp_processor_id();
+	struct cstate_entry *percpu_entry;
+
+	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
+	mwait_play_dead(percpu_entry->states[cx->index].eax);
+}
+
 void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
 {
 	unsigned int cpu = smp_processor_id();
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 698897b..586cc7d 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -590,6 +590,8 @@ static void acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 			raw_safe_halt();
 		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
 			io_idle(cx->address);
+		} else if (cx->entry_method == ACPI_CSTATE_FFH) {
+			acpi_processor_ffh_play_dead(cx);
 		} else
 			return;
 	}
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index a17e97e..63a37e7 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -280,6 +280,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 				    struct acpi_processor_cx *cx,
 				    struct acpi_power_register *reg);
 void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cstate);
+void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx);
 #else
 static inline void acpi_processor_power_init_bm_check(struct
 						      acpi_processor_flags
@@ -300,6 +301,10 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
 {
 	return;
 }
+static inline void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
+{
+	return;
+}
 #endif
 
 static inline int call_on_cpu(int cpu, long (*fn)(void *), void *arg,

