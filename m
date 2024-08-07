Return-Path: <linux-tip-commits+bounces-2025-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DA094D073
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Aug 2024 14:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582321F21FC3
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Aug 2024 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A56194C89;
	Fri,  9 Aug 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RjY/UVK6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ur547LM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77DE19046B;
	Fri,  9 Aug 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207534; cv=none; b=PyV2uXimY0zu+Mg0wUarR7Nz6JXr6FxzHeE0zqyOIxpWjhYVMQBVsFAss0SA0hUm1pc9N9gkVSAdwRUmqMsS31RJhxuSyJ00hymucwE14zf0MqisAPkkDSrA/K4kQkyjO2+B2wKR+sGmX2hO1w047hk8y3NuNJjyl0/cOfR24X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207534; c=relaxed/simple;
	bh=TWZ+kAKZUmEZ+awAV/l7dZNHcssqps+lkUJpULyQYp8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tgmJ9tNyOEtxMr3EqnvdW5xhNQuCdbLxOGWPJijIpJZi66zUlIWJKEIR34phQfOXHF2l5mnYtJNPWiXPJkD3fnBrbGK1vX2xzEvBtJfS4MKRcDTxca/lR2FJu5oFQ6rEbyZhtSbRc49t+5YLEBMcoXi7ekmChEynhO2oRC/aaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RjY/UVK6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ur547LM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 09 Aug 2024 12:45:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723207531;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STRJU+gcIQkS2T+RIrDw4AoOCXN1FJFRZyuPoBCu3qQ=;
	b=RjY/UVK6uaWWSPF/PzNQ+UCLHXeYKTuSIYRvgrLt5GYazkH8kx0XhLG/ZEdwz8uoz3apLc
	fuZzCxdql4kwSZziHlnMTt3VpyqouD1HAj50L7o9Apr2+emcbiiY//A/GZ8+tAByal0LaU
	ali70igWgcwbBCwmIbfl75z8LDCbRZ6+dV6AEa57qjiG62K2CBld+swdJa5ALheJV/9yW8
	gZpV+gZjs4COhKqoYbhWaYOpHxXZmvCii3rCFCtROXcv2dik8skLbYAl00dGoC6o7CClCi
	pgzsSYRnwQ/LzTsI/DupqEN5TY4h9cPaibyC80xKnoY8m06eGBoLI6pxUFxA5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723207531;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STRJU+gcIQkS2T+RIrDw4AoOCXN1FJFRZyuPoBCu3qQ=;
	b=3ur547LMhYy+ZA151kE7mXCjm8ht3kNqOVbvRzAb6zx0lgV2lE1yl7n5Mb+5UfQYdghvQF
	CyV9gvjoizCJeIBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Remove logical destination mode for 64-bit
Cc: Rob Newcater <rob@durendal.co.uk>, Christian Heusel <christian@heusel.eu>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <877cd5u671.ffs@tglx>
References: <877cd5u671.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172320753038.2215.9554166329388312328.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     838ba7733e4e3a94a928e8d0a058de1811a58621
Gitweb:        https://git.kernel.org/tip/838ba7733e4e3a94a928e8d0a058de1811a58621
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 28 Jul 2024 13:06:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 09 Aug 2024 14:34:16 +02:00

x86/apic: Remove logical destination mode for 64-bit

Logical destination mode of the local APIC is used for systems with up to
8 CPUs. It has an advantage over physical destination mode as it allows to
target multiple CPUs at once with IPIs.

That advantage was definitely worth it when systems with up to 8 CPUs
were state of the art for servers and workstations, but that's history.

Aside of that there are systems which fail to work with logical destination
mode as the ACPI/DMI quirks show and there are AMD Zen1 systems out there
which fail when interrupt remapping is enabled as reported by Rob and
Christian. The latter problem can be cured by firmware updates, but not all
OEMs distribute the required changes.

Physical destination mode is guaranteed to work because it is the only way
to get a CPU up and running via the INIT/INIT/STARTUP sequence.

As the number of CPUs keeps increasing, logical destination mode becomes a
less used code path so there is no real good reason to keep it around.

Therefore remove logical destination mode support for 64-bit and default to
physical destination mode.

Reported-by: Rob Newcater <rob@durendal.co.uk>
Reported-by: Christian Heusel <christian@heusel.eu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Rob Newcater <rob@durendal.co.uk>
Link: https://lore.kernel.org/all/877cd5u671.ffs@tglx

---
 arch/x86/include/asm/apic.h         |   8 +--
 arch/x86/kernel/apic/apic_flat_64.c | 119 +--------------------------
 2 files changed, 7 insertions(+), 120 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9dd22ee..53f0844 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -350,20 +350,12 @@ extern struct apic *apic;
  * APIC drivers are probed based on how they are listed in the .apicdrivers
  * section. So the order is important and enforced by the ordering
  * of different apic driver files in the Makefile.
- *
- * For the files having two apic drivers, we use apic_drivers()
- * to enforce the order with in them.
  */
 #define apic_driver(sym)					\
 	static const struct apic *__apicdrivers_##sym __used		\
 	__aligned(sizeof(struct apic *))			\
 	__section(".apicdrivers") = { &sym }
 
