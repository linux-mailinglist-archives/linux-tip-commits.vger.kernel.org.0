Return-Path: <linux-tip-commits+bounces-4934-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA193A87343
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 20:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF02B3B41BA
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C1E1F4CB8;
	Sun, 13 Apr 2025 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BCUDDwLv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hpQtvVot"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BD61F4639;
	Sun, 13 Apr 2025 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570580; cv=none; b=MdJAUy2zLafG9F3QWr+gF4VLw/2Xl+3rDeHYSNU5B8wT3/nzR0Ov+QXUnzwArmTT7QgfBthw54UmJ+haIVgw5nhoFn9MJgrY7FblRI64wh4V3CPzU1MUYdlGnASfHpvIbTBYAIOtVECbsaH/opc66N8c4eTeJiY09n99uTKneF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570580; c=relaxed/simple;
	bh=SYDU4n1c22HAZIGOJs7j5vaJIDyyacq97BtnJlGbkc4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=f7/HPynjVtsFmVU/Ar6F6KRFERdoS15uBHqrDjAsSxv2IOEQ4lIlhfj62W3MxRjRs645jnCiEyht44DOmZWRBNpieWPOmoYTtxJHrZb8q7rXH4UFXJy3jGxCirFta2/WsW21voTkdtl17F3Q6OlTuhgLaPXMFLxAApRWVHL9ueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BCUDDwLv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hpQtvVot; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=EQttG7G3SaY8YhcYRUKJdzeHw4lC5F/8/0D6VHfg9Xo=;
	b=BCUDDwLvvu5LmTkFsg6tZnM3r+Uv5t/KFf9vktsrVDaJhs1/qOcPy4aAlab88xTXNo/VR5
	ulass8uPrKsjVazxBFhAYn+v++x3ElUr3seOuWOXh76zYLegVutS5n9f3VWyCw4IqVd2qh
	nxcpZGJ/EPBL56GN4nxZIzSBBUCu/lUxSuryWaWp+8nscUX1V1fG6+G+KU/zN9anw9sFft
	ByOabxRoK22gkxJB7reiP+hIEqyDzzkxOj5OJkwL2tVv5v+F5rrTyP6aNgE0dyeKGvMXxJ
	ZSsW2Q3DlFIkn8Vvgj6X+6VRmJ2IgwPMKu7GcYHySpvaVr+ThmZCgUGx5pUBwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=EQttG7G3SaY8YhcYRUKJdzeHw4lC5F/8/0D6VHfg9Xo=;
	b=hpQtvVot+2itqDQUOdB3Gkr0TalRdIt4a2HIIjSXKXe6MaXCNvnpi2zvU0V01YW9mHCsNI
	QDAwjCAoo98fSZDw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] x86/msr: Rename 'wrmsrl_safe_on_cpu()' to
 'wrmsrq_safe_on_cpu()'
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juergen Gross <jgross@suse.com>, Dave Hansen <dave.hansen@intel.com>,
 Xin Li <xin@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174457057646.31282.5219818337890395002.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     27a23a544a55b55259ee6b438497dd4384c387c5
Gitweb:        https://git.kernel.org/tip/27a23a544a55b55259ee6b438497dd4384c387c5
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:28:59 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:58:55 +02:00

x86/msr: Rename 'wrmsrl_safe_on_cpu()' to 'wrmsrq_safe_on_cpu()'

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/include/asm/msr.h                                  | 4 ++--
 arch/x86/kernel/acpi/cppc.c                                 | 2 +-
 arch/x86/lib/msr-smp.c                                      | 4 ++--
 drivers/cpufreq/amd-pstate.c                                | 2 +-
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index c86814c..5298327 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -336,7 +336,7 @@ void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *
 int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
 int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
 int rdmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
-int wrmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
+int wrmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
 int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8]);
 int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8]);
 #else  /*  CONFIG_SMP  */
@@ -383,7 +383,7 @@ static inline int rdmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 {
 	return rdmsrq_safe(msr_no, q);
 }
-static inline int wrmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
+static inline int wrmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 {
 	return wrmsrq_safe(msr_no, q);
 }
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 6a10d73..78b4e4b 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -74,7 +74,7 @@ int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 		val &= mask;
 		rd_val &= ~mask;
 		rd_val |= val;
-		err = wrmsrl_safe_on_cpu(cpunum, reg->address, rd_val);
+		err = wrmsrq_safe_on_cpu(cpunum, reg->address, rd_val);
 	}
 	return err;
 }
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 0360ce2..434fdc2 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -204,7 +204,7 @@ int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 }
 EXPORT_SYMBOL(wrmsr_safe_on_cpu);
 
-int wrmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
+int wrmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 {
 	int err;
 	struct msr_info rv;
@@ -218,7 +218,7 @@ int wrmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 
 	return err ? err : rv.err;
 }
-EXPORT_SYMBOL(wrmsrl_safe_on_cpu);
+EXPORT_SYMBOL(wrmsrq_safe_on_cpu);
 
 int rdmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 {
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 16a3fe2..0615c73 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -371,7 +371,7 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 
 static inline int msr_cppc_enable(struct cpufreq_policy *policy)
 {
-	return wrmsrl_safe_on_cpu(policy->cpu, MSR_AMD_CPPC_ENABLE, 1);
+	return wrmsrq_safe_on_cpu(policy->cpu, MSR_AMD_CPPC_ENABLE, 1);
 }
 
 static int shmem_cppc_enable(struct cpufreq_policy *policy)
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 46b96f1..44dcd16 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -191,7 +191,7 @@ void isst_resume_common(void)
 			if (cb->registered)
 				isst_mbox_resume_command(cb, sst_cmd);
 		} else {
-			wrmsrl_safe_on_cpu(sst_cmd->cpu, sst_cmd->cmd,
+			wrmsrq_safe_on_cpu(sst_cmd->cpu, sst_cmd->cmd,
 					   sst_cmd->data);
 		}
 	}
@@ -524,7 +524,7 @@ static long isst_if_msr_cmd_req(u8 *cmd_ptr, int *write_only, int resume)
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
-		ret = wrmsrl_safe_on_cpu(msr_cmd->logical_cpu,
+		ret = wrmsrq_safe_on_cpu(msr_cmd->logical_cpu,
 					 msr_cmd->msr,
 					 msr_cmd->data);
 		*write_only = 1;

