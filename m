Return-Path: <linux-tip-commits+bounces-4958-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01784A878D9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 09:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AAB165FC2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 07:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367D1259CAE;
	Mon, 14 Apr 2025 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BAHz31KO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lfAYr1Aj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CEE258CD1;
	Mon, 14 Apr 2025 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616091; cv=none; b=WXkd17fWRRvcbX1+YUVjvBuCZHSfQ7NA02+8tzDAzzqlR2JaKUTL8EYYRTSf8G9FVk+mbrzoZhIditxImBi6NQp8195MRNwRfjyf5jQ8T2ruUGSvx8GiYLcx1/oiNgzrNkYi5hX/D2lQeZ0AurOz4E9ktpBNHcCbjjCYz16baoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616091; c=relaxed/simple;
	bh=E/6AntGyGl9Dbs7IgIrXcGc8EjnJ/giiVsyu5K7Ojpg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UzNsMzu0NxDlQbYzINNau/8+69lg7mutLc+S496zmBIVvL4w0BHnJGLPy0CxQDt1iHkqawbuVxgN0J3d1zNTgQqTUdYKona69vDN15rQz/0Iju3D/vGqzwtG4dhdHDljFqcA1E+CawG3C51FTl5C2AkI6dyUb7e1Ow2PEP7Qx6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BAHz31KO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lfAYr1Aj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 07:34:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744616087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dagTIWiokxReXchhDuqcVKGxidfbB9hrqV3IiuAc6CU=;
	b=BAHz31KO06f9vnSpfPsLFQtZwVhwWguehRjqlj297Ps5R3WUtIKXsmCdoNOcJtgN7WyjFL
	TpT4Dp7aaeRhheIBKvI0LT0rZ0cNDtKAcUNNhQ5MAilIXUZTb6HSpuORwe7JO+nxqwl2ML
	1s4/EKWmPDceZZNLNkfB7BSuUIJSOj4t/CD5ZbJJLwh7tgXyXNlrc6s+eD6xMWPXpn9UXP
	687BO9Cdo7wGepr+QHebtLMPD2GwcIPw9fC2jcJvo4bBIXqDSoXKGy6KtH7p2noBqs/EBM
	9ujtfTQAvPPyKNuoeDz6ME5PVG4Gm5vh32GRzCqSkre7Ltx2MjgiCkY40ISOsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744616087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dagTIWiokxReXchhDuqcVKGxidfbB9hrqV3IiuAc6CU=;
	b=lfAYr1AjSI5ol/cmau6snRchurkaDwYPklWaqp6jXrCiM/6hIEydbTYv1SlvpQLtiZgXf+
	52B69uJxJQag3uCQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/fpu: Make sure x86_task_fpu() doesn't get called
 for PF_KTHREAD|PF_USER_WORKER tasks during exit
Cc: Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250409211127.3544993-7-mingo@kernel.org>
References: <20250409211127.3544993-7-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174461608676.31282.200232256748421444.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     c360bdc593b8a8b6e94166026728764085919cff
Gitweb:        https://git.kernel.org/tip/c360bdc593b8a8b6e94166026728764085919cff
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 23:11:25 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 08:18:29 +02:00

x86/fpu: Make sure x86_task_fpu() doesn't get called for PF_KTHREAD|PF_USER_WORKER tasks during exit

fpu__drop() and arch_release_task_struct() calls x86_task_fpu()
unconditionally, while the FPU context area will not be present
if it's the init task, and should not be in use when it's some
other type of kthread.

Return early for PF_KTHREAD or PF_USER_WORKER tasks. The debug
warning in x86_task_fpu() will catch any kthreads attempting to
use the FPU save area.

Fixed-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250409211127.3544993-7-mingo@kernel.org
---
 arch/x86/kernel/fpu/core.c | 8 +++++++-
 arch/x86/kernel/process.c  | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index e4c2090..4a21938 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -683,7 +683,13 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
  */
 void fpu__drop(struct task_struct *tsk)
 {
-	struct fpu *fpu = x86_task_fpu(tsk);
+	struct fpu *fpu;
+
+	/* PF_KTHREAD tasks do not use the FPU context area: */
+	if (tsk->flags & (PF_KTHREAD | PF_USER_WORKER))
+		return;
+
+	fpu = x86_task_fpu(tsk);
 
 	preempt_disable();
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5fb502c..7a1bfb6 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -109,7 +109,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 #ifdef CONFIG_X86_64
 void arch_release_task_struct(struct task_struct *tsk)
 {
-	if (fpu_state_size_dynamic())
+	if (fpu_state_size_dynamic() && !(tsk->flags & (PF_KTHREAD | PF_USER_WORKER)))
 		fpstate_free(x86_task_fpu(tsk));
 }
 #endif

