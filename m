Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EE83F8340
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 09:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbhHZHqP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 03:46:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58614 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240113AbhHZHqP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 03:46:15 -0400
Date:   Thu, 26 Aug 2021 07:45:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629963927;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WU2Vsci3rGMkyl6zo/NT52wDf8/v9Zn9CweTBZiDTl8=;
        b=KHkBgGBjcU2HB0aibWyVLSz4x8QDnZN//OGo9+RvHQcR1g/mWTrwZkPuaKVaABzuCNiIA/
        6k+Jub/H86o9tsq8z2aHQe/pIwebncKyijRqUvjVFAB6C0GcVxOcFj1cAsXnS8hqqOnWu4
        wXWj89f37m8xXF12lHD+YJD85xWTP/EubuUJsrl9h+g11Ei7wOsRd9wWibpx8zh+h5LMXv
        xPhjQjfbrgIhdsGESXJcHTnyE+DnlYDPyb3Kvjur5fq+IXVef3pKtbTdZrHgLuRbJxLrtL
        m9N7Z9OZ6elcgosYKqQEPe+aJ0mn2/R5I1zXVcLr2ZhUikDJHAGfsn+y82PQTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629963927;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WU2Vsci3rGMkyl6zo/NT52wDf8/v9Zn9CweTBZiDTl8=;
        b=f/MhwU0p4pkd20kNMFhd9SQqwvaDDftg+Ew9okb3/gGfGMECb+qzlaRqVXFiffHZYy4uUM
        CyB5Yi7T1YXqmmBQ==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd/ibs: Work around erratum #1197
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210817221048.88063-3-kim.phillips@amd.com>
References: <20210817221048.88063-3-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <162996392634.25758.2619063727360581093.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     26db2e0c51fe83e1dd852c1321407835b481806e
Gitweb:        https://git.kernel.org/tip/26db2e0c51fe83e1dd852c1321407835b481806e
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 17 Aug 2021 17:10:42 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Aug 2021 08:58:02 +02:00

perf/x86/amd/ibs: Work around erratum #1197

Erratum #1197 "IBS (Instruction Based Sampling) Register State May be
Incorrect After Restore From CC6" is published in a document:

  "Revision Guide for AMD Family 19h Models 00h-0Fh Processors" 56683 Rev. 1.04 July 2021

  https://bugzilla.kernel.org/show_bug.cgi?id=206537

Implement the erratum's suggested workaround and ignore IBS samples if
MSRC001_1031 == 0.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210817221048.88063-3-kim.phillips@amd.com
---
 arch/x86/events/amd/ibs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 40669ea..921f47b 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -90,6 +90,7 @@ struct perf_ibs {
 	unsigned long			offset_mask[1];
 	int				offset_max;
 	unsigned int			fetch_count_reset_broken : 1;
+	unsigned int			fetch_ignore_if_zero_rip : 1;
 	struct cpu_perf_ibs __percpu	*pcpu;
 
 	struct attribute		**format_attrs;
@@ -672,6 +673,10 @@ fail:
 	if (check_rip && (ibs_data.regs[2] & IBS_RIP_INVALID)) {
 		regs.flags &= ~PERF_EFLAGS_EXACT;
 	} else {
+		/* Workaround for erratum #1197 */
+		if (perf_ibs->fetch_ignore_if_zero_rip && !(ibs_data.regs[1]))
+			goto out;
+
 		set_linear_ip(&regs, ibs_data.regs[1]);
 		regs.flags |= PERF_EFLAGS_EXACT;
 	}
@@ -769,6 +774,9 @@ static __init void perf_event_ibs_init(void)
 	if (boot_cpu_data.x86 >= 0x16 && boot_cpu_data.x86 <= 0x18)
 		perf_ibs_fetch.fetch_count_reset_broken = 1;
 
+	if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model < 0x10)
+		perf_ibs_fetch.fetch_ignore_if_zero_rip = 1;
+
 	perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
 
 	if (ibs_caps & IBS_CAPS_OPCNT) {
