Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833A140B7C7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Sep 2021 21:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhINTUp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Sep 2021 15:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhINTUo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5BBC061574;
        Tue, 14 Sep 2021 12:19:27 -0700 (PDT)
Date:   Tue, 14 Sep 2021 19:19:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631647165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/WkkXh4sAoo0jF1/TutenhkEz15BQQQU2eBzmJqyFqs=;
        b=R077DKYraEsQiW5nri5XGFp82zQX8RqQOFgFSV2gNiMnjVmIdJXWbzyoDGY1p1Lfn+spGg
        0pUGP20pqjTiUuW4mHxCwk+KmlNipAR1TzVZOzl0cU336+UOZw5RI/k4sc+qrwbCQhlvnc
        9/Us1yhab4FK1jXEvPcWPNMZ8u8QDrBl4e4A/w8Z2WuR71rgdAmmitI9uZ8dEs+Nv5L7H5
        CF/UAnUM53P4H9co+yv5ONuKjrkdT4u5E/IZYrZYmUTvQXWZa2yRLb/xYVghuyh8Tmu6Z4
        pRS/Ah22m0lGaSiHLoicdwBBBxZQP+94lOLgXdIcbCcfR21jZ6/zMP8PAqT9TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631647165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/WkkXh4sAoo0jF1/TutenhkEz15BQQQU2eBzmJqyFqs=;
        b=yeXneMheDVbMyoX3FBkjvUuJmsyK9gkwVnxnovadWXAULCPv8Yhz7EBoVQLP+ZCczs2wdg
        3nmYnuHdEPBMHVDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Change return code of
 restore_fpregs_from_user() to boolean
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210908132526.084109938@linutronix.de>
References: <20210908132526.084109938@linutronix.de>
MIME-Version: 1.0
Message-ID: <163164716386.25758.6685094461704347376.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     a2a8fd9a3efd8d22ee14a441e9e78cf5c998e69a
Gitweb:        https://git.kernel.org/tip/a2a8fd9a3efd8d22ee14a441e9e78cf5c998e69a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Sep 2021 15:29:41 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Sep 2021 21:10:04 +02:00

x86/fpu/signal: Change return code of restore_fpregs_from_user() to boolean

__fpu_sig_restore() only needs information about success or fail and no
real error code.

This cleans up the confusing conversion of the trap number, which is
returned by the *RSTOR() exception fixups, to an error code.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210908132526.084109938@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 2bd4d51..68f03da 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -254,8 +254,8 @@ static int __restore_fpregs_from_user(void __user *buf, u64 xrestore,
  * Attempt to restore the FPU registers directly from user memory.
  * Pagefaults are handled and any errors returned are fatal.
  */
-static int restore_fpregs_from_user(void __user *buf, u64 xrestore,
-				    bool fx_only, unsigned int size)
+static bool restore_fpregs_from_user(void __user *buf, u64 xrestore,
+				     bool fx_only, unsigned int size)
 {
 	struct fpu *fpu = &current->thread.fpu;
 	int ret;
@@ -284,12 +284,11 @@ retry:
 
 		/* Try to handle #PF, but anything else is fatal. */
 		if (ret != X86_TRAP_PF)
-			return -EINVAL;
+			return false;
 
-		ret = fault_in_pages_readable(buf, size);
-		if (!ret)
+		if (!fault_in_pages_readable(buf, size))
 			goto retry;
-		return ret;
+		return false;
 	}
 
 	/*
@@ -306,7 +305,7 @@ retry:
 
 	fpregs_mark_activate();
 	fpregs_unlock();
-	return 0;
+	return true;
 }
 
 static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
@@ -341,8 +340,8 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		 * faults. If it does, fall back to the slow path below, going
 		 * through the kernel buffer with the enabled pagefault handler.
 		 */
-		return !restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
-						 state_size);
+		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
+						state_size);
 	}
 
 	/*
