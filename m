Return-Path: <linux-tip-commits+bounces-1461-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B82D90D4BA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 16:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1970B1F2256B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 14:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1542B1A8C2C;
	Tue, 18 Jun 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yx17c1ey";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dqfSJ3T5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AFC1A3BA8;
	Tue, 18 Jun 2024 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719318; cv=none; b=jmDuyuUE2DRNW+vZ1fd+9E4rH3bpcLpRZrFs4qMuw4ic6IcWH39GtUHo3o7vkiMI7ru565JXrMpX/TBK1q4YydBcI/LzluENMscuJZfUCbx7TN/JmR/Yqp6zBSmvr5QPNT1NGMh3VjFPKFs6MlCHCVSgFv3TSWqRk9NBdwuQeWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719318; c=relaxed/simple;
	bh=SeuiMc6XXDeFjndhym4IZC7vlCNZdPXxNLosOweo1EY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SmIXHY0zGLC3KvSS4H0yrTODRcZmyq63zAhv8LMLRmXQXJgCsCqf3je/jWWbeH2tWTCDU2Q+wOR7adCnIF4HuWRVjM7695F7j5dVlkQIrdrg8VGkoFtgjEzLOhz1isUleChIg6PBKTiHwPBPgJfIXJEc75uJyaMUklLMHPAyTy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yx17c1ey; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dqfSJ3T5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 14:01:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718719303;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAeNJxi9D1Uyzt4D3QFkgMmnzkeKw5uv2a3T3fPHH+4=;
	b=Yx17c1ey49/dt0euabaQ5vQHLF+Anxtok6z0bY6FYLX5Yl90wjeIp3ASpBLAgm2xk4SCYH
	73twv3/TTvO7yNFgYlRKyr+TM9i3knZ8I0FB72+EY2Ztt0PLsWVZhT75Uz/uJ1afTWpseE
	AFgocbfPC8sQVrm6fB72kA9pIdR/QCyOH3uZc4eaQZ6bfb1tRHwGeXJH6x4EdFPaJydNPP
	SY8zDDeuKzkCGKWYw3vEpMnjnqWvuYISF1pe9SmlKdC9DP4bvPM3bi0qXFCaaFCL2oN+4Q
	YVAEPSh6GAg9GN43HQ7FKEx/1twRIkBwCmMAQg0thL4I/c/auB85KFH5mhsgZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718719303;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAeNJxi9D1Uyzt4D3QFkgMmnzkeKw5uv2a3T3fPHH+4=;
	b=dqfSJ3T5g6xfquJc7jrxqtAvbl9+Rzj+aKun12P9Nrgg4wI8BuifbchVKswlz/tPo52f1R
	4cN0GtI5nQYIAlDQ==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] cpu/hotplug, x86/acpi: Disable CPU offlining for ACPI
 MADT wakeup
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Tao Liu <ltao@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240614095904.1345461-5-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-5-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171871930288.10875.9766983108628834569.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     66e48e491d1e1a0f243ebfcb9639b23de1a5db5e
Gitweb:        https://git.kernel.org/tip/66e48e491d1e1a0f243ebfcb9639b23de1a5db5e
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 12:58:49 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 17:45:34 +02:00

cpu/hotplug, x86/acpi: Disable CPU offlining for ACPI MADT wakeup

ACPI MADT doesn't allow to offline a CPU after it has been woken up.

Currently, CPU hotplug is prevented based on the confidential computing
attribute which is set for Intel TDX. But TDX is not the only possible user of
the wake up method. Any platform that uses ACPI MADT wakeup method cannot
offline CPU.

Disable CPU offlining on ACPI MADT wakeup enumeration.

This has no visible effects for users: currently, TDX guest is the only platform
that uses the ACPI MADT wakeup method.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
Link: https://lore.kernel.org/r/20240614095904.1345461-5-kirill.shutemov@linux.intel.com
---
 arch/x86/coco/core.c               |  1 -
 arch/x86/kernel/acpi/madt_wakeup.c |  3 +++
 include/linux/cc_platform.h        | 10 ----------
 kernel/cpu.c                       |  3 +--
 4 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index b31ef24..0f81f70 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -29,7 +29,6 @@ static bool noinstr intel_cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
-	case CC_ATTR_HOTPLUG_DISABLED:
 	case CC_ATTR_GUEST_MEM_ENCRYPT:
 	case CC_ATTR_MEM_ENCRYPT:
 		return true;
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index cf79ea6..d222be8 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include <linux/acpi.h>
+#include <linux/cpu.h>
 #include <linux/io.h>
 #include <asm/apic.h>
 #include <asm/barrier.h>
@@ -76,6 +77,8 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
 
+	cpu_hotplug_disable_offlining();
+
 	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
 
 	return 0;
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index 60693a1..caa4b44 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -82,16 +82,6 @@ enum cc_attr {
 	CC_ATTR_GUEST_SEV_SNP,
 
 	/**
-	 * @CC_ATTR_HOTPLUG_DISABLED: Hotplug is not supported or disabled.
-	 *
-	 * The platform/OS is running as a guest/virtual machine does not
-	 * support CPU hotplug feature.
-	 *
-	 * Examples include TDX Guest.
-	 */
-	CC_ATTR_HOTPLUG_DISABLED,
-
-	/**
 	 * @CC_ATTR_HOST_SEV_SNP: AMD SNP enabled on the host.
 	 *
 	 * The host kernel is running with the necessary features
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 4c15b47..a609385 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1481,8 +1481,7 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 	 * If the platform does not support hotplug, report it explicitly to
 	 * differentiate it from a transient offlining failure.
 	 */
-	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED) ||
-	    cpu_hotplug_offline_disabled)
+	if (cpu_hotplug_offline_disabled)
 		return -EOPNOTSUPP;
 	if (cpu_hotplug_disabled)
 		return -EBUSY;

