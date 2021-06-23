Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8652A3B2334
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhFWWMq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40206 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhFWWLy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:54 -0400
Date:   Wed, 23 Jun 2021 22:09:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486174;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QclcuUpm1bLzgh7tH0nCu63IlwY4uAelMmUgK+1L+3M=;
        b=VwXGV6A6/ei0WpZ+tCL1qKLMru9Tij3zyQM6EHXqOb5PwRtmfoFSHx4DkTM3kz/e/61cuz
        Ofxd6cSMaHbRy3dlJ6MSrNLB0flLuztUl/lEuPHtZUReSJu+ZZXb9Atm0gqqS1G9sEPnXu
        kGVt0MHvbNUPdvmEqk6fOjKl6t6paEwDDkuQdgYbzgMdwOMWKPaUStgfJLOvcOUrKohk3u
        yMvdR5TCta0LievIkdl4cnbI+eEQbk4L9I892vSsEIsZ0R16lxN8EmcYavfxC6eTKt6btF
        mI/+4q/PsjMwVfaJQtxa0ZFOK3fvD+uNPNJNDLRnUOPHYijUjyPzY4sXuMDV4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486174;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QclcuUpm1bLzgh7tH0nCu63IlwY4uAelMmUgK+1L+3M=;
        b=7E0t8CSwP6P/khrsOG+0nV1On+TwtXo77X+lhkLJz0ExgOF6ll1EGVZxOxdynjGGJFVSCg
        AbW/dKh6PWIMY2DA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Use copy_xstate_to_uabi_buf() in xfpregs_get()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121452.901736860@linutronix.de>
References: <20210623121452.901736860@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448617362.395.4711196753690480588.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     adc997b3d66d1cfa8c15a7dbafdaef239a51b5db
Gitweb:        https://git.kernel.org/tip/adc997b3d66d1cfa8c15a7dbafdaef239a51b5db
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:43 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:47 +02:00

x86/fpu: Use copy_xstate_to_uabi_buf() in xfpregs_get()

Use the new functionality of copy_xstate_to_uabi_buf() to retrieve the
FX state when XSAVE* is in use. This avoids overwriting the FPU state
buffer with fpstate_sanitize_xstate() which is error prone and duplicated
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121452.901736860@linutronix.de
---
 arch/x86/kernel/fpu/regset.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 783f84d..ccbe25f 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -33,13 +33,18 @@ int xfpregs_get(struct task_struct *target, const struct user_regset *regset,
 {
 	struct fpu *fpu = &target->thread.fpu;
 
-	if (!boot_cpu_has(X86_FEATURE_FXSR))
+	if (!cpu_feature_enabled(X86_FEATURE_FXSR))
 		return -ENODEV;
 
 	fpu__prepare_read(fpu);
-	fpstate_sanitize_xstate(fpu);
 
-	return membuf_write(&to, &fpu->state.fxsave, sizeof(struct fxregs_state));
+	if (!use_xsave()) {
+		return membuf_write(&to, &fpu->state.fxsave,
+				    sizeof(fpu->state.fxsave));
+	}
+
+	copy_xstate_to_uabi_buf(to, &fpu->state.xsave, XSTATE_COPY_FX);
+	return 0;
 }
 
 int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
