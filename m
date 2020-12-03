Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE9F2CD226
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 10:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388475AbgLCJIc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 04:08:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39402 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388474AbgLCJIN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 04:08:13 -0500
Date:   Thu, 03 Dec 2020 09:07:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606986452;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pcponlC6uruF6FQQCv3EspZ7RmlM/d9+4H938Wxxdk4=;
        b=F2iCS+6WiNs+MKj1tzr3YT9NCZ27Ano4yii+PPaf3Av7e/S0cqSOC54mrUT59u88V14N24
        VLmP1rYLAu8dpL5PVptxRVXPDffQcUfMCDZVE8Rg5sqCaVDM7w9IRg9sFtzO6JGWSk5Wfb
        iZJhF5y/gJpjcaFUoben+aoEEJAXdtrTYGFvyzhIAP7+WoP/WLoaJ2EPtIh253IVJcDgzr
        yihx6ZcN232/WLzDqmitk+b70ldqZ98CAbt/3y/44yFVxn/4xyIIMpD+1ALig+HMvqKSCY
        XBJcPbnx1UzBOeW5Nqt0tM9IIc7l4YUFyz7bOht2UR4qhs5gYXVLwGRBgmpVHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606986452;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pcponlC6uruF6FQQCv3EspZ7RmlM/d9+4H938Wxxdk4=;
        b=O+/r9IftRpty9evcI0lzytFcuxmSa/5hyx0wSZfjy3D/Tvi95SxmNoVpRn3u0rWVCsxbLb
        QDH+W1IeARtkR6Bg==
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Check PEBS status correctly
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201126110922.317681-2-namhyung@kernel.org>
References: <20201126110922.317681-2-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <160698645173.3364.15000684811253542109.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     fc17db8aa4c53cbd2d5469bb0521ea0f0a6dbb27
Gitweb:        https://git.kernel.org/tip/fc17db8aa4c53cbd2d5469bb0521ea0f0a6dbb27
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Thu, 26 Nov 2020 20:09:22 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 10:00:26 +01:00

perf/x86/intel: Check PEBS status correctly

The kernel cannot disambiguate when 2+ PEBS counters overflow at the
same time. This is what the comment for this code suggests.  However,
I see the comparison is done with the unfiltered p->status which is a
copy of IA32_PERF_GLOBAL_STATUS at the time of the sample. This
register contains more than the PEBS counter overflow bits. It also
includes many other bits which could also be set.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201126110922.317681-2-namhyung@kernel.org
---
 arch/x86/events/intel/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 89dba58..485c506 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1916,7 +1916,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 		 * that caused the PEBS record. It's called collision.
 		 * If collision happened, the record will be dropped.
 		 */
-		if (p->status != (1ULL << bit)) {
+		if (pebs_status != (1ULL << bit)) {
 			for_each_set_bit(i, (unsigned long *)&pebs_status, size)
 				error[i]++;
 			continue;
