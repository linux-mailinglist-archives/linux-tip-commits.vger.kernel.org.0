Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3B33F479E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbhHWJdd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:33:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39214 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbhHWJdc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:33:32 -0400
Date:   Mon, 23 Aug 2021 09:32:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629711168;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ckrqYImqmHdR82uwvDZsc8Mo9VNLpaFZ6UD4e056Yg=;
        b=n6J+h+7lD931EkuUEZ8yMipaqxxybW9+iBIhZvdx1aHO3MgpEmwpWQDKD4IxT77qXPCatP
        sePyPLK5nu1ibtHchUtJ5MgtxmguSHm175PwpUWy8Qji3ejrpS7WRa92HZjGTRCRKQdxto
        flGTAW9zIaNMrNFzlI3CyT+V09/P645UF8n+m+1tANOY0mWtQcuxBf5Q3Nl7Y4OaZDZq5b
        V9J/EEeepa2x9gYZdzEBmzs2wLDC91epEg4lj837Vw4JWcV5Pa5I4lH0tSNOFablyHxI6R
        AW982sB998qO/o+dlaDHPAHenL4TL4YOO+Dc80pEAhNQCEbh/McpQp0q5DmJEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629711168;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ckrqYImqmHdR82uwvDZsc8Mo9VNLpaFZ6UD4e056Yg=;
        b=MLC/FR9rwce+OK5RqKsvxWBddn195O6qrh8xLrHYUGYzjobDW/uYxMNlGN6mQJc6eRgWF5
        griHoN70nV9eMGAQ==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/ibs: Add workaround for erratum #1,197
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210817221048.88063-3-kim.phillips@amd.com>
References: <20210817221048.88063-3-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <162971116811.25758.8933785673409400346.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ba02a6dc5693d1db817850f4ba5602d003d0cefb
Gitweb:        https://git.kernel.org/tip/ba02a6dc5693d1db817850f4ba5602d003d0cefb
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 17 Aug 2021 17:10:42 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:33:12 +02:00

perf/x86/amd/ibs: Add workaround for erratum #1,197

Erratum #1197 "IBS (Instruction Based Sampling) Register State May be
Incorrect After Restore From CC6" is published in a document:

  "Revision Guide for AMD Family 19h Models 00h-0Fh Processors" 56683 Rev. 1.04 July 2021

  https://bugzilla.kernel.org/show_bug.cgi?id=206537

Implement the erratum's suggested workaround and ignore IBS samples if
MSRC001_1031 == 0.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210817221048.88063-3-kim.phillips@amd.com
---
 arch/x86/events/amd/ibs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 8c25fbd..222c890 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -90,6 +90,7 @@ struct perf_ibs {
 	unsigned long			offset_mask[1];
 	int				offset_max;
 	unsigned int			fetch_count_reset_broken : 1;
+	unsigned int			fetch_ignore_if_zero_rip : 1;
 	struct cpu_perf_ibs __percpu	*pcpu;
 
 	struct attribute		**format_attrs;
@@ -673,6 +674,10 @@ fail:
 	if (check_rip && (ibs_data.regs[2] & IBS_RIP_INVALID)) {
 		regs.flags &= ~PERF_EFLAGS_EXACT;
 	} else {
+		/* Workaround for erratum #1,197 */
+		if (perf_ibs->fetch_ignore_if_zero_rip && !(ibs_data.regs[1]))
+			goto out;
+
 		set_linear_ip(&regs, ibs_data.regs[1]);
 		regs.flags |= PERF_EFLAGS_EXACT;
 	}
@@ -770,6 +775,9 @@ static __init void perf_event_ibs_init(void)
 	if (boot_cpu_data.x86 >= 0x16 && boot_cpu_data.x86 <= 0x18)
 		perf_ibs_fetch.fetch_count_reset_broken = 1;
 
+	if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model < 0x10)
+		perf_ibs_fetch.fetch_ignore_if_zero_rip = 1;
+
 	perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
 
 	if (ibs_caps & IBS_CAPS_OPCNT) {
