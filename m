Return-Path: <linux-tip-commits+bounces-3832-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC73A4CC22
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 20:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E991742C1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258F1232392;
	Mon,  3 Mar 2025 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YmEenOZh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vpbWXZ7m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA11231CB9;
	Mon,  3 Mar 2025 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030967; cv=none; b=io5wqXZdHawMskhUpwCIl2luiS4CqSK8or8fu976C1annskLVnm62Ysu/SKVHSIJ+MnUbNI+Zf52HyL5pHwVdjJ7UpSFVezOF9hC18tbTATilMUhPr5b5EQYmu8nwP1PerderxXzwkRPIaTyPW65AgubRqEdr5jON9sp5NV9jP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030967; c=relaxed/simple;
	bh=6fbjw0aMtiL14PfgwbOJ+aw6ZPLLU/ILpn50EtGX7oc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Hx9H9Pn+OU5SYiM+MexhzNyxTWnGi7EWac1lF2nxW6uYSXt4Ekeu06lj9uYzY4MAkJNRBDH2ElMf570o9Rq7jqXTSWmenZHpn4FZcLsoWiGwYeoVXeE1pFGygasDyZ74y0HxJdqk3aI52LPVIyThwX4LL7EkcJYUhBk9Zqm9G64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YmEenOZh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vpbWXZ7m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 19:42:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741030963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0fL0ilny4vy5vqssCaZJw3atibky6KBCpiUkMzgHhY=;
	b=YmEenOZhJhOgr/xqE1qbcv8FD8dEEQe2Xrj0AgyD8142UgsYECCiyy/1n2F+ArXZwqoaGo
	o4IoNs1FHIC1Kd+YCYdPtXrAjwZGeRdE8DLgpnDUF6jxBBCeKYIWq/apiDJuF4OMWRUDZm
	d0X/qfn87ra3yFY8hW5CantUrVD4Ea3sfEDagQjIeLoYj5EPEzNkfKKdF7fE9poDN3xpjc
	ouzQCcm7d7JC32vx9q7/EPxQb3vdb4lZAPyeiLiWY4+YSNcje+mf6ISeTCrNSNkcndbhwT
	5i69Uy21rcHNklox11Z0Vs5ZwhsQmDlodMOIv0P44Jv84dm/yZNFhXlIhVpozQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741030963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0fL0ilny4vy5vqssCaZJw3atibky6KBCpiUkMzgHhY=;
	b=vpbWXZ7m9vAXuPko1BkIg489hP72dGTZ5wxcbvnhF6bPxhN5FctXhaOtiXBg4E42pq50nj
	TfrHJC/ukZbwCyAA==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/asm: Merge KSTK_ESP() implementations
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250303183111.2245129-1-brgerst@gmail.com>
References: <20250303183111.2245129-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174103096320.14745.8983611865949775771.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     399fd7a26441586021ca3722f6a98ff33ed32caf
Gitweb:        https://git.kernel.org/tip/399fd7a26441586021ca3722f6a98ff33ed32caf
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 13:31:11 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 20:28:33 +01:00

x86/asm: Merge KSTK_ESP() implementations

Commit:

  263042e4630a ("Save user RSP in pt_regs->sp on SYSCALL64 fastpath")

simplified the 64-bit implementation of KSTK_ESP() which is
now identical to 32-bit.  Merge them into a common definition.

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250303183111.2245129-1-brgerst@gmail.com
---
 arch/x86/include/asm/processor.h | 5 +----
 arch/x86/kernel/process_64.c     | 5 -----
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c0cd101..0c91108 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -668,8 +668,6 @@ static __always_inline void prefetchw(const void *x)
 	.sysenter_cs		= __KERNEL_CS,				  \
 }
 
-#define KSTK_ESP(task)		(task_pt_regs(task)->sp)
-
 #else
 extern unsigned long __top_init_kernel_stack[];
 
@@ -677,8 +675,6 @@ extern unsigned long __top_init_kernel_stack[];
 	.sp	= (unsigned long)&__top_init_kernel_stack,		\
 }
 
-extern unsigned long KSTK_ESP(struct task_struct *task);
-
 #endif /* CONFIG_X86_64 */
 
 extern void start_thread(struct pt_regs *regs, unsigned long new_ip,
@@ -692,6 +688,7 @@ extern void start_thread(struct pt_regs *regs, unsigned long new_ip,
 #define TASK_UNMAPPED_BASE		__TASK_UNMAPPED_BASE(TASK_SIZE_LOW)
 
 #define KSTK_EIP(task)		(task_pt_regs(task)->ip)
+#define KSTK_ESP(task)		(task_pt_regs(task)->sp)
 
 /* Get/set a process' ability to use the timestamp counter instruction */
 #define GET_TSC_CTL(adr)	get_tsc_mode((adr))
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4ca73dd..f983d2a 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -979,8 +979,3 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 
 	return ret;
 }
-
-unsigned long KSTK_ESP(struct task_struct *task)
-{
-	return task_pt_regs(task)->sp;
-}

