Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CDD2D4966
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgLISpW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbgLISpV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:45:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5E2C0613CF;
        Wed,  9 Dec 2020 10:44:41 -0800 (PST)
Date:   Wed, 09 Dec 2020 18:44:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607539479;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSMXOJ06KUW9Qp0QMdwRiGLL9RbemCGh134wdgaLr64=;
        b=f5m5DIsfwNYa9QASGrpXcekWkowTQ9aB7px+uUR5S6tPuLwoY+zs3eK9Rn2zkE5i1RWaVR
        bzO/Io7117RY0eYF+tNwsATjuXhrYGh1KGemD1WdBEbejWLcR9gS8ivY4q5CoIRXZbTAa3
        9uxkl6plQmeRgqmhbbKlwk2901h5dy2bNuwbmH6/tCbThNAYHjyyR5z4g+gqFFH/tYp8ZZ
        UQYcHKgdiPmP+p0hU+kQhTcirJtBLSdjHNSyImB/YOoeYJY0F0Q34NofHLgzn946hG+7fM
        iZy+e4q1Ff5UF5Lwa3ph1H29pqD1JCr+Hhx+/doRTGqwA0kbMdrny87XF8zddA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607539479;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSMXOJ06KUW9Qp0QMdwRiGLL9RbemCGh134wdgaLr64=;
        b=HQjyLNvAy5Ed37oLKoFiZnU1IgYZmaCb2EPooxOTr14Gzjd9lxtaCfxVfuZ2MDmSVd4ghP
        qCZYzvhOj42zUTCA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Add Tremont Topdown support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1607457952-3519-1-git-send-email-kan.liang@linux.intel.com>
References: <1607457952-3519-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160753947871.3364.1276461404139222923.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c2208046bba6842dc232a600dc5cafc2fca41078
Gitweb:        https://git.kernel.org/tip/c2208046bba6842dc232a600dc5cafc2fca41078
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 08 Dec 2020 12:05:52 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Dec 2020 17:08:59 +01:00

perf/x86/intel: Add Tremont Topdown support

Tremont has four L1 Topdown events, TOPDOWN_FE_BOUND.ALL,
TOPDOWN_BAD_SPECULATION.ALL, TOPDOWN_BE_BOUND.ALL and
TOPDOWN_RETIRING.ALL. They are available on GP counters.

Export them to sysfs and facilitate the perf stat tool.

 $perf stat --topdown -- sleep 1

 Performance counter stats for 'sleep 1':

            retiring      bad speculation       frontend bound
backend bound
               24.9%                16.8%                31.7%
26.6%

       1.001224610 seconds time elapsed

       0.001150000 seconds user
       0.000000000 seconds sys

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1607457952-3519-1-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 6c0d18f..d4569bf 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -1901,6 +1901,19 @@ static __initconst const u64 tnt_hw_cache_extra_regs
 	},
 };
 
+EVENT_ATTR_STR(topdown-fe-bound,       td_fe_bound_tnt,        "event=0x71,umask=0x0");
+EVENT_ATTR_STR(topdown-retiring,       td_retiring_tnt,        "event=0xc2,umask=0x0");
+EVENT_ATTR_STR(topdown-bad-spec,       td_bad_spec_tnt,        "event=0x73,umask=0x6");
+EVENT_ATTR_STR(topdown-be-bound,       td_be_bound_tnt,        "event=0x74,umask=0x0");
+
+static struct attribute *tnt_events_attrs[] = {
+	EVENT_PTR(td_fe_bound_tnt),
+	EVENT_PTR(td_retiring_tnt),
+	EVENT_PTR(td_bad_spec_tnt),
+	EVENT_PTR(td_be_bound_tnt),
+	NULL,
+};
+
 static struct extra_reg intel_tnt_extra_regs[] __read_mostly = {
 	/* must define OFFCORE_RSP_X first, see intel_fixup_er() */
 	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x800ff0ffffff9fffull, RSP_0),
@@ -5174,6 +5187,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.lbr_pt_coexist = true;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.get_event_constraints = tnt_get_event_constraints;
+		td_attr = tnt_events_attrs;
 		extra_attr = slm_format_attr;
 		pr_cont("Tremont events, ");
 		name = "Tremont";
