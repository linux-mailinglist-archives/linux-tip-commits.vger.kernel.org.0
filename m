Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F51027F21D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 21:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbgI3S65 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 14:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbgI3S64 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 14:58:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E603C061755;
        Wed, 30 Sep 2020 11:58:56 -0700 (PDT)
Date:   Wed, 30 Sep 2020 18:58:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601492335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+UI2kZEstOJxf+b4QwxS0/C5QmUn8bVnvgF/vLw7QwU=;
        b=KNzW5iMnibVz3nB9VfoMei7g3vW1YKNekkW3o5mlx1xhst8akB5LOgX32V33rKFZHjr2yn
        rldNr23TQOn2JB6qDeW+m7cJBybFIMh9g0FdyFkzueVUXf++uZH+YQF7PT7JnFcN4rg0bB
        VjKQ21mwyNSXepC6ns5fIcyae5hpaosasDHhRKaLWX6gx5nEirM+5Uh5aqhQ77T4n80MYK
        mEq5KP1y2N/7LvBjxu1NA+EprEOf5UIB4zTSgKJWPqzayGmsMdtMLavjLmfaNeutCtzFXa
        pCwpsiT8nEvNQ40XXIwsArvxVKU+FTnbMHuvZTtVldNXbnAVsU8UVJgo0a9ZqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601492335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+UI2kZEstOJxf+b4QwxS0/C5QmUn8bVnvgF/vLw7QwU=;
        b=A7ZByRCH49UCwmHwg8amngMc4kleAu66lVSxzloFit0UiObxtQITgbzXITCQfp1b12k8S4
        TRh3BKNBlr9L6wDA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Add Jasper Lake support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1601296242-32763-1-git-send-email-kan.liang@linux.intel.com>
References: <1601296242-32763-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160149233427.7002.10751745017528986245.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     dbfd638889a0396f5fe14ff3cc2263ec1e1cac62
Gitweb:        https://git.kernel.org/tip/dbfd638889a0396f5fe14ff3cc2263ec1e1cac62
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 28 Sep 2020 05:30:41 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 29 Sep 2020 09:57:01 +02:00

perf/x86/intel: Add Jasper Lake support

The Jasper Lake processor is also a Tremont microarchitecture. From the
perspective of Intel PMU, there is nothing changed compared with
Elkhart Lake.
Share the perf code with Elkhart Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1601296242-32763-1-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c72e490..75dea67 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5135,6 +5135,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_ATOM_TREMONT_D:
 	case INTEL_FAM6_ATOM_TREMONT:
+	case INTEL_FAM6_ATOM_TREMONT_L:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
