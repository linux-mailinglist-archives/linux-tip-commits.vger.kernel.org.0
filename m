Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A33415A74
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Sep 2021 11:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240028AbhIWJCT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 23 Sep 2021 05:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbhIWJCT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 23 Sep 2021 05:02:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6CEC061574;
        Thu, 23 Sep 2021 02:00:48 -0700 (PDT)
Date:   Thu, 23 Sep 2021 09:00:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632387646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KqDgHp7pC65TYmLcgMpRezFaGOBqgpP9GGW8svCrzOQ=;
        b=RE0wdvIxHLEuMS6ValV7lR+a5ifepDM7F0Jhkp7nwsloIsaOkeQakhg4Fw5wWuRGeN/bzF
        sKyvfAJIqnGHN0+HdSbtlauQyPbV6UGqCgoawPgDtK/r4D8SH81lwN7FnvNSho2bld7v1O
        xWglhrgWIYn2CyaTUlzD3/rYVAdMVtREbtsgX5uWv8l7bECz5iewBIt19ipSPnzV41fYcK
        0pGin1dfmb8I5VjZF+1ahvjXy+yT1G21oMRH6iNNr39hJ4Tjv2keZb60PQ0aUlt0gMs3L1
        +BNBKRumaQWE2Qt0X4Zh2kJbsgKcXkOU8l0sH2IQOBgDjeqUpJUM0kWnVBcm6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632387646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KqDgHp7pC65TYmLcgMpRezFaGOBqgpP9GGW8svCrzOQ=;
        b=QKKMIsDaXJT7iD2Je3oCYj9zWYmWMfcZpACIdlyM0w/pTgVX8BWwxm6+5F2fpG4HTiQrOe
        Xs+qLX5jtXXjjsDw==
From:   "tip-bot2 for Anders Roxell" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Fix missed conversion to correct
 boolean retval in save_xstate_epilog()
Cc:     Remi Duraffort <remi.duraffort@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210922200901.1823741-1-anders.roxell@linaro.org>
References: <20210922200901.1823741-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Message-ID: <163238764483.25758.11716568924329080028.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     724fc0248d450224b19ef5b5ee41e392348f6704
Gitweb:        https://git.kernel.org/tip/724fc0248d450224b19ef5b5ee41e392348f6704
Author:        Anders Roxell <anders.roxell@linaro.org>
AuthorDate:    Wed, 22 Sep 2021 22:09:01 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 23 Sep 2021 10:52:20 +02:00

x86/fpu/signal: Fix missed conversion to correct boolean retval in save_xstate_epilog()

Fix the missing return code polarity in save_xstate_epilog().

 [ bp: Massage, use the right commit in the Fixes: tag ]

Fixes: 2af07f3a6e9f ("x86/fpu/signal: Change return type of copy_fpregs_to_sigframe() helpers to boolean")
Reported-by: Remi Duraffort <remi.duraffort@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1461
Link: https://lkml.kernel.org/r/20210922200901.1823741-1-anders.roxell@linaro.org
---
 arch/x86/kernel/fpu/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 68f03da..39c7bae 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -106,7 +106,7 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame)
 	err = __copy_to_user(&x->i387.sw_reserved, sw_bytes, sizeof(*sw_bytes));
 
 	if (!use_xsave())
-		return err;
+		return !err;
 
 	err |= __put_user(FP_XSTATE_MAGIC2,
 			  (__u32 __user *)(buf + fpu_user_xstate_size));
