Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F9E307665
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Jan 2021 13:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhA1Muy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 28 Jan 2021 07:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhA1Muv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 28 Jan 2021 07:50:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F27C061573;
        Thu, 28 Jan 2021 04:50:00 -0800 (PST)
Date:   Thu, 28 Jan 2021 12:49:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611838199;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TUr7IFoF5kI6Mx+O9CiyNn3W+CBk8v5MGz/vV94KWNs=;
        b=Iu0enkOUyXAIWNR3qX3OtX4VCXw4lZ2otCYR1leDR9R7LQz2NLZ5oxNpjEaf7lZh1o/l6k
        rd4YmYlasrfSE82+Lbr093h9XaaOlrfDkPWhUrVGSOO3KTq+UhN3vTqlTZcOJEufGh9+j9
        w13qDlOcKWrc2Iy7K56RxQwJ8Dxfzcgvd5JsLovoN4vgRzDtDc1SI4GpqM4Nc0mz/uMURV
        LgX606mZR3bLPR3w+LJkOBBgPBZrKhcNxoq31mIsUeAHGQh1bvTi/QPCVn4i3Ic109Tbet
        tBr4IDUXzyMFXgpUhNm0ZK9XdKMNo3arIS29jDz9n4CFGaLUWDb0uH0mKXmCHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611838199;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TUr7IFoF5kI6Mx+O9CiyNn3W+CBk8v5MGz/vV94KWNs=;
        b=v+b0K5LroAh3Lewl/tzY3TCUTew1YtyEA9TJReg/Yug1M0yP0xnD35cddGxd6KfO+rK3Zd
        l9FodY29SXzt8vAQ==
From:   "tip-bot2 for Yuxuan Shui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] entry: Unbreak single step reporting behaviour
Cc:     Yuxuan Shui <yshuiv7@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <877do3gaq9.fsf@m5Zedd9JOGzJrf0>
References: <877do3gaq9.fsf@m5Zedd9JOGzJrf0>
MIME-Version: 1.0
Message-ID: <161183819817.23325.234499020067024025.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     41c1a06d1d1544bed9692ba72a5692454eee1945
Gitweb:        https://git.kernel.org/tip/41c1a06d1d1544bed9692ba72a5692454eee1945
Author:        Yuxuan Shui <yshuiv7@gmail.com>
AuthorDate:    Sat, 23 Jan 2021 03:21:32 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 28 Jan 2021 13:46:55 +01:00

entry: Unbreak single step reporting behaviour

The move of TIF_SYSCALL_EMU to SYSCALL_WORK_SYSCALL_EMU broke single step
reporting. The original code reported the single step when TIF_SINGLESTEP
was set and TIF_SYSCALL_EMU was not set. The SYSCALL_WORK conversion got
the logic wrong and now the reporting only happens when both bits are set.

Restore the original behaviour.

[ tglx: Massaged changelog and dropped the pointless double negation ]

Fixes: 64eb35f701f0 ("ptrace: Migrate TIF_SYSCALL_EMU to use SYSCALL_WORK flag")
Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Link: https://lore.kernel.org/r/877do3gaq9.fsf@m5Zedd9JOGzJrf0
---
 kernel/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 3783416..6dd82be 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -222,7 +222,7 @@ static inline bool report_single_step(unsigned long work)
  */
 static inline bool report_single_step(unsigned long work)
 {
-	if (!(work & SYSCALL_WORK_SYSCALL_EMU))
+	if (work & SYSCALL_WORK_SYSCALL_EMU)
 		return false;
 
 	return !!(current_thread_info()->flags & _TIF_SINGLESTEP);
