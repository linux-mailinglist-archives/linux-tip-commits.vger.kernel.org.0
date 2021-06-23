Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3703B232A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhFWWMb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhFWWLr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA8FC061226;
        Wed, 23 Jun 2021 15:09:09 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:09:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0T6UVIkfAu6888o1tDCT2L4hkrX+XH49QGg+lq4ZTks=;
        b=maW1bVcgtg42+n8dB/PSeivWVX4wPGrRUCPFQXyWDzPgmHDJ9Npi7bDeQm/iaAQPSroe4d
        ywA2rUjK3hy7v1IEK15dZbTA6f8uSfdxMl1Vg2UpRuoAkY/WkE4KGDxkydCTlMFHlnVEbP
        Kq50eOAR7mCdxkHlBCxS/w1C7ImugnTNl0zJHlt2uNTyCVf5pL60EFitbxpiUtZfmyuIH4
        LhrNnnVcakCBPYGRuGhPeKfACJ1pH5ZpHLRhEMXPLnb+0n/CeX5qz9hxd4MinL+WQaJNKh
        KWHSYJDS1zevZLbye5DygJW9A3abPesW4jsktHJmFk/ZMsuuMeHaiGXkQG5V8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0T6UVIkfAu6888o1tDCT2L4hkrX+XH49QGg+lq4ZTks=;
        b=+WFs7VuJypNg8ugI+cMoT3ZzrJlmKC9Ikx3DA1lC4+KO0n9e97+PYSzbvpZ5V3EezPfS0M
        6mqTdm6L/jo+1LAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Rename fpu__clear_all() to fpu_flush_thread()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121455.827979263@linutronix.de>
References: <20210623121455.827979263@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448614692.395.5621201580670080626.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     e7ecad17c84d0f6bef635c20d02bbe4096eea700
Gitweb:        https://git.kernel.org/tip/e7ecad17c84d0f6bef635c20d02bbe4096eea700
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:12 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 19:20:10 +02:00

x86/fpu: Rename fpu__clear_all() to fpu_flush_thread()

Make it clear what the function is about.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121455.827979263@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 3 ++-
 arch/x86/kernel/fpu/core.c          | 4 ++--
 arch/x86/kernel/process.c           | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index f5da2e9..dabbb70 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -29,12 +29,13 @@
 extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
 extern void fpu__drop(struct fpu *fpu);
 extern void fpu__clear_user_states(struct fpu *fpu);
-extern void fpu__clear_all(struct fpu *fpu);
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 
 extern void fpu_sync_fpstate(struct fpu *fpu);
 
+/* Clone and exit operations */
 extern int  fpu_clone(struct task_struct *dst);
+extern void fpu_flush_thread(void);
 
 /*
  * Boot time FPU initialization functions:
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index fedadcb..4b69be9 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -350,9 +350,9 @@ void fpu__clear_user_states(struct fpu *fpu)
 	fpu__clear(fpu, true);
 }
 
-void fpu__clear_all(struct fpu *fpu)
+void fpu_flush_thread(void)
 {
-	fpu__clear(fpu, false);
+	fpu__clear(&current->thread.fpu, false);
 }
 
 /*
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index af3db53..19d05d3 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -205,7 +205,7 @@ void flush_thread(void)
 	flush_ptrace_hw_breakpoint(tsk);
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));
 
-	fpu__clear_all(&tsk->thread.fpu);
+	fpu_flush_thread();
 }
 
 void disable_TSC(void)
