Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581C62498CB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Aug 2020 10:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgHSIzW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 Aug 2020 04:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgHSIwL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 Aug 2020 04:52:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B9FC061345;
        Wed, 19 Aug 2020 01:52:11 -0700 (PDT)
Date:   Wed, 19 Aug 2020 08:52:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597827129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XE+IoxcNC4NFbcSMVhkgQU1Fvq5Q+vyJcOQnDhV//Nk=;
        b=PCYvJnVHLBCMH+MmzCg21K4tgVPoktGpOWMBEgAOoJf17EaU4KSkm1Yu8UI5TfU4CCYMWw
        2JbvZ53+ICOd11LC7b4J/p0VXTOpiU8hpJW0CoafsNH2vuup7VLRHjCV7LpVUqav2k/Vs6
        rml8ulNKYHz21vzjQnRq6ObGOnCeFca+MZTNH/PS3/7OBCiPJX5u50AYFg+zhULheXZX6P
        nK2hDLOJes/3zIP7umTR6z/JhuBK1t3A3VhbBQhaK7PL18zJ+1Pi1l635xe232/Uj9lR5s
        BP3yYG+7NOTq9W+KLgwFtejyUeaXCBNQyr/px7JytkQ758iPi42T5xODU3bzdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597827129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XE+IoxcNC4NFbcSMVhkgQU1Fvq5Q+vyJcOQnDhV//Nk=;
        b=nhldInzzKjRsVC/RHo0unrdBYJEczvXrrXUnPFmwDxCwT1JjRI7WVh1mYFD4ImUipdrp5+
        MgxBtXPPWRuVoCBw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Fix the name of perf METRICS
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200723171117.9918-6-kan.liang@linux.intel.com>
References: <20200723171117.9918-6-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159782712894.3192.17748434633648823222.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bbdbde2a415d9f479803266cae6fb0c1a9f6c80e
Gitweb:        https://git.kernel.org/tip/bbdbde2a415d9f479803266cae6fb0c1a9f6c80e
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 23 Jul 2020 10:11:08 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Aug 2020 16:34:35 +02:00

perf/x86/intel: Fix the name of perf METRICS

Bit 15 of the PERF_CAPABILITIES MSR indicates that the perf METRICS
feature is supported. The perf METRICS is not a PEBS feature.

Rename pebs_metrics_available perf_metrics.

The bit is not used in the current code. It will be used in a later
patch.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200723171117.9918-6-kan.liang@linux.intel.com
---
 arch/x86/events/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 7b68ab5..5d453da 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -537,7 +537,7 @@ union perf_capabilities {
 		 */
 		u64	full_width_write:1;
 		u64     pebs_baseline:1;
-		u64	pebs_metrics_available:1;
+		u64	perf_metrics:1;
 		u64	pebs_output_pt_available:1;
 	};
 	u64	capabilities;
