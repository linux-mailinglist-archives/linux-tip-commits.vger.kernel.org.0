Return-Path: <linux-tip-commits+bounces-5841-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD9AAD8D23
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 15:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B26E178694
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 13:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382E11684B0;
	Fri, 13 Jun 2025 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y6E0PJMk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="utS98oRJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA0A111BF;
	Fri, 13 Jun 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749821668; cv=none; b=B06mjhKf5WS8ue5m+sNcZQYxiSQtWDh7DQxpfvlIYfyhErCGWCZFykBL0EIsEqGygb7dm47IOtvIyZhXiUjUmcy15Bfpcvp+ySdHrkUbUjD3ir4FNSj3gl3Skc9TyUJDZxdFYl4eHGhW4GYhlRryPRVFQMPb7XsdRgDcrTgYa0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749821668; c=relaxed/simple;
	bh=DzekLg4ogQqGHeU4BJBAAIpiIRB/63eE9WUwrESlAKw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Aj+fDA1290ZxbOjmXMJT3w1Q2lokmBRcUCM9Qz2r3wAut87Hn/Ab70UFGpQcgJbpkVRjpGD2CD+SeGi4lyJlEXiGDIE4gI1146ud6mL+zHi3+krDL6/uBAPW4V5DVgCbSM0prECHJ83yPuPHBjeJCOiBIt/4RLJ7LwjJYZyNCis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y6E0PJMk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=utS98oRJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 13:34:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749821664;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lvop4LhiUuD6oRvV0/+e41u7SqyJ4z7NIpldjIYKGrs=;
	b=Y6E0PJMkuA9qWbiNZ594+XHJteFbcDSokipDzlW7nvaTQPyI7jLdL3co+auoffFLfrG7nR
	x+bveLqTfMRBZUXmrMje7mi6Akg9Gcw+drc3vGFPqCIVfok4eqfpdZTyikK1wSQFfKcPtn
	JPkizEJRbqHfqVYYM9/AJuNZnivlaUcua/YFF0RfzCTkREGyYG+UwPXoEnjsUHOtVm8XaU
	eT/ZGavgMIAC3UNhvOwwSVn4h6FUda02tAUJWzS6uAmexIRy+5aXWvL+Vlkq9eaGPJO2nd
	VsNMsthcb9AVBhs/k4RHoKRvFB81Xjij4C6NqMY8UP2kn7m+NiVquUtuD8SIjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749821664;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lvop4LhiUuD6oRvV0/+e41u7SqyJ4z7NIpldjIYKGrs=;
	b=utS98oRJF4hgTrdcgN8g48giG3+SU7Bq9bU3Nirbv15N46jC9qcEYg2nyJsrFizNTGHg/o
	8yLttCRmq26oWSCQ==
From: "tip-bot2 for Brian Norris" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Add kunit tests for depth counts
Cc: Brian Norris <briannorris@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250522210837.4135244-1-briannorris@chromium.org>
References: <20250522210837.4135244-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174982166320.406.9706547589240701893.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     66067c3c8a1ee097e9c30e8bbd643b12ba54a6b0
Gitweb:        https://git.kernel.org/tip/66067c3c8a1ee097e9c30e8bbd643b12ba54a6b0
Author:        Brian Norris <briannorris@chromium.org>
AuthorDate:    Thu, 22 May 2025 14:08:01 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 Jun 2025 15:24:44 +02:00

genirq: Add kunit tests for depth counts

There have been a few bugs and/or misunderstandings about the reference
counting, and startup/shutdown behaviors in the IRQ core and related CPU
hotplug code. These 4 test cases try to capture a few interesting cases.

 * irq_disable_depth_test: basic request/disable/enable sequence

 * irq_free_disabled_test: request/disable/free/re-request sequence -
   this catches errors on previous revisions of my work

 * irq_cpuhotplug_test: exercises managed-affinity IRQ + CPU hotplug.
   This captures a problematic test case which was fixed recently.
   This test requires CONFIG_SMP and a hotpluggable CPU#1.

 * irq_shutdown_depth_test: exercises similar behavior from
   irq_cpuhotplug_test, but directly using irq_*() APIs instead of going
   through CPU hotplug. This still requires CONFIG_SMP, because
   managed-affinity is stubbed out (and not all APIs are even present)
   without it.

