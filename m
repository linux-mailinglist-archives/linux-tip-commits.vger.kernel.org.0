Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0248E27F217
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 21:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgI3S64 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 14:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730441AbgI3S6z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 14:58:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9DAC061755;
        Wed, 30 Sep 2020 11:58:55 -0700 (PDT)
Date:   Wed, 30 Sep 2020 18:58:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601492333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ECVWFYHXLOLlAWg7ibFJFK5fCpEEO7HVUfCjKqOP7k=;
        b=pHcLeOPj6s8La3W8uxkG21MDAv3/AeiTuHcvNN/vZRSEJnV2xBzywKmD4FawWG9qtjNXUz
        Iq/QrFMTUT3h9hFx3ssACloiEtEdirh0QQwXXbUrewQ7guSXGn1sJKwLHiGVPyim6Bratm
        /3SnOJwblK+LRI0g2jdy/33i94vQbeAQU+vyC8sDVs4te2XhSCE/6rdwZwt9xLP8qmO2De
        eK6Y2zWo41JVxhs7tCrYwJveVac2z6MpS70nlW1QGsKNaTcz4scmBuuHXQ/PSz4TtR67AQ
        4W4fq9VOHuo0jlc1O6ZP9izZb/QQTzmPAu8p9UGk/YHKVyXzczH9HMW9qnWD5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601492333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ECVWFYHXLOLlAWg7ibFJFK5fCpEEO7HVUfCjKqOP7k=;
        b=QVAQvfOqsgag+Pd++yPxMx1K/xZJwHfPEM5HOkrNr26NKof9y0YkJsX6jfbHiNrEIJaSbd
        f5o8xLbFFEis72AQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Fix the scale of the IMC
 free-running events
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200928133240.12977-1-kan.liang@linux.intel.com>
References: <20200928133240.12977-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160149233284.7002.14214628011336778470.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8191016a026b8dfbb14dea64efc8e723ee99fe65
Gitweb:        https://git.kernel.org/tip/8191016a026b8dfbb14dea64efc8e723ee99fe65
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 28 Sep 2020 06:32:40 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 29 Sep 2020 09:57:02 +02:00

perf/x86/intel/uncore: Fix the scale of the IMC free-running events

The "MiB" result of the IMC free-running bandwidth events,
uncore_imc_free_running/read/ and uncore_imc_free_running/write/ are 16
times too small.

The "MiB" value equals the raw IMC free-running bandwidth counter value
times a "scale" which is inaccurate.

The IMC free-running bandwidth events should be incremented per 64B
cache line, not DWs (4 bytes). The "scale" should be 6.103515625e-5.
Fix the "scale" for both Snow Ridge and Ice Lake.

Fixes: 2b3b76b5ec67 ("perf/x86/intel/uncore: Add Ice Lake server uncore support")
Fixes: ee49532b38dd ("perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200928133240.12977-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 3f1e75f..7bdb182 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4807,10 +4807,10 @@ static struct uncore_event_desc snr_uncore_imc_freerunning_events[] = {
 	INTEL_UNCORE_EVENT_DESC(dclk,		"event=0xff,umask=0x10"),
 
 	INTEL_UNCORE_EVENT_DESC(read,		"event=0xff,umask=0x20"),
-	INTEL_UNCORE_EVENT_DESC(read.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(read.scale,	"6.103515625e-5"),
 	INTEL_UNCORE_EVENT_DESC(read.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(write,		"event=0xff,umask=0x21"),
-	INTEL_UNCORE_EVENT_DESC(write.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(write.scale,	"6.103515625e-5"),
 	INTEL_UNCORE_EVENT_DESC(write.unit,	"MiB"),
 	{ /* end: all zeroes */ },
 };
@@ -5268,17 +5268,17 @@ static struct uncore_event_desc icx_uncore_imc_freerunning_events[] = {
 	INTEL_UNCORE_EVENT_DESC(dclk,			"event=0xff,umask=0x10"),
 
 	INTEL_UNCORE_EVENT_DESC(read,			"event=0xff,umask=0x20"),
-	INTEL_UNCORE_EVENT_DESC(read.scale,		"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(read.scale,		"6.103515625e-5"),
 	INTEL_UNCORE_EVENT_DESC(read.unit,		"MiB"),
 	INTEL_UNCORE_EVENT_DESC(write,			"event=0xff,umask=0x21"),
-	INTEL_UNCORE_EVENT_DESC(write.scale,		"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(write.scale,		"6.103515625e-5"),
 	INTEL_UNCORE_EVENT_DESC(write.unit,		"MiB"),
 
 	INTEL_UNCORE_EVENT_DESC(ddrt_read,		"event=0xff,umask=0x30"),
-	INTEL_UNCORE_EVENT_DESC(ddrt_read.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(ddrt_read.scale,	"6.103515625e-5"),
 	INTEL_UNCORE_EVENT_DESC(ddrt_read.unit,		"MiB"),
 	INTEL_UNCORE_EVENT_DESC(ddrt_write,		"event=0xff,umask=0x31"),
-	INTEL_UNCORE_EVENT_DESC(ddrt_write.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(ddrt_write.scale,	"6.103515625e-5"),
 	INTEL_UNCORE_EVENT_DESC(ddrt_write.unit,	"MiB"),
 	{ /* end: all zeroes */ },
 };
