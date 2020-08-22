Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95BA24E6BF
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Aug 2020 11:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgHVJmq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 22 Aug 2020 05:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgHVJmq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 22 Aug 2020 05:42:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB1FC061573;
        Sat, 22 Aug 2020 02:42:45 -0700 (PDT)
Date:   Sat, 22 Aug 2020 09:42:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598089363;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tpRCCzDjfro++Pmy0tIrOIDrvnAFjfGxvLuvwi730fk=;
        b=BtIlCb9S7MAAU7LbAhBKCacujbBTWcR8Ekchjl0dMpWQ36WMbVwkdNkcSplbxp/dJNHXN7
        GK6WrsV/t0eROfpodYIGfXWHXvmJjj8ymbG6IMQ/JX3Hl3dkkSK1KtRI79nlX2gVJSxw81
        N5rP2IuwahWMXKP2CORpufyApbSPwomKMeEFhFw8WRtfpSRZRActwMqVMiPYajsvuyHxX/
        bEnJ2lH/un1gszPKxZR6SuBr94r0iTeS5tZeIaupN1i0hHxmHuIZINVayfh0zobxo99qBA
        NMaV3Dsc3VbpfSJW6jWS56YBEmmHBeyjzysFYmaNthtZq9BMkHE1t/z7qzECyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598089363;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tpRCCzDjfro++Pmy0tIrOIDrvnAFjfGxvLuvwi730fk=;
        b=gk4xtRkNl0QwcqGZwfmq+lWwYHxloVjtYLgWEeYatc33irn0U5oWEne5Ke1Xd1jD8j4du9
        7jaCKMiy0PPqXgDA==
From:   "tip-bot2 for Chris Down" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/msr: Make source of unrecognised MSR writes unambiguous
Cc:     Chris Down <chris@chrisdown.name>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C6f6fbd0ee6c99bc5e47910db700a6642159db01b=2E15980?=
 =?utf-8?q?11595=2Egit=2Echris=40chrisdown=2Ename=3E?=
References: =?utf-8?q?=3C6f6fbd0ee6c99bc5e47910db700a6642159db01b=2E159801?=
 =?utf-8?q?1595=2Egit=2Echris=40chrisdown=2Ename=3E?=
MIME-Version: 1.0
Message-ID: <159808936198.3192.9491971431453881525.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     c31feed8461fb8648075ba9b53d9e527d530972f
Gitweb:        https://git.kernel.org/tip/c31feed8461fb8648075ba9b53d9e527d530972f
Author:        Chris Down <chris@chrisdown.name>
AuthorDate:    Fri, 21 Aug 2020 13:10:35 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 22 Aug 2020 11:40:38 +02:00

x86/msr: Make source of unrecognised MSR writes unambiguous

In many cases, task_struct.comm isn't enough to distinguish the
offender, since for interpreted languages it's likely just going to be
"python3" or whatever. Add the pid to make it unambiguous.

 [ bp: Make the printk string a single line for easier grepping. ]

Signed-off-by: Chris Down <chris@chrisdown.name>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/6f6fbd0ee6c99bc5e47910db700a6642159db01b.1598011595.git.chris@chrisdown.name
---
 arch/x86/kernel/msr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index b03001d..c0d4098 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -102,8 +102,8 @@ static int filter_write(u32 reg)
 	if (reg == MSR_IA32_ENERGY_PERF_BIAS)
 		return 0;
 
-	pr_err("Write to unrecognized MSR 0x%x by %s\n"
-	       "Please report to x86@kernel.org\n", reg, current->comm);
+	pr_err("Write to unrecognized MSR 0x%x by %s (pid: %d). Please report to x86@kernel.org.\n",
+	       reg, current->comm, current->pid);
 
 	return 0;
 }
