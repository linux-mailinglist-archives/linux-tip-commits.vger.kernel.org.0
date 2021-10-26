Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28A743B6CE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbhJZQTL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34588 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbhJZQTH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:07 -0400
Date:   Tue, 26 Oct 2021 16:16:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635265003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kl2/dPNxvG/GNXjEVHJWOlu2WEe55FBLF7nHskx6G8I=;
        b=BEAm8ZlU2iJvccfFkr+9mTZLt7EzcetYZAV/1GgP52JDpRvbf9gb2K0OqqzMOHV0VERUFe
        hsfASeUBdEbUjN5TlZG6ZRVXTMbeRm9G/qoGrNIFZjq2fcmcLVk0GIbhkG4+SBCOTRlYVA
        eCOQH/mkbzWfgtLyTKseWIuFth9pLfANEPIgomXP/aWsSPcLXmc4crqQlCxtsORtFh+juw
        vYhkwa/smwbEBnh2hHA4wGaTF4/77+NKXysgiP1rOKJjopZ70X+N7fM7X0QVqkuee9rYio
        4FfrFHcv0iDed48dZWLsU0Up6UKwVePEKzEOY1Udj4bg5YVifp5Vrq/LT4WgFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635265003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kl2/dPNxvG/GNXjEVHJWOlu2WEe55FBLF7nHskx6G8I=;
        b=KdUES9swXXjYZKFllsCVprbd0f7vGjor4zFc82I7DNrQg8F5K9ZJnFD4Fj3M1An54megJC
        HPROmn2m/tYxBjBg==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Reset permission and fpstate on exec()
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-12-chang.seok.bae@intel.com>
References: <20211021225527.10184-12-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526500203.626.4159930425184008220.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     e61d6310a0f80cb986fd2076d432760b3619fb6d
Gitweb:        https://git.kernel.org/tip/e61d6310a0f80cb986fd2076d432760b3619fb6d
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 21 Oct 2021 15:55:15 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:18:09 +02:00

x86/fpu: Reset permission and fpstate on exec()

On exec(), extended register states saved in the buffer is cleared. With
dynamic features, each task carries variables besides the register states.
The struct fpu has permission information and struct fpstate contains
buffer size and feature masks. They are all dynamically updated with
dynamic features.

Reset the current task's entire FPU data before an exec() so that the new
task starts with default permission and fpstate.

Rename the register state reset function because the old naming confuses as
it does not reset struct fpstate.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211021225527.10184-12-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1ff6b83..3349068 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -544,7 +544,7 @@ static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
 /*
  * Reset current->fpu memory state to the init values.
  */
-static void fpu_reset_fpstate(void)
+static void fpu_reset_fpregs(void)
 {
 	struct fpu *fpu = &current->thread.fpu;
 
@@ -579,7 +579,7 @@ void fpu__clear_user_states(struct fpu *fpu)
 
 	fpregs_lock();
 	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
-		fpu_reset_fpstate();
+		fpu_reset_fpregs();
 		fpregs_unlock();
 		return;
 	}
@@ -609,7 +609,8 @@ void fpu__clear_user_states(struct fpu *fpu)
 
 void fpu_flush_thread(void)
 {
-	fpu_reset_fpstate();
+	fpstate_reset(&current->thread.fpu);
+	fpu_reset_fpregs();
 }
 /*
  * Load FPU context before returning to userspace.
