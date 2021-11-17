Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9927C4547FA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Nov 2021 15:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbhKQODn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Nov 2021 09:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbhKQOCz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Nov 2021 09:02:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C46C0613B9;
        Wed, 17 Nov 2021 05:59:56 -0800 (PST)
Date:   Wed, 17 Nov 2021 13:59:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637157595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F71+UBqMZGuWCePbXxqjRotOqtIrGB8SYmUYxRyo+94=;
        b=KC/rl/z2TaMMq8AZlagZgnTil5D61Jicqd/Rk8ZjN24+ZrAG1vbxSmNEUjbf2Es2BdMGqV
        jpCHlSSU1kp8Ams+mW8aLXUWcNI1ZCAXzC3mcNcWRHfRHBC2KM45u98rA+bcqNHerebJt3
        SEO1njdD1C5BkNNl0S+o1YUkFMayP4qE4ZKzHd9hlOkHnz0lymkgUGE33jflHc8dKxYgHR
        c40+achW1lia5q2JCwBW30w2QQwaf4W1NWwDbqNW4lujLZ6hKJHquKavGLCYCJdoRoneo2
        iw9Pd8kY34jEChnAT6hHydc8S6kovSbOYqJGCPDzSsPDQhxRgNQNXfR7+f4xZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637157595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F71+UBqMZGuWCePbXxqjRotOqtIrGB8SYmUYxRyo+94=;
        b=PTVMnxRkmWwyOOs6P2ZSGNIteWXjARW5VDpqO9NtVQ+JFED+HXRR458+qX/rZk+Wng5hIL
        Hm4418nwTzLcj7Bw==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Fix filter_tid mask for CHA
 events on Skylake Server
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211115090334.3789-2-alexander.antonov@linux.intel.com>
References: <20211115090334.3789-2-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163715759422.11128.17773038271358383555.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     e324234e0aa881b7841c7c713306403e12b069ff
Gitweb:        https://git.kernel.org/tip/e324234e0aa881b7841c7c713306403e12b069ff
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Mon, 15 Nov 2021 12:03:32 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Nov 2021 14:48:43 +01:00

perf/x86/intel/uncore: Fix filter_tid mask for CHA events on Skylake Server

According Uncore Reference Manual: any of the CHA events may be filtered
by Thread/Core-ID by using tid modifier in CHA Filter 0 Register.
Update skx_cha_hw_config() to follow Uncore Guide.

Fixes: cd34cd97b7b4 ("perf/x86/intel/uncore: Add Skylake server uncore support")
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20211115090334.3789-2-alexander.antonov@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index eb2c6ce..e5ee6bb 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3608,6 +3608,9 @@ static int skx_cha_hw_config(struct intel_uncore_box *box, struct perf_event *ev
 	struct hw_perf_event_extra *reg1 = &event->hw.extra_reg;
 	struct extra_reg *er;
 	int idx = 0;
+	/* Any of the CHA events may be filtered by Thread/Core-ID.*/
+	if (event->hw.config & SNBEP_CBO_PMON_CTL_TID_EN)
+		idx = SKX_CHA_MSR_PMON_BOX_FILTER_TID;
 
 	for (er = skx_uncore_cha_extra_regs; er->msr; er++) {
 		if (er->event != (event->hw.config & er->config_mask))
