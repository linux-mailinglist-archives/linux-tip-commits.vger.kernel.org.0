Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B414D43847B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 23 Oct 2021 19:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhJWRiO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 23 Oct 2021 13:38:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45440 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhJWRiN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 23 Oct 2021 13:38:13 -0400
Date:   Sat, 23 Oct 2021 17:35:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635010553;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Fja5qldszSaJ0+J+GjVM/sW2hidboEw5PkDM/GY4zs=;
        b=U2dkuO44Vd1bxC7PFdlHR9mYh7hXyVhLOAnUjE7AbWxIrsNc5Mt3iPvS9jHo/nyOYDdMNQ
        HhYzs+Bx4EUmf+C1SE6a4lQK8BbUlQqhMyPfUenyGXvT0l5o1SDeKwrgfEeMkE9yOgmsSl
        HhUrW+V2P3VnR0Bu8/8brNigAhVWqbKvpUjW7XoxSlShCOtoYYIAwsTvcSJpCjDhBQROY0
        rCV68exaXIydHL/hpGPczlOf9F1SXLIl7x2/PlGclic5BDsD4ebxZybSiqFquY8mB93ujX
        RltDzBNdoPoR3ACdH7AeS1RNsQqimX63GzLLA4gG/6FtUzw1Trw5ddtF1PWSvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635010553;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Fja5qldszSaJ0+J+GjVM/sW2hidboEw5PkDM/GY4zs=;
        b=07Fp35OMOUL7Gr2X2QGb6x2KX8zayAtE2pfpszjKWlP9JHKTjIfgQcpgTtFWVaK8EJTgD6
        sJM1M6lXeg2Sb3BA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Prepare for sanitizing KVM FPU code
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211022185312.896403942@linutronix.de>
References: <20211022185312.896403942@linutronix.de>
MIME-Version: 1.0
Message-ID: <163501055253.626.9913899365996278545.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     75c52dad5e327605f1025f399dafdf4aaf5dae9c
Gitweb:        https://git.kernel.org/tip/75c52dad5e327605f1025f399dafdf4aaf5dae9c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 22 Oct 2021 20:55:49 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 23 Oct 2021 13:14:50 +02:00

x86/fpu: Prepare for sanitizing KVM FPU code

For the upcoming AMX support it's necessary to do a proper integration with
KVM. To avoid more nasty hackery in KVM which violate encapsulation extend
struct fpu and fpstate so the fpstate switching can be consolidated and
simplified.

Currently KVM allocates two FPU structs which are used for saving the user
state of the vCPU thread and restoring the guest state when entering
vcpu_run() and doing the reverse operation before leaving vcpu_run().

With the new fpstate mechanism this can be reduced to one extra buffer by
swapping the fpstate pointer in current::thread::fpu. This makes the
upcoming support for AMX and XFD simpler because then fpstate information
(features, sizes, xfd) are always consistent and it does not require any
nasty workarounds.

Add fpu::__task_fpstate to save the regular fpstate pointer while the task
is inside vcpu_run(). Add some state fields to fpstate to indicate the
nature of the state.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211022185312.896403942@linutronix.de
---
 arch/x86/include/asm/fpu/types.h | 44 ++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index a32be07..c72cb22 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -322,8 +322,32 @@ struct fpstate {
 	/* @user_xfeatures:	xfeatures valid in UABI buffers */
 	u64			user_xfeatures;
 
+	/* @is_valloc:		Indicator for dynamically allocated state */
+	unsigned int		is_valloc	: 1;
+
+	/* @is_guest:		Indicator for guest state (KVM) */
+	unsigned int		is_guest	: 1;
+
+	/*
+	 * @is_confidential:	Indicator for KVM confidential mode.
+	 *			The FPU registers are restored by the
+	 *			vmentry firmware from encrypted guest
+	 *			memory. On vmexit the FPU registers are
+	 *			saved by firmware to encrypted guest memory
+	 *			and the registers are scrubbed before
+	 *			returning to the host. So there is no
+	 *			content which is worth saving and restoring.
+	 *			The fpstate has to be there so that
+	 *			preemption and softirq FPU usage works
+	 *			without special casing.
+	 */
+	unsigned int		is_confidential	: 1;
+
+	/* @in_use:		State is in use */
+	unsigned int		in_use		: 1;
+
 	/* @regs: The register state union for all supported formats */
-	union fpregs_state		regs;
+	union fpregs_state	regs;
 
 	/* @regs is dynamically sized! Don't add anything after @regs! */
 } __aligned(64);
@@ -364,6 +388,14 @@ struct fpu {
 	struct fpstate			*fpstate;
 
 	/*
+	 * @__task_fpstate:
+	 *
+	 * Pointer to an inactive struct fpstate. Initialized to NULL. Is
+	 * used only for KVM support to swap out the regular task fpstate.
+	 */
+	struct fpstate			*__task_fpstate;
+
+	/*
 	 * @__fpstate:
 	 *
 	 * Initial in-memory storage for FPU registers which are saved in
@@ -379,6 +411,16 @@ struct fpu {
 };
 
 /*
+ * Guest pseudo FPU container
+ */
+struct fpu_guest {
+	/*
+	 * @fpstate:			Pointer to the allocated guest fpstate
+	 */
+	struct fpstate			*fpstate;
+};
+
+/*
  * FPU state configuration data. Initialized at boot time. Read only after init.
  */
 struct fpu_state_config {