Note the use of 'imply SMP': ARCH=um doesn't support SMP, and kunit is
often exercised there. Thus, 'imply' will force SMP on where possible
(such as ARCH=x86_64), but leave it off where it's not.

Behavior on various SMP and ARCH configurations:

  $ tools/testing/kunit/kunit.py run 'irq_test_cases*' --arch x86_64 --qemu_args '-smp 2'
  [...]
  [11:12:24] Testing complete. Ran 4 tests: passed: 4

  $ tools/testing/kunit/kunit.py run 'irq_test_cases*' --arch x86_64
  [...]
  [11:13:27] [SKIPPED] irq_cpuhotplug_test
  [11:13:27] ================= [PASSED] irq_test_cases ==================
  [11:13:27] ============================================================
  [11:13:27] Testing complete. Ran 4 tests: passed: 3, skipped: 1

  # default: ARCH=um
  $ tools/testing/kunit/kunit.py run 'irq_test_cases*'
  [11:14:26] [SKIPPED] irq_shutdown_depth_test
  [11:14:26] [SKIPPED] irq_cpuhotplug_test
  [11:14:26] ================= [PASSED] irq_test_cases ==================
  [11:14:26] ============================================================
  [11:14:26] Testing complete. Ran 4 tests: passed: 2, skipped: 2

Without commit 788019eb559f ("genirq: Retain disable depth for managed
interrupts across CPU hotplug"), this fails as follows:

  [11:18:55] =============== irq_test_cases (4 subtests) ================
  [11:18:55] [PASSED] irq_disable_depth_test
  [11:18:55] [PASSED] irq_free_disabled_test
  [11:18:55]     # irq_shutdown_depth_test: EXPECTATION FAILED at kernel/irq/irq_test.c:147
  [11:18:55]     Expected desc->depth == 1, but
  [11:18:55]         desc->depth == 0 (0x0)
  [11:18:55] ------------[ cut here ]------------
  [11:18:55] Unbalanced enable for IRQ 26
  [11:18:55] WARNING: CPU: 1 PID: 36 at kernel/irq/manage.c:792 __enable_irq+0x36/0x60
  ...
  [11:18:55] [FAILED] irq_shutdown_depth_test
  [11:18:55]  #1
  [11:18:55]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:202
  [11:18:55]     Expected irqd_is_activated(data) to be false, but is true
  [11:18:55]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:203
  [11:18:55]     Expected irqd_is_started(data) to be false, but is true
  [11:18:55]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:204
  [11:18:55]     Expected desc->depth == 1, but
  [11:18:55]         desc->depth == 0 (0x0)
  [11:18:55] ------------[ cut here ]------------
  [11:18:55] Unbalanced enable for IRQ 27
  [11:18:55] WARNING: CPU: 0 PID: 38 at kernel/irq/manage.c:792 __enable_irq+0x36/0x60
  ...
  [11:18:55] [FAILED] irq_cpuhotplug_test
  [11:18:55]     # module: irq_test
  [11:18:55] # irq_test_cases: pass:2 fail:2 skip:0 total:4
  [11:18:55] # Totals: pass:2 fail:2 skip:0 total:4
  [11:18:55] ================= [FAILED] irq_test_cases ==================
  [11:18:55] ============================================================
  [11:18:55] Testing complete. Ran 4 tests: passed: 2, failed: 2

Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250522210837.4135244-1-briannorris@chromium.org

---
 kernel/irq/Kconfig    |  11 ++-
 kernel/irq/Makefile   |   1 +-
 kernel/irq/irq_test.c | 229 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 241 insertions(+)
 create mode 100644 kernel/irq/irq_test.c

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 3f02a0e..1da5e9d 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -144,6 +144,17 @@ config GENERIC_IRQ_DEBUGFS
 config GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
 	bool
 
+config IRQ_KUNIT_TEST
+	bool "KUnit tests for IRQ management APIs" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y
+	default KUNIT_ALL_TESTS
+	imply SMP
+	help
+	  This option enables KUnit tests for the IRQ subsystem API. These are
+	  only for development and testing, not for regular kernel use cases.
+
+	  If unsure, say N.
+
 endmenu
 
 config GENERIC_IRQ_MULTI_HANDLER
diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index c0f44c0..6ab3a40 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_GENERIC_IRQ_IPI_MUX) += ipi-mux.o
 obj-$(CONFIG_SMP) += affinity.o
 obj-$(CONFIG_GENERIC_IRQ_DEBUGFS) += debugfs.o
 obj-$(CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR) += matrix.o
