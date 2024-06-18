Return-Path: <linux-tip-commits+bounces-1445-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC32B90D489
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 16:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26D31F23041
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 14:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3FC16A955;
	Tue, 18 Jun 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fv7Jlq4z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TPshMj6s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E2B16A935;
	Tue, 18 Jun 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719308; cv=none; b=Rm6noTS9jJAs932RN0XipBKauf537JOY8S1J69sL+kaHvV4k1MyRCgsd3puPIs9NGR/RNrQMJuppilMPRlo85I2RFy0CeGCUZcfXhPCbCIM1K9ZYPUv+5bu/PTLU9O5fYybH2MXFBF6aVrESPkBwHRyVUx3nlf7MZ6qeKWCl3vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719308; c=relaxed/simple;
	bh=ve/ngJAhfosBQNRupidosFaH088GWR4cv/SdiOiXoaQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EyU2atGyqS7mLi6mM4G9aR//Z5+SpuLPPnx46jBfi3DWtJBlxRayQOKapvsHfToj365R5oVbL7SLIUvhsP2XwTqluG/vVOsVoIvKi3HvV8vHfqAIZUeMsZSeXC9b9P1shHkpiMrBWWIAsHA7xl2sP53JQPmHRxnKFu5mmcxaxqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fv7Jlq4z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TPshMj6s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 14:01:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718719299;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h2gKTm1BjGd6PCm/nkcn25v1uKAARWjN3e1JnLoBJM0=;
	b=Fv7Jlq4zh14KvOWAYbBREYS4h1Ozvy9GLgBZq5xesPcdiEm1w6uWq7dwaweHQoGfPJtEg4
	5gD5Yr5Md7Lx2gnIB+EdAbjXT1Rj/KNJZkWa8M9OwjgzO4fFtwNU47DtjvD9R43SDrCF5h
	PTtaBQLzkuLUOIhs/c7MB5vYcZey9uu/R31vGjp/wdqS25LNb7vlJrNxJSgLECY503R7g5
	7vO5J+036magAow1GpYFauOPT88colHeiKpbA4XKiTYVwl9iS0AcZ87SfhRUIvlaD5kwoU
	VtiIRMZ9ulnRD6qu7/XwrCkN8IExSirhINIotQLmhhS2BbOvfWrOA6HezWryoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718719299;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h2gKTm1BjGd6PCm/nkcn25v1uKAARWjN3e1JnLoBJM0=;
	b=TPshMj6sHDXK30O7P2Q2aAreATqoqFPXaDbFNz0jkdLrqPji+YoLMPxbE8VKdgLKKt82v1
	8V7YCt373x7M+NCQ==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/smp: Add smp_ops.stop_this_cpu() callback
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Kai Huang <kai.huang@intel.com>, Tao Liu <ltao@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240614095904.1345461-17-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-17-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171871929905.10875.16141330651329081078.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     26ba7353caaa7140561d3f7693a77a3eb68c722c
Gitweb:        https://git.kernel.org/tip/26ba7353caaa7140561d3f7693a77a3eb68c722c
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 12:59:01 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 17:46:20 +02:00

x86/smp: Add smp_ops.stop_this_cpu() callback

If the helper is defined, it is called instead of halt() to stop the CPU at the
end of stop_this_cpu() and on crash CPU shutdown.

ACPI MADT will use it to hand over the CPU to BIOS in order to be able to wake
it up again after kexec.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kai Huang <kai.huang@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
Link: https://lore.kernel.org/r/20240614095904.1345461-17-kirill.shutemov@linux.intel.com
---
 arch/x86/include/asm/smp.h | 1 +
 arch/x86/kernel/process.c  | 7 +++++++
 arch/x86/kernel/reboot.c   | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index a35936b..ca073f4 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -35,6 +35,7 @@ struct smp_ops {
 	int (*cpu_disable)(void);
 	void (*cpu_die)(unsigned int cpu);
 	void (*play_dead)(void);
+	void (*stop_this_cpu)(void);
 
 	void (*send_call_func_ipi)(const struct cpumask *mask);
 	void (*send_call_func_single_ipi)(int cpu);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b844114..f63f8fd 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -835,6 +835,13 @@ void __noreturn stop_this_cpu(void *dummy)
 	 */
 	cpumask_clear_cpu(cpu, &cpus_stop_mask);
 
+#ifdef CONFIG_SMP
+	if (smp_ops.stop_this_cpu) {
+		smp_ops.stop_this_cpu();
+		unreachable();
+	}
+#endif
+
 	for (;;) {
 		/*
 		 * Use native_halt() so that memory contents don't change
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index bb7a44a..0e0a4cf 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -880,6 +880,12 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 	cpu_emergency_disable_virtualization();
 
 	atomic_dec(&waiting_for_crash_ipi);
+
+	if (smp_ops.stop_this_cpu) {
+		smp_ops.stop_this_cpu();
+		unreachable();
+	}
+
 	/* Assume hlt works */
 	halt();
 	for (;;)

