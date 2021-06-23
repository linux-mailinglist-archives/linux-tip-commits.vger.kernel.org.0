Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8933B22FD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFWWLX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:11:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhFWWLR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:17 -0400
Date:   Wed, 23 Jun 2021 22:08:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=guGzeZP8gIfchmxSbFCRK1fhWUUyIPkpk4yzYa2ia1M=;
        b=NydfMA2kfbrpEWhZnoYQJ5gsUUG6rRniOkKKMHQPeoev3Ud+0dH1KrBkpW6CzErcNnn5TM
        RtH5XbsfXSI6i3Z5i4esXpOtaoS3ODPOuYjVTXfDrcocsfob5DptvHVuslegd+WTlv1Xvj
        +0CRJ2ghPc8TeI/FHYezEv0M1pedl585a7lOzWXz49KAtH+IqObspmy7Xd3KlBCPIkgzZF
        8JJdqhhR+/Lm37M4g4tv6n2h8Fok/JI6Ek+Ul38P983LfpBh9bujWvhKkJ3ybEsfFjchoA
        MJXzERcqbXufBpJP6ABTDBF4+hgvJRUdHZ1CUYHvrzQ1v/4B05JXg+/7aWK6tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=guGzeZP8gIfchmxSbFCRK1fhWUUyIPkpk4yzYa2ia1M=;
        b=/kreCyzsPKzh6fs6WtKVh5DWlqqj0/aEK6el5k6eHoGOZGIxs6hOmvGixVJHIuTZQEHH57
        lOAXSMH+n4KK0uCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Don't store PKRU in xstate in fpu_reset_fpstate()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121456.802850233@linutronix.de>
References: <20210623121456.802850233@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448613736.395.5693426983882974728.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     0e8c54f6b2c8b1037cef9276e451522ee90ed969
Gitweb:        https://git.kernel.org/tip/0e8c54f6b2c8b1037cef9276e451522ee90ed969
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:22 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 19:55:16 +02:00

x86/fpu: Don't store PKRU in xstate in fpu_reset_fpstate()

PKRU for a task is stored in task->thread.pkru when the task is scheduled
out. For 'current' the authoritative source of PKRU is the hardware.

fpu_reset_fpstate() has two callers:

  1) fpu__clear_user_states() for !FPU systems. For those PKRU is irrelevant

  2) fpu_flush_thread() which is invoked from flush_thread(). flush_thread()
     resets the hardware to the kernel restrictive default value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121456.802850233@linutronix.de
---
 arch/x86/kernel/fpu/core.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 470576c..5295cba 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -337,23 +337,6 @@ static inline unsigned int init_fpstate_copy_size(void)
 	return sizeof(init_fpstate.xsave);
 }
 
-/* Temporary workaround. Will be removed once PKRU and XSTATE are untangled. */
-static inline void pkru_set_default_in_xstate(struct xregs_state *xsave)
-{
-	struct pkru_state *pk;
-
-	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
-		return;
-	/*
-	 * Force XFEATURE_PKRU to be set in the header otherwise
-	 * get_xsave_addr() does not work and it also needs to be set to
-	 * make XRSTOR(S) load it.
-	 */
-	xsave->header.xfeatures |= XFEATURE_MASK_PKRU;
-	pk = get_xsave_addr(xsave, XFEATURE_PKRU);
-	pk->pkru = pkru_get_init_value();
-}
-
 /*
  * Reset current->fpu memory state to the init values.
  */
@@ -371,9 +354,12 @@ static void fpu_reset_fpstate(void)
 	 *
 	 * Do not use fpstate_init() here. Just copy init_fpstate which has
 	 * the correct content already except for PKRU.
+	 *
+	 * PKRU handling does not rely on the xstate when restoring for
+	 * user space as PKRU is eagerly written in switch_to() and
+	 * flush_thread().
 	 */
 	memcpy(&fpu->state, &init_fpstate, init_fpstate_copy_size());
-	pkru_set_default_in_xstate(&fpu->state.xsave);
 	set_thread_flag(TIF_NEED_FPU_LOAD);
 	fpregs_unlock();
 }