-#define apic_drivers(sym1, sym2)					\
-	static struct apic *__apicdrivers_##sym1##sym2[2] __used	\
-	__aligned(sizeof(struct apic *))				\
-	__section(".apicdrivers") = { &sym1, &sym2 }
-
 extern struct apic *__apicdrivers[], *__apicdrivers_end[];
 
 /*
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index f37ad33..e0308d8 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -8,129 +8,25 @@
  * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
  * James Cleverdon.
  */
-#include <linux/cpumask.h>
 #include <linux/export.h>
-#include <linux/acpi.h>
 
-#include <asm/jailhouse_para.h>
 #include <asm/apic.h>
 
 #include "local.h"
 
-static struct apic apic_physflat;
-static struct apic apic_flat;
-
-struct apic *apic __ro_after_init = &apic_flat;
-EXPORT_SYMBOL_GPL(apic);
-
-static int flat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
-{
-	return 1;
-}
-
-static void _flat_send_IPI_mask(unsigned long mask, int vector)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__default_send_IPI_dest_field(mask, vector, APIC_DEST_LOGICAL);
-	local_irq_restore(flags);
-}
-
-static void flat_send_IPI_mask(const struct cpumask *cpumask, int vector)
-{
-	unsigned long mask = cpumask_bits(cpumask)[0];
-
-	_flat_send_IPI_mask(mask, vector);
-}
-
-static void
-flat_send_IPI_mask_allbutself(const struct cpumask *cpumask, int vector)
-{
-	unsigned long mask = cpumask_bits(cpumask)[0];
-	int cpu = smp_processor_id();
-
-	if (cpu < BITS_PER_LONG)
-		__clear_bit(cpu, &mask);
-
-	_flat_send_IPI_mask(mask, vector);
-}
-
-static u32 flat_get_apic_id(u32 x)
+static u32 physflat_get_apic_id(u32 x)
 {
 	return (x >> 24) & 0xFF;
 }
 
-static int flat_probe(void)
+static int physflat_probe(void)
 {
 	return 1;
 }
 
-static struct apic apic_flat __ro_after_init = {
-	.name				= "flat",
-	.probe				= flat_probe,
-	.acpi_madt_oem_check		= flat_acpi_madt_oem_check,
-
-	.dest_mode_logical		= true,
-
-	.disable_esr			= 0,
-
-	.init_apic_ldr			= default_init_apic_ldr,
-	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-
-	.max_apic_id			= 0xFE,
-	.get_apic_id			= flat_get_apic_id,
-
-	.calc_dest_apicid		= apic_flat_calc_apicid,
-
-	.send_IPI			= default_send_IPI_single,
-	.send_IPI_mask			= flat_send_IPI_mask,
-	.send_IPI_mask_allbutself	= flat_send_IPI_mask_allbutself,
-	.send_IPI_allbutself		= default_send_IPI_allbutself,
-	.send_IPI_all			= default_send_IPI_all,
-	.send_IPI_self			= default_send_IPI_self,
-	.nmi_to_offline_cpu		= true,
-
-	.read				= native_apic_mem_read,
-	.write				= native_apic_mem_write,
-	.eoi				= native_apic_mem_eoi,
-	.icr_read			= native_apic_icr_read,
-	.icr_write			= native_apic_icr_write,
-	.wait_icr_idle			= apic_mem_wait_icr_idle,
-	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
-};
-
-/*
- * Physflat mode is used when there are more than 8 CPUs on a system.
- * We cannot use logical delivery in this case because the mask
- * overflows, so use physical mode.
- */
 static int physflat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
-#ifdef CONFIG_ACPI
-	/*
-	 * Quirk: some x86_64 machines can only use physical APIC mode
-	 * regardless of how many processors are present (x86_64 ES7000
-	 * is an example).
-	 */
-	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
-		(acpi_gbl_FADT.flags & ACPI_FADT_APIC_PHYSICAL)) {
-		printk(KERN_DEBUG "system APIC only can use physical flat");
-		return 1;
-	}
-
-	if (!strncmp(oem_id, "IBM", 3) && !strncmp(oem_table_id, "EXA", 3)) {
-		printk(KERN_DEBUG "IBM Summit detected, will use apic physical");
-		return 1;
-	}
-#endif
-
-	return 0;
-}
-
-static int physflat_probe(void)
-{
-	return apic == &apic_physflat || num_possible_cpus() > 8 || jailhouse_paravirt();
+	return 1;
 }
 
 static struct apic apic_physflat __ro_after_init = {
@@ -146,7 +42,7 @@ static struct apic apic_physflat __ro_after_init = {
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
 	.max_apic_id			= 0xFE,
-	.get_apic_id			= flat_get_apic_id,
+	.get_apic_id			= physflat_get_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
@@ -166,8 +62,7 @@ static struct apic apic_physflat __ro_after_init = {
 	.wait_icr_idle			= apic_mem_wait_icr_idle,
 	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
 };
+apic_driver(apic_physflat);
 
-/*
- * We need to check for physflat first, so this order is important.
- */
-apic_drivers(apic_physflat, apic_flat);
+struct apic *apic __ro_after_init = &apic_physflat;
+EXPORT_SYMBOL_GPL(apic);

