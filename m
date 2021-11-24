Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5B645D15B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Nov 2021 00:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhKXXtN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 24 Nov 2021 18:49:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48070 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbhKXXtF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 24 Nov 2021 18:49:05 -0500
Date:   Wed, 24 Nov 2021 23:45:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637797553;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cj/yHF+aEiHT7ltO6bub750gmEGy0Oqz0iH7mf0KKrM=;
        b=jaApxFdu9Sch9kohAlaXXRUAqBu7Swrs56sXjUXa3d1v9f0BEu5rGcDhjPOuPwyhb5QxsF
        p7kGXC1rDHCxgIs6FCw+m1+nycHpx0CxcKhglGtLb/6r5EGGWg1bNAeq4bJcH8dJnYvHbY
        xVBb20l4WMubZJgO1j3NZfys4kPONuAMUd0LIi/HRSECXADdSWOokjEqgd29W6p1qJxElT
        4QuLQeefKy73MOCY1kP70aGYu1XQbEpoZ7wyozgl7JVuT83dck/Pjzhqyg7zbkXDYv75Q8
        9nSto1lJoeyeol7M5TnBaAg07v8yTk6gUME03FJ28YTPb5DigsXhZ5k23aNSzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637797553;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cj/yHF+aEiHT7ltO6bub750gmEGy0Oqz0iH7mf0KKrM=;
        b=MoJf+WFR+VwIb2WOkzgE/lkp0jx4LAzMmcPnk6E/IgvKRjqsGfJw6ufx6eJ6m0UydxLl4x
        RWwnP8h5C3DuJHBQ==
From:   "tip-bot2 for Andi Kleen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Don't write CSTAR MSR on Intel CPUs
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211119035803.4012145-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211119035803.4012145-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163779755239.11128.2009262993984624532.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     9c7e2634f647630db4e0719391dd80cd81132a66
Gitweb:        https://git.kernel.org/tip/9c7e2634f647630db4e0719391dd80cd81132a66
Author:        Andi Kleen <ak@linux.intel.com>
AuthorDate:    Thu, 18 Nov 2021 19:58:03 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Nov 2021 00:40:34 +01:00

x86/cpu: Don't write CSTAR MSR on Intel CPUs

Intel CPUs do not support SYSCALL in 32-bit mode, but the kernel
initializes MSR_CSTAR unconditionally. That MSR write is normally
ignored by the CPU, but in a TDX guest it raises a #VE trap.

Exclude Intel CPUs from the MSR_CSTAR initialization.

[ tglx: Fixed the subject line and removed the redundant comment. ]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20211119035803.4012145-1-sathyanarayanan.kuppuswamy@linux.intel.com

---
 arch/x86/kernel/cpu/common.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0083464..0663642 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1787,6 +1787,17 @@ EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
 DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_STACK;
 
+static void wrmsrl_cstar(unsigned long val)
+{
+	/*
+	 * Intel CPUs do not support 32-bit SYSCALL. Writing to MSR_CSTAR
+	 * is so far ignored by the CPU, but raises a #VE trap in a TDX
+	 * guest. Avoid the pointless write on all Intel CPUs.
+	 */
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		wrmsrl(MSR_CSTAR, val);
+}
+
 /* May not be marked __init: used by software suspend */
 void syscall_init(void)
 {
@@ -1794,7 +1805,7 @@ void syscall_init(void)
 	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
 
 #ifdef CONFIG_IA32_EMULATION
-	wrmsrl(MSR_CSTAR, (unsigned long)entry_SYSCALL_compat);
+	wrmsrl_cstar((unsigned long)entry_SYSCALL_compat);
 	/*
 	 * This only works on Intel CPUs.
 	 * On AMD CPUs these MSRs are 32-bit, CPU truncates MSR_IA32_SYSENTER_EIP.
@@ -1806,7 +1817,7 @@ void syscall_init(void)
 		    (unsigned long)(cpu_entry_stack(smp_processor_id()) + 1));
 	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_compat);
 #else
-	wrmsrl(MSR_CSTAR, (unsigned long)ignore_sysret);
+	wrmsrl_cstar((unsigned long)ignore_sysret);
 	wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);
 	wrmsrl_safe(MSR_IA32_SYSENTER_ESP, 0ULL);
 	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
