Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A2E44D68A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Nov 2021 13:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhKKMZH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Nov 2021 07:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbhKKMZG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Nov 2021 07:25:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1792C061767;
        Thu, 11 Nov 2021 04:22:17 -0800 (PST)
Date:   Thu, 11 Nov 2021 12:22:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636633335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EX6hhqcasOuF4l+g/9kTtv1Rf0C+onga7sN37fjE1P0=;
        b=tH7/slXBWZ8t9TPD3H6eLMNhhl/VrLRldBfTMReJtzgFGAG+56CJmOWPxk/CTm3NYEzdai
        xvxjzxI5iqo1ue2dEXdYPhjGZkigg7S6T4nCB1dNif0GnboW27sv1zEPepyCx3mOS1XHUX
        7lVuv6FnkjJZ70h5WsJR/B4Wa6gN2FIajXz+rguvSvyPCcpxj3LCRFvAHTe3Z/xWii971a
        lJvpjHvF6c7ryqOSv7zyHeiRleOIG0Qb+lsElyxTKkfALitvNGUF8NifQ4Lqkf1RkPxYbF
        eRYV28dAQzLG0HV3Uk8zq5r07h6VsVEK2QTRP4it+nBcpVm/HddL0C9pAc/X2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636633335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EX6hhqcasOuF4l+g/9kTtv1Rf0C+onga7sN37fjE1P0=;
        b=w1KkFk5Wt1ZWXy+aFThVAt3xW+0OSkTfGl38X6WjKJ6iHYx6NQlko6E9xRfnWfsqh+m1LP
        xYhBFmymUE6z8bAw==
From:   "tip-bot2 for Wanpeng Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/lbr: Reset LBR_SELECT during vlbr reset
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1636096851-36623-1-git-send-email-wanpengli@tencent.com>
References: <1636096851-36623-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Message-ID: <163663333495.414.16053123465892017137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     0fe39a3929ac7af980347814d552a734b51adacf
Gitweb:        https://git.kernel.org/tip/0fe39a3929ac7af980347814d552a734b51adacf
Author:        Wanpeng Li <wanpengli@tencent.com>
AuthorDate:    Fri, 05 Nov 2021 00:20:51 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 11 Nov 2021 13:09:34 +01:00

perf/x86/lbr: Reset LBR_SELECT during vlbr reset

lbr_select in kvm guest has residual data even if kvm guest is poweroff.
We can get residual data in the next boot. Because lbr_select is not
reset during kvm vlbr release. Let's reset LBR_SELECT during vlbr reset.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1636096851-36623-1-git-send-email-wanpengli@tencent.com
---
 arch/x86/events/intel/lbr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 6b72e9b..8043213 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -265,6 +265,8 @@ void intel_pmu_lbr_reset(void)
 
 	cpuc->last_task_ctx = NULL;
 	cpuc->last_log_id = 0;
+	if (!static_cpu_has(X86_FEATURE_ARCH_LBR) && cpuc->lbr_select)
+		wrmsrl(MSR_LBR_SELECT, 0);
 }
 
 /*