+obj-$(CONFIG_IRQ_KUNIT_TEST) += irq_test.o
diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
new file mode 100644
index 0000000..5161b56
--- /dev/null
+++ b/kernel/irq/irq_test.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: LGPL-2.1+
+
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/irqdomain.h>
+#include <linux/nodemask.h>
+#include <kunit/test.h>
+
+#include "internals.h"
+
+static irqreturn_t noop_handler(int irq, void *data)
+{
+	return IRQ_HANDLED;
+}
+
+static void noop(struct irq_data *data) { }
+static unsigned int noop_ret(struct irq_data *data) { return 0; }
+
+static int noop_affinity(struct irq_data *data, const struct cpumask *dest,
+			 bool force)
+{
+	irq_data_update_effective_affinity(data, dest);
+
+	return 0;
+}
+
+static struct irq_chip fake_irq_chip = {
+	.name           = "fake",
+	.irq_startup    = noop_ret,
+	.irq_shutdown   = noop,
+	.irq_enable     = noop,
+	.irq_disable    = noop,
+	.irq_ack        = noop,
+	.irq_mask       = noop,
+	.irq_unmask     = noop,
+	.irq_set_affinity = noop_affinity,
+	.flags          = IRQCHIP_SKIP_SET_WAKE,
+};
+
+static void irq_disable_depth_test(struct kunit *test)
+{
+	struct irq_desc *desc;
+	int virq, ret;
+
+	virq = irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, NULL);
+	KUNIT_ASSERT_GE(test, virq, 0);
+
+	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+
+	desc = irq_to_desc(virq);
+	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
+
+	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, desc->depth, 0);
+
+	disable_irq(virq);
+	KUNIT_EXPECT_EQ(test, desc->depth, 1);
+
+	enable_irq(virq);
+	KUNIT_EXPECT_EQ(test, desc->depth, 0);
+
+	free_irq(virq, NULL);
+}
+
+static void irq_free_disabled_test(struct kunit *test)
+{
+	struct irq_desc *desc;
+	int virq, ret;
+
+	virq = irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, NULL);
+	KUNIT_ASSERT_GE(test, virq, 0);
+
+	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+
+	desc = irq_to_desc(virq);
+	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
+
+	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, desc->depth, 0);
+
+	disable_irq(virq);
+	KUNIT_EXPECT_EQ(test, desc->depth, 1);
+
+	free_irq(virq, NULL);
+	KUNIT_EXPECT_GE(test, desc->depth, 1);
+
+	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, desc->depth, 0);
+
+	free_irq(virq, NULL);
+}
+
+static void irq_shutdown_depth_test(struct kunit *test)
+{
+	struct irq_desc *desc;
+	struct irq_data *data;
+	int virq, ret;
+	struct irq_affinity_desc affinity = {
+		.is_managed = 1,
+		.mask = CPU_MASK_ALL,
+	};
+
+	if (!IS_ENABLED(CONFIG_SMP))
+		kunit_skip(test, "requires CONFIG_SMP for managed shutdown");
+
+	virq = irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, &affinity);
+	KUNIT_ASSERT_GE(test, virq, 0);
+
+	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+
+	desc = irq_to_desc(virq);
+	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
+
+	data = irq_desc_get_irq_data(desc);
+	KUNIT_ASSERT_PTR_NE(test, data, NULL);
+
+	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_TRUE(test, irqd_is_activated(data));
+	KUNIT_EXPECT_TRUE(test, irqd_is_started(data));
+	KUNIT_EXPECT_TRUE(test, irqd_affinity_is_managed(data));
+
+	KUNIT_EXPECT_EQ(test, desc->depth, 0);
+
+	disable_irq(virq);
+	KUNIT_EXPECT_EQ(test, desc->depth, 1);
+
+	irq_shutdown_and_deactivate(desc);
+
+	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
+	KUNIT_EXPECT_FALSE(test, irqd_is_started(data));
+
+	KUNIT_EXPECT_EQ(test, irq_activate(desc), 0);
+#ifdef CONFIG_SMP
+	irq_startup_managed(desc);
+#endif
+
+	KUNIT_EXPECT_EQ(test, desc->depth, 1);
+
+	enable_irq(virq);
+	KUNIT_EXPECT_EQ(test, desc->depth, 0);
+
+	free_irq(virq, NULL);
+}
+
+static void irq_cpuhotplug_test(struct kunit *test)
+{
+	struct irq_desc *desc;
+	struct irq_data *data;
+	int virq, ret;
+	struct irq_affinity_desc affinity = {
+		.is_managed = 1,
+	};
+
+	if (!IS_ENABLED(CONFIG_SMP))
+		kunit_skip(test, "requires CONFIG_SMP for CPU hotplug");
+	if (!get_cpu_device(1))
+		kunit_skip(test, "requires more than 1 CPU for CPU hotplug");
+	if (!cpu_is_hotpluggable(1))
+		kunit_skip(test, "CPU 1 must be hotpluggable");
+
+	cpumask_copy(&affinity.mask, cpumask_of(1));
+
+	virq = irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, &affinity);
+	KUNIT_ASSERT_GE(test, virq, 0);
+
+	irq_set_chip_and_handler(virq, &fake_irq_chip, handle_simple_irq);
+
+	desc = irq_to_desc(virq);
+	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
+
+	data = irq_desc_get_irq_data(desc);
+	KUNIT_ASSERT_PTR_NE(test, data, NULL);
+
+	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_TRUE(test, irqd_is_activated(data));
+	KUNIT_EXPECT_TRUE(test, irqd_is_started(data));
+	KUNIT_EXPECT_TRUE(test, irqd_affinity_is_managed(data));
+
+	KUNIT_EXPECT_EQ(test, desc->depth, 0);
+
+	disable_irq(virq);
+	KUNIT_EXPECT_EQ(test, desc->depth, 1);
+
+	KUNIT_EXPECT_EQ(test, remove_cpu(1), 0);
+	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
+	KUNIT_EXPECT_FALSE(test, irqd_is_started(data));
+	KUNIT_EXPECT_GE(test, desc->depth, 1);
+	KUNIT_EXPECT_EQ(test, add_cpu(1), 0);
+
+	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
+	KUNIT_EXPECT_FALSE(test, irqd_is_started(data));
+	KUNIT_EXPECT_EQ(test, desc->depth, 1);
+
+	enable_irq(virq);
+	KUNIT_EXPECT_TRUE(test, irqd_is_activated(data));
+	KUNIT_EXPECT_TRUE(test, irqd_is_started(data));
+	KUNIT_EXPECT_EQ(test, desc->depth, 0);
+
+	free_irq(virq, NULL);
+}
+
+static struct kunit_case irq_test_cases[] = {
+	KUNIT_CASE(irq_disable_depth_test),
+	KUNIT_CASE(irq_free_disabled_test),
+	KUNIT_CASE(irq_shutdown_depth_test),
+	KUNIT_CASE(irq_cpuhotplug_test),
+	{}
+};
+
+static struct kunit_suite irq_test_suite = {
+	.name = "irq_test_cases",
+	.test_cases = irq_test_cases,
+};
+
+kunit_test_suite(irq_test_suite);
+MODULE_DESCRIPTION("IRQ unit test suite");
+MODULE_LICENSE("GPL");

