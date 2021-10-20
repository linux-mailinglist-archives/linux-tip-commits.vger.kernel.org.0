Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657F8434C8B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhJTNsn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhJTNr1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:47:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9B9C061772;
        Wed, 20 Oct 2021 06:44:45 -0700 (PDT)
Date:   Wed, 20 Oct 2021 13:44:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQcz641ODK++EIhBMzSeRggo5AqXnf2CAZe1Q8ihmCs=;
        b=a9HZgPXPDkBDDd6qNVGNP3dqHGTa3Lzj0QyRi0PB8yp5k1m4ZHB6rmpEcf1mk8slAvUsGO
        jBNID3sd8w26sXt9o7Fj/ni++3yYKYfr7T90/ydrI308MjeidarlzCbA8okJefNu5hbZqc
        NILMPWfs8Gio5ZYMf2jbGT6d+H6b51POKHoTFiY56RESzKkRqffV2vwyY6j1Rb+YnYZliv
        SIsdVbhIEIZN3AAb4rQTcB/AZjkKZtiBxJFYf9EQkKbh8cDYRZvgil4rSq34JUDvEjXY8M
        nRm7ErCbuFJ/X72K1EH3dg6JnEIDCOlImcc4EQzugonZVO7vJ1qXHZ9LfmO9UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQcz641ODK++EIhBMzSeRggo5AqXnf2CAZe1Q8ihmCs=;
        b=ugrOQc3TgK5vD8piFbFKvKPkWAFkpE7wveclhwlr4bYhBTsTnnPd265Td5Lr0NvFucXJoX
        mZ8u1sLB+CXOXhCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Remove pointless memset in fpu_clone()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011538.722854569@linutronix.de>
References: <20211015011538.722854569@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473748299.25758.1764135013570035920.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     01f9f62d3ae75077a54a11d2777082f1e58e2d9f
Gitweb:        https://git.kernel.org/tip/01f9f62d3ae75077a54a11d2777082f1e58e2d9f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:02 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:26 +02:00

x86/fpu: Remove pointless memset in fpu_clone()

Zeroing the forked task's FPU registers buffer to avoid leaking init
optimized stale data into the clone is a pointless exercise for the case
where the current task has TIF_NEED_FPU_LOAD set. In that case, the FPU
registers state is copied from current's FPU register buffer which can
contain stale init optimized data as well.

The alledged information leak is non-existant because this stale init
optimized data is used nowhere and cannot leak anywhere.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011538.722854569@linutronix.de
---
 arch/x86/kernel/fpu/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 7ada7bd..191269e 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -260,12 +260,6 @@ int fpu_clone(struct task_struct *dst)
 		return 0;
 
 	/*
-	 * Don't let 'init optimized' areas of the XSAVE area
-	 * leak into the child task:
-	 */
-	memset(&dst_fpu->state.xsave, 0, fpu_kernel_xstate_size);
-
-	/*
 	 * If the FPU registers are not owned by current just memcpy() the
 	 * state.  Otherwise save the FPU registers directly into the
 	 * child's FPU context, without any memory-to-memory copying.
