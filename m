Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C42526FEA6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 15:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgIRNfQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 09:35:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34462 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRNfQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 09:35:16 -0400
Date:   Fri, 18 Sep 2020 13:35:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600436114;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rK3lS4IY7ZktPpReXIKTgyey3lWUsewgdHql5ETQv6A=;
        b=nZu0WCPtiIXMJVowo3FeGpxhAgzSGnjDN540F8N5mimVRCWspYE00bOzTsa40g4MltY6IM
        1Lg1V4F/LSVtLnaUnbXAsbb5iLMzxJnF1PSyh6Sj/JM9U+FwCRXsj9SwmscCa0WpN8Xsxy
        T8JIlqDWXW4/Kl95vK0iCOg2HH9viwIlDyrX8Eo9cOBSSrOlItPQDnvD2os0FgFaBVlUgm
        pm5wq8vwEeGzRPvD0pd4uZy+g5kQDIBCV/+Dyp6rvVho4MOc9Obhv2Qzo/2t5qFx13njOU
        dtzzWsBJyH7VpwpPbMYqw6PAse+Araj439rW2oANy+5AniAJ61MAOHKjbtQb3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600436114;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rK3lS4IY7ZktPpReXIKTgyey3lWUsewgdHql5ETQv6A=;
        b=Gr6wJLqNzQl4jvv+BPjyMU72j7/sUc8KAf6Fu3R/vIvVpmJn/4PUX25up02T5ohc8V2zrL
        PSr8CAiIWeNDOVCA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Annotate mce_rd/wrmsrl() with noinstr
Cc:     Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200915194020.28807-1-bp@alien8.de>
References: <20200915194020.28807-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <160043611320.15536.8690718726101063839.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     e100777016fdf6ec3a9d7c1773b15a2b5eca6c55
Gitweb:        https://git.kernel.org/tip/e100777016fdf6ec3a9d7c1773b15a2b5eca6c55
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 14 Sep 2020 19:21:28 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Sep 2020 15:21:11 +02:00

x86/mce: Annotate mce_rd/wrmsrl() with noinstr

They do get called from the #MC handler which is already marked
"noinstr".

Commit

  e2def7d49d08 ("x86/mce: Make mce_rdmsrl() panic on an inaccessible MSR")

already got rid of the instrumentation in the MSR accessors, fix the
annotation now too, in order to get rid of:

  vmlinux.o: warning: objtool: do_machine_check()+0x4a: call to mce_rdmsrl() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200915194020.28807-1-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/core.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5b1d5f3..11b6697 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -392,16 +392,25 @@ __visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,
 }
 
 /* MSR access wrappers used for error injection */
-static u64 mce_rdmsrl(u32 msr)
+static noinstr u64 mce_rdmsrl(u32 msr)
 {
 	DECLARE_ARGS(val, low, high);
 
 	if (__this_cpu_read(injectm.finished)) {
-		int offset = msr_to_offset(msr);
+		int offset;
+		u64 ret;
 
+		instrumentation_begin();
+
+		offset = msr_to_offset(msr);
 		if (offset < 0)
-			return 0;
-		return *(u64 *)((char *)this_cpu_ptr(&injectm) + offset);
+			ret = 0;
+		else
+			ret = *(u64 *)((char *)this_cpu_ptr(&injectm) + offset);
+
+		instrumentation_end();
+
+		return ret;
 	}
 
 	/*
@@ -437,15 +446,21 @@ __visible bool ex_handler_wrmsr_fault(const struct exception_table_entry *fixup,
 	return true;
 }
 
-static void mce_wrmsrl(u32 msr, u64 v)
+static noinstr void mce_wrmsrl(u32 msr, u64 v)
 {
 	u32 low, high;
 
 	if (__this_cpu_read(injectm.finished)) {
-		int offset = msr_to_offset(msr);
+		int offset;
 
+		instrumentation_begin();
+
+		offset = msr_to_offset(msr);
 		if (offset >= 0)
 			*(u64 *)((char *)this_cpu_ptr(&injectm) + offset) = v;
+
+		instrumentation_end();
+
 		return;
 	}
 
