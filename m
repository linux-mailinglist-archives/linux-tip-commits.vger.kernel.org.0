Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477E22B29C6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Nov 2020 01:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgKNASF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 13 Nov 2020 19:18:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56106 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKNASE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 13 Nov 2020 19:18:04 -0500
Date:   Sat, 14 Nov 2020 00:18:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605313082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Y6QUSct+LSWBUOXnsqzWhiWVdRDh6X544dsTtmbEFI=;
        b=O05S74/JLuq8kZLHAatrUTEPod+VAklV67nBtVF9999r1K3AkdTGoyXzddhCqAbssdvFHd
        DF0ADv0SyOCWjiTjaQ9Tcx4NodDScxQZnXZ3OjWRDbYn8tBpmGJiZVoyXTqiJKbofyksw+
        h6ahduLL1A0yKiNlquOnTWiSgeHqw6Q45tgt9sVzL7ORGsBja4gVRxYjGNAVptBPun3+3j
        dBR/My6dUZueOPuuQpb9IWf9tqpwR4uFBiAVOduUBr56xk0lOBRxLXs53hciYn0kA+dNU4
        tARu4K/ZpLOmNkzgWTkVgcXBLrDamVTrqneCe03WYI7O+ZlEQQBGgJynYso/Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605313082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Y6QUSct+LSWBUOXnsqzWhiWVdRDh6X544dsTtmbEFI=;
        b=n88a1WXiueK3i5bVOc2FNT3UgAK1MYE9VxpcBrF1Mb1xYn/vYesuAphM0LlOaLtFtini1G
        tubk8GsKmtS4+TDg==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Remove unused empty compat_exit_robust_list()
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <natechancellor@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201113172012.27221-1-lukas.bulwahn@gmail.com>
References: <20201113172012.27221-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <160531308152.11244.2917354987036179379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     932f8c64d38bb08f69c8c26a2216ba0c36c6daa8
Gitweb:        https://git.kernel.org/tip/932f8c64d38bb08f69c8c26a2216ba0c36c6daa8
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Fri, 13 Nov 2020 18:20:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 14 Nov 2020 01:15:35 +01:00

futex: Remove unused empty compat_exit_robust_list()

Commit ba31c1a48538 ("futex: Move futex exit handling into futex code")
introduced compat_exit_robust_list() with a full-fledged implementation for
CONFIG_COMPAT, and an empty-body function for !CONFIG_COMPAT.

However, compat_exit_robust_list() is only used in futex_mm_release() under
#ifdef CONFIG_COMPAT.

Hence for !CONFIG_COMPAT, make CC=clang W=1 warns:

  kernel/futex.c:314:20:
    warning: unused function 'compat_exit_robust_list' [-Wunused-function]

There is no need to declare the unused empty function for !CONFIG_COMPAT.

Simply remove it.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Link: https://lore.kernel.org/r/20201113172012.27221-1-lukas.bulwahn@gmail.com

---
 kernel/futex.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index ac32887..aee6ce2 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -310,8 +310,6 @@ static inline bool should_fail_futex(bool fshared)
 
 #ifdef CONFIG_COMPAT
 static void compat_exit_robust_list(struct task_struct *curr);
-#else
-static inline void compat_exit_robust_list(struct task_struct *curr) { }
 #endif
 
 /*
