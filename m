Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61053436563
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhJUPOx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhJUPOs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380A5C0613B9;
        Thu, 21 Oct 2021 08:12:32 -0700 (PDT)
Date:   Thu, 21 Oct 2021 15:12:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829150;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5MVvkxsX+NFR6SZcqmBzIAL0XMaytlycG9PiXLVFtBM=;
        b=USo6RIX01DPh2R3+e8/apV8j8LQHV+H1hZy9c2LZ4FZ8J0xnVAYBXIdFxSv3m0SddcM+VP
        7MVcoCN6bv8FAOTj6B59j7S7I6CcljLThaRe4xzxhyEnsXlD2KdLw2j8WhPXbKewwArjw5
        2s/yYY90WFmHKPKvD6JZh+6MspNrm3lFiQeQazSe4kPAKQGvyssbUCLndnxvYZQtF6PKgs
        LuohMsCGk8vpqrNFdRwjuqgW7ATQ6gsNCIdXCzj1yqIi4WnLML1aBdmNkJlHH4uAdgsKcw
        Itj+2zjBXiikLQBgLwTCk1TEgCcQfTKYwGHubFMEotUvcjHVKOnhXgulDgy7cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829150;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5MVvkxsX+NFR6SZcqmBzIAL0XMaytlycG9PiXLVFtBM=;
        b=WKJYm8aJazjI5a9k4TR48FaX7wSrnnZUvQy9tqgSGhQN7VBbXevvU7qBhePOJj8pk/A0O6
        4Pnb2MIwHpqSamBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Do not leak fpstate pointer on fork
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211013145322.817101108@linutronix.de>
References: <20211013145322.817101108@linutronix.de>
MIME-Version: 1.0
Message-ID: <163482915002.25758.6686457809921904021.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     f0cbc8b3cdf7d1c724155cd9cecffe329bb96119
Gitweb:        https://git.kernel.org/tip/f0cbc8b3cdf7d1c724155cd9cecffe329bb96119
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Oct 2021 16:55:43 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 09:32:41 +02:00

x86/fpu: Do not leak fpstate pointer on fork

If fork fails early then the copied task struct would carry the fpstate
pointer of the parent task.

Not a problem right now, but later when dynamically allocated buffers
are available, keeping the pointer might result in freeing the
parent's buffer. Set it to NULL which prevents that. If fork reaches
clone_thread(), the pointer will be correctly set to the new task
context.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211013145322.817101108@linutronix.de
---
 arch/x86/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5cd8208..c74c7e8 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -87,6 +87,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 #ifdef CONFIG_VM86
 	dst->thread.vm86 = NULL;
 #endif
+	/* Drop the copied pointer to current's fpstate */
+	dst->thread.fpu.fpstate = NULL;
 	return 0;
 }
 
