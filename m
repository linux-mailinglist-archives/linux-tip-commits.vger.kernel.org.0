Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4721E23E471
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Aug 2020 01:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgHFXiu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 Aug 2020 19:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgHFXis (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52446C061574;
        Thu,  6 Aug 2020 16:38:48 -0700 (PDT)
Date:   Thu, 06 Aug 2020 23:38:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757126;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hd4O0m85sH388k9+gMMkBCM/FtfvMXzNaeJ6lUqneq8=;
        b=NYk3aP8bsDA/CehLZ52kgOfMT7HAeqhM+971+SV9d8WGw4S4EwwK74v+y/+Wtxpd1RYG4+
        ioED5q7coXpR7Ok4FGwelUx0aS0iP+Jng+OL6OGsJpwUbVxYrKC872SV4Bpz6StnaiG3R+
        cqnWyFwRYciRWRQA4LRKmSbN3j51KE7M9INiFruRaqU5J2STay+UDJMOTKYD4z/rha/F1O
        Z7dI6vz+z6tiMYlvqDmjs+COG0bDrHn6anDEFi65aVAzNwowJ/XyRCHxgFxpyeL7YOLiqr
        TfyjmF3r1dPET9hEuFEcCEayPFNyImkWdK3e8zFseTW/vpPqDHJ2HyYN6FU8LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757126;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hd4O0m85sH388k9+gMMkBCM/FtfvMXzNaeJ6lUqneq8=;
        b=xD8/l9sThlJtDVRrSgiq3I/vEnhNyOTyaMtATcb3Dhm8MHCGgbPtlED0NMW2ZkmEA7lA40
        4a2XGnI8aYKSPnAA==
From:   "tip-bot2 for Lianbo Jiang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/crash: Correct the address boundary of function
 parameters
Cc:     Lianbo Jiang <lijiang@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Young <dyoung@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200804044933.1973-2-lijiang@redhat.com>
References: <20200804044933.1973-2-lijiang@redhat.com>
MIME-Version: 1.0
Message-ID: <159675712611.3192.9276107273934429682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a3e1c3bb24e2ff2927af5e30c2bebe669bb84196
Gitweb:        https://git.kernel.org/tip/a3e1c3bb24e2ff2927af5e30c2bebe669bb84196
Author:        Lianbo Jiang <lijiang@redhat.com>
AuthorDate:    Tue, 04 Aug 2020 12:49:31 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 07 Aug 2020 01:32:00 +02:00

x86/crash: Correct the address boundary of function parameters

Let's carefully handle the boundary of the function parameter to make
sure that the arguments passed doesn't exceed the address range.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Young <dyoung@redhat.com>
Link: https://lore.kernel.org/r/20200804044933.1973-2-lijiang@redhat.com
---
 arch/x86/kernel/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index fd87b59..a8f3af2 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -230,7 +230,7 @@ static int elf_header_exclude_ranges(struct crash_mem *cmem)
 	int ret = 0;
 
 	/* Exclude the low 1M because it is always reserved */
-	ret = crash_exclude_mem_range(cmem, 0, 1<<20);
+	ret = crash_exclude_mem_range(cmem, 0, (1<<20)-1);
 	if (ret)
 		return ret;
 
