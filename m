Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B232B82DF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgKRRSX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgKRRSX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C638EC0613D6;
        Wed, 18 Nov 2020 09:18:22 -0800 (PST)
Date:   Wed, 18 Nov 2020 17:18:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719901;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4zbvcK+tEe0z7f1JNq0ONiAkx9sIbz7jEzkP7Pa49dE=;
        b=py4btFelOC9r6/hIaOO53UGX+K3rgxMjjSDtCRgmmHDMLfcrU0P7rXGwhaNGZrMnRSMhKF
        HujlNfBo4M2Px5BN3H1c5jFIUcSJPte2kBiAju7N8KkpSm2WR1ei8INKhja+QP3gIYAwJZ
        0TfbYZE3F4EO0fPQNiIwUCT2jl/e1z/Z4xRV6iZaXNrTjsKKT/BgwU8C32H3HaiC19qaix
        c3uKUp6MkKkjz0DeLeSMDOAr7NGLhokBbZi+MTH+8RQ8OY5ZwHXHo3klPQFYmxJG8XJpYp
        5lcRIEFXbQP5k0HdP8WSEaSLHSK40RyJ6Zx+cu8Vnpxr7pmcg0CXwkDvTZ2i9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719901;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4zbvcK+tEe0z7f1JNq0ONiAkx9sIbz7jEzkP7Pa49dE=;
        b=AAHMl3dovQxC4z5D9mjM/QvH/TiBiSSY7TTNEYyRLaMCzRW9XPTTMtEStdSzWWQ25WtK6w
        ghY/IEfmAxDC0vBA==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/fault: Add a helper function to sanitize error code
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-18-jarkko@kernel.org>
References: <20201112220135.165028-18-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571990045.11244.648502750601016948.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     cd072dab453a9b4a9f7927f9eddca5a156fbd87d
Gitweb:        https://git.kernel.org/tip/cd072dab453a9b4a9f7927f9eddca5a156fbd87d
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 13 Nov 2020 00:01:28 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Nov 2020 18:02:50 +01:00

x86/fault: Add a helper function to sanitize error code

vDSO exception fixup is a replacement for signals in limited situations.
Signals and vDSO exception fixup need to provide similar information to
userspace, including the hardware error code.

That hardware error code needs to be sanitized.  For instance, if userspace
accesses a kernel address, the error code could indicate to userspace
whether the address had a Present=1 PTE.  That can leak information about
the kernel layout to userspace, which is bad.

The existing signal code does this sanitization, but fairly late in the
signal process.  The vDSO exception code runs before the sanitization
happens.

Move error code sanitization out of the signal code and into a helper.
Call the helper in the signal code.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Link: https://lkml.kernel.org/r/20201112220135.165028-18-jarkko@kernel.org
---
 arch/x86/mm/fault.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9339fee..0161d4a 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -602,11 +602,9 @@ pgtable_bad(struct pt_regs *regs, unsigned long error_code,
 	oops_end(flags, regs, sig);
 }
 
-static void set_signal_archinfo(unsigned long address,
-				unsigned long error_code)
+static void sanitize_error_code(unsigned long address,
+				unsigned long *error_code)
 {
-	struct task_struct *tsk = current;
-
 	/*
 	 * To avoid leaking information about the kernel page
 	 * table layout, pretend that user-mode accesses to
@@ -617,7 +615,13 @@ static void set_signal_archinfo(unsigned long address,
 	 * information and does not appear to cause any problems.
 	 */
 	if (address >= TASK_SIZE_MAX)
-		error_code |= X86_PF_PROT;
+		*error_code |= X86_PF_PROT;
+}
+
+static void set_signal_archinfo(unsigned long address,
+				unsigned long error_code)
+{
+	struct task_struct *tsk = current;
 
 	tsk->thread.trap_nr = X86_TRAP_PF;
 	tsk->thread.error_code = error_code | X86_PF_USER;
@@ -658,6 +662,8 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 		 * faulting through the emulate_vsyscall() logic.
 		 */
 		if (current->thread.sig_on_uaccess_err && signal) {
+			sanitize_error_code(address, &error_code);
+
 			set_signal_archinfo(address, error_code);
 
 			/* XXX: hwpoison faults will set the wrong code. */
@@ -806,13 +812,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		if (is_errata100(regs, address))
 			return;
 
-		/*
-		 * To avoid leaking information about the kernel page table
-		 * layout, pretend that user-mode accesses to kernel addresses
-		 * are always protection faults.
-		 */
-		if (address >= TASK_SIZE_MAX)
-			error_code |= X86_PF_PROT;
+		sanitize_error_code(address, &error_code);
 
 		if (likely(show_unhandled_signals))
 			show_signal_msg(regs, error_code, address, tsk);
@@ -931,6 +931,8 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	if (is_prefetch(regs, error_code, address))
 		return;
 
+	sanitize_error_code(address, &error_code);
+
 	set_signal_archinfo(address, error_code);
 
 #ifdef CONFIG_MEMORY_FAILURE
