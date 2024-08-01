Return-Path: <linux-tip-commits+bounces-1903-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 594A39450DA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Aug 2024 18:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6535B29820
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Aug 2024 16:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7792D1BC09D;
	Thu,  1 Aug 2024 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uSottXwt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="crO/vnAL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902421BC091;
	Thu,  1 Aug 2024 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530135; cv=none; b=J2Yc2ogxr0SpDtWb/FsH+Y9uiIykRnwyRiV08DfDTAnEJkXvdIZS3ZVRDWZIHEognQadWjnI4ZKrDDBaDNHqVxKgg4Jy9vmf/PvZy4ZWdDxn+r1oT9qsjVi1iidu1Dm93qo83hO+TCNQFSZzr/qiROUHCkB9hsV6l8kX4g8VZT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530135; c=relaxed/simple;
	bh=0Lfx1WVgwRxf1gQh7kwV7t7BdlI9ig0l0ULy/fkNVLw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wfi21NzIBKZ0x6KS50AJoUjCA3lceqRahjwr1e/O+rhXusmvZsySk+G0cHumy4frtuBtZ3UxE3mBr0t6r08vdIYC/mKbBbUJiRzV5jCyaHVOVdOouND1utIoZGh3tf+6wSy0LAlzAwPAL1G1LJa5iIZHY0IEyy5JPqboohq6Pu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uSottXwt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=crO/vnAL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 01 Aug 2024 16:35:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722530131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMS6Rh4AdYXsJAxbP/xam9UWNoPS5vyVFd5JLNmBres=;
	b=uSottXwtkajH6kaNob23dNRPoTDx5L4v7XwVzL8I47zECFOsNxKs05Mx0S07Kb6QmyYFio
	S2gaRCftlob2hgQ6zD6aGqncA3jI5Fdl8KBGzp/BHThFqIUq1vJldrvoTDPqsLTZTc7fxN
	8HI6sS1H4E2CnNbVWFCzhK51pV1ldsxnpgL4FBkft6mHEKvH+2dk+EOQMIrcGtI+fKyq+J
	uNlNrgseCZ2jIiSU8JMFUhloZB2FLtqDXctgC8M0+pP+BpHUTUUZMPB1jHDmOCGwLgHvyG
	IVy+tBoZ8Msxjb6gsp3eO093Q7SIKgDdh32Smgq3Q0uX2Vt+xzCilMXGrGu7iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722530131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMS6Rh4AdYXsJAxbP/xam9UWNoPS5vyVFd5JLNmBres=;
	b=crO/vnALldNmzddUdNYeNkdQr5SiX6wzZcPqoFv+HzQ+j+e0pLzof5s6WvjsGu3AVP6GvN
	bPfi8EBn+7xoB7CQ==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Define mce_prep_record() helpers for common
 and per-CPU fields
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240730182958.4117158-3-yazen.ghannam@amd.com>
References: <20240730182958.4117158-3-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172253013144.2215.3708689740044304266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     f9bbb8ad0c8b2f37e3d474b8693f563e4a29e92e
Gitweb:        https://git.kernel.org/tip/f9bbb8ad0c8b2f37e3d474b8693f563e4a29e92e
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 30 Jul 2024 13:29:57 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 01 Aug 2024 18:20:25 +02:00

x86/mce: Define mce_prep_record() helpers for common and per-CPU fields

Generally, MCA information for an error is gathered on the CPU that
reported the error. In this case, CPU-specific information from the
running CPU will be correct.

However, this will be incorrect if the MCA information is gathered while
running on a CPU that didn't report the error. One example is creating
an MCA record using mce_prep_record() for errors reported from ACPI.

Split mce_prep_record() so that there is a helper function to gather
common, i.e. not CPU-specific, information and another helper for
CPU-specific information.

Leave mce_prep_record() defined as-is for the common case when running
on the reporting CPU.

Get MCG_CAP in the global helper even though the register is per-CPU.
This value is not already cached per-CPU like other values. And it does
not assist with any per-CPU decoding or handling.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20240730182958.4117158-3-yazen.ghannam@amd.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/mce/core.c     | 34 +++++++++++++++++++----------
 arch/x86/kernel/cpu/mce/internal.h |  2 ++-
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index dd5192e..2a938f4 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -117,20 +117,32 @@ static struct irq_work mce_irq_work;
  */
 BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
 
-/* Do initial initialization of a struct mce */
-void mce_prep_record(struct mce *m)
+void mce_prep_record_common(struct mce *m)
 {
 	memset(m, 0, sizeof(struct mce));
-	m->cpu = m->extcpu = smp_processor_id();
+
+	m->cpuid	= cpuid_eax(1);
+	m->cpuvendor	= boot_cpu_data.x86_vendor;
+	m->mcgcap	= __rdmsr(MSR_IA32_MCG_CAP);
 	/* need the internal __ version to avoid deadlocks */
-	m->time = __ktime_get_real_seconds();
-	m->cpuvendor = boot_cpu_data.x86_vendor;
-	m->cpuid = cpuid_eax(1);
-	m->socketid = cpu_data(m->extcpu).topo.pkg_id;
-	m->apicid = cpu_data(m->extcpu).topo.initial_apicid;
-	m->mcgcap = __rdmsr(MSR_IA32_MCG_CAP);
-	m->ppin = cpu_data(m->extcpu).ppin;
-	m->microcode = boot_cpu_data.microcode;
+	m->time		= __ktime_get_real_seconds();
+}
+
+void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m)
+{
+	m->cpu		= cpu;
+	m->extcpu	= cpu;
+	m->apicid	= cpu_data(cpu).topo.initial_apicid;
+	m->microcode	= cpu_data(cpu).microcode;
+	m->ppin		= topology_ppin(cpu);
+	m->socketid	= topology_physical_package_id(cpu);
+}
+
+/* Do initial initialization of a struct mce */
+void mce_prep_record(struct mce *m)
+{
+	mce_prep_record_common(m);
+	mce_prep_record_per_cpu(smp_processor_id(), m);
 }
 
 DEFINE_PER_CPU(struct mce, injectm);
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 01f8f03..43c7f3b 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -261,6 +261,8 @@ enum mca_msr {
 
 /* Decide whether to add MCE record to MCE event pool or filter it out. */
 extern bool filter_mce(struct mce *m);
+void mce_prep_record_common(struct mce *m);
+void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);

