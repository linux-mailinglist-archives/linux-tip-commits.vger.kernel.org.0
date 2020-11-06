Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973262A9C58
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Nov 2020 19:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgKFSes (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 13:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgKFSep (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 13:34:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B46C0613CF;
        Fri,  6 Nov 2020 10:34:44 -0800 (PST)
Date:   Fri, 06 Nov 2020 18:34:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604687682;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Puqz4ukAZgIrEq385tfYzwFkVGA1caRrB6N7GK7a8SA=;
        b=iGBZ0jO1FJPogCHg6dlNHMYsj4vrnLFKws58iDmGI7oa70tHAEjavGrezlcu6csNtZMT3h
        MiBh4uAtNdyTbXId+ZL1cnI3CRiuqNYn1uRe5YgJ2eLtjnKkuJ6EG+ZPDQyObrFE6K46j9
        A5PUZfhXcyOGwg6CAu4ciWervtp7WBGDiowNP6Cqo604CAWo4HbDXMUqB7mqCt3cmaAPYn
        ijqMmX+zfQXVTa3isTvwOhzMP4Kz/0jrPUwXBGxjCFW2RfNm7s46wWPy3aYPIkYhL0e5v6
        +FORxEYRG/07OP5cGtr20xjZHfFNh65qQxVaCFQJXXD9oWJjio4N/hPQlRL9WQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604687682;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Puqz4ukAZgIrEq385tfYzwFkVGA1caRrB6N7GK7a8SA=;
        b=EMxIJk88egWD2d4f+4QgzFkjMWVMsOKZroCg2N0QGZvoKL7sx7koIhYogw2TWsyYKZi01v
        ZLh36Iirb8cnqdDQ==
From:   "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Correct the detection of invalid notifier priorities
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201106141216.2062-2-thunder.leizhen@huawei.com>
References: <20201106141216.2062-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <160468768153.397.11511315688950606406.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     15af36596ae305aefc8c502c2d3e8c58221709eb
Gitweb:        https://git.kernel.org/tip/15af36596ae305aefc8c502c2d3e8c58221709eb
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Fri, 06 Nov 2020 22:12:16 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 06 Nov 2020 19:02:48 +01:00

x86/mce: Correct the detection of invalid notifier priorities

Commit

  c9c6d216ed28 ("x86/mce: Rename "first" function as "early"")

changed the enumeration of MCE notifier priorities. Correct the check
for notifier priorities to cover the new range.

 [ bp: Rewrite commit message, remove superfluous brackets in
   conditional. ]

Fixes: c9c6d216ed28 ("x86/mce: Rename "first" function as "early"")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201106141216.2062-2-thunder.leizhen@huawei.com
---
 arch/x86/include/asm/mce.h     | 3 ++-
 arch/x86/kernel/cpu/mce/core.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index a0f1478..fc25c88 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -177,7 +177,8 @@ enum mce_notifier_prios {
 	MCE_PRIO_EXTLOG,
 	MCE_PRIO_UC,
 	MCE_PRIO_EARLY,
-	MCE_PRIO_CEC
+	MCE_PRIO_CEC,
+	MCE_PRIO_HIGHEST = MCE_PRIO_CEC
 };
 
 struct notifier_block;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 888248a..ccac4c2 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -162,7 +162,8 @@ EXPORT_SYMBOL_GPL(mce_log);
 
 void mce_register_decode_chain(struct notifier_block *nb)
 {
-	if (WARN_ON(nb->priority > MCE_PRIO_MCELOG && nb->priority < MCE_PRIO_EDAC))
+	if (WARN_ON(nb->priority < MCE_PRIO_LOWEST ||
+		    nb->priority > MCE_PRIO_HIGHEST))
 		return;
 
 	blocking_notifier_chain_register(&x86_mce_decoder_chain, nb);
