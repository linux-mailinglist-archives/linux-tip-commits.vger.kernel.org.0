Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AF245F5DE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 26 Nov 2021 21:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242460AbhKZU3A (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 26 Nov 2021 15:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbhKZU07 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 26 Nov 2021 15:26:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE1EC06175C;
        Fri, 26 Nov 2021 12:22:57 -0800 (PST)
Date:   Fri, 26 Nov 2021 20:22:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637958175;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZ7+PZkcdXZoeOYVK6CTMMycpX1rD+aXeQd+fcK5LCw=;
        b=NTxDZdi0YLETc3PiaCP+lR+qPp0ud1VsIT4UfMdSJ2ZcGRVtIqzQH4WSm/cyA6BR52/fq5
        qzaam6ObBTRbPEHuzvmfrMlhwYN9KRFU7dYUY/ZFhZUxumPuhvgkYL+E4vEcoTznu1s36x
        55vuUAlQlmI6QxvSxwKRpJinU3kz+bDIBJog5BVUZoD6v3S6/C2ZIxlJr/fvqcbJ6eNEWl
        MU9Bj6lmOYNLsLS8VCch349PmGwPNgLm0TImzXqXZ/F7rJY4cGy1qW4w9vcOgcsX3v99zw
        LW93ScnHDVwKDJ/DI/FGW7FBhgOqkgU8YNgp8mjpv/bYWdAgJlwFLGNgYM1zsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637958175;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZ7+PZkcdXZoeOYVK6CTMMycpX1rD+aXeQd+fcK5LCw=;
        b=4vCGVBpHKDrMux+nLGVseS6EGYy/CYRJPje3kZwHN+OVCmrzxhLj6Jq6LNP+T71y10s63Q
        3FDvSbTkUN6+MACQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] powerpc: Avoid discarding flags in system_call_exception()
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eirik Fuller <efuller@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211117163050.53986-10-mark.rutland@arm.com>
References: <20211117163050.53986-10-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163795817446.11128.785246349140608166.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     51ed65dcfd9c61a15920a40178d471d236a7514c
Gitweb:        https://git.kernel.org/tip/51ed65dcfd9c61a15920a40178d471d236a7514c
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 17 Nov 2021 16:30:47 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 26 Nov 2021 21:20:13 +01:00

powerpc: Avoid discarding flags in system_call_exception()

Some thread flags can be set remotely, and so even when IRQs are
disabled, the flags can change under our feet. Thus, when setting flags
we must use an atomic operation rather than a plain read-modify-write
sequence, as a plain read-modify-write may discard flags which are
concurrently set by a remote thread, e.g.

	// task A			// task B
	tmp = A->thread_info.flags;
					set_tsk_thread_flag(A, NEWFLAG_B);
	tmp |= NEWFLAG_A;
	A->thread_info.flags = tmp;

In arch/powerpc/kernel/interrupt.c's system_call_exception(), we set
_TIF_RESTOREALL in the thread info flags with a read-modify-write, which
may result in other flags being discarded.

Elsewhere in the file we use clear_bits() to atomically remove flag
bits, so let's use set_bits() here for consistency with those.

I presume there may be reasons (e.g. instrumentation) that prevent the
use of set_thread_flag() and clear_thread_flag() here, which would
otherwise be preferable.

Fixes: ae7aaecc3f2f78b7 ("powerpc/64s: system call rfscv workaround for TM bugs")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Eirik Fuller <efuller@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Link: https://lore.kernel.org/r/20211117163050.53986-10-mark.rutland@arm.com
---
 arch/powerpc/kernel/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 835b626..1c821b7 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -148,7 +148,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 	 */
 	if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
 			unlikely(MSR_TM_TRANSACTIONAL(regs->msr)))
-		current_thread_info()->flags |= _TIF_RESTOREALL;
+		set_bits(_TIF_RESTOREALL, current_thread_info()->flags);
 
 	/*
 	 * If the system call was made with a transaction active, doom it and
