Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA70434C82
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhJTNrq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhJTNrE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:47:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828B3C06176F;
        Wed, 20 Oct 2021 06:44:44 -0700 (PDT)
Date:   Wed, 20 Oct 2021 13:44:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J/xOMNBeBBzdmEGTRT8SIhFizMcRD91l2rzTuLs/w6U=;
        b=aCTFb0cEaku2Obe4S7F2r2eb14R1rXyCTxrbvZLXPt41lbL4A3nTzKR9XHT7xoWqEINbtt
        A5EtBWvUUzB/zBBZsqLJu53x0ePsjnb+N+wVExaw6+GdLrF+ZNi1Fgh/GvAa5rk/eRWPPR
        7iIletNAnRblJV56YkQLn1IwZrWAxSFzzpXsplG+UxYD+YvecDdRISKV6aSbfwkET+avzW
        gG8f2Echjp6wGXKeAX709XwoBDgLVanCq1WgdII0qUro98mbRyrYeKcHlcyqBuM6EKlOh6
        1QEoxYtb+5w2/jjc7vQ72aR8P2lQcNSjGg9aYap2MnyjMt/6tV8nkQ/ZPGvqPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J/xOMNBeBBzdmEGTRT8SIhFizMcRD91l2rzTuLs/w6U=;
        b=GS+SQSBIzaxWk9epB3lLnGKvi7xTsUdnu6hTo1pkTuCBI9gFS7nqCLoF/ywCTuoeKei219
        7gbjreyJdR45qkCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/process: Clone FPU in copy_thread()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011538.780714235@linutronix.de>
References: <20211015011538.780714235@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473748230.25758.15564811556603342279.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     2d16a1876f20218f8970ea4b7f679cead1cdb510
Gitweb:        https://git.kernel.org/tip/2d16a1876f20218f8970ea4b7f679cead1cdb510
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:04 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:26 +02:00

x86/process: Clone FPU in copy_thread()

There is no reason to clone FPU in arch_dup_task_struct(). Quite the
contrary - it prevents optimizations. Move it to copy_thread().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011538.780714235@linutronix.de
---
 arch/x86/kernel/process.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e..d2227c5 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -87,7 +87,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 #ifdef CONFIG_VM86
 	dst->thread.vm86 = NULL;
 #endif
-	return fpu_clone(dst);
+	return 0;
 }
 
 /*
@@ -154,6 +154,8 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	frame->flags = X86_EFLAGS_FIXED;
 #endif
 
+	fpu_clone(p);
+
 	/* Kernel thread ? */
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		p->thread.pkru = pkru_get_init_value();
