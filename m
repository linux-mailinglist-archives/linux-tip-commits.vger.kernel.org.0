Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9EA3F8384
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 10:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240420AbhHZIKl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 04:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240370AbhHZIKk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 04:10:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA73FC061757;
        Thu, 26 Aug 2021 01:09:53 -0700 (PDT)
Date:   Thu, 26 Aug 2021 08:09:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629965392;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSpS6PcsCITbcSByIm0FcQ5QKyXGeek2rVjkVyuT2rc=;
        b=LqmkOlaGknrpcRiBHu0MDOj3Z1tv7HZgg/d/4O70oagv0xKo9nzgiJIVOSUQc45G6omybf
        NSLcg1w/QT10HCgktP73c8ZvvPuPG3p4dcxzS+CnnSdkhwhPJTzNjSBHkTdZYjWAzpAJ+0
        hN649AeJb00+pTIZZIr6zyB4SJ00v0fcSp5v/B+D0EJwhjIioJayMsZMH+fBOqoUeALulR
        TM19k4BFNKzn1WgXTvo/79OlIsfgju3deP//xEURtQm05tpB9wZeKQkbLeFXlgxWbjLzf+
        XxkkTxwpnvIZdAqDvwHCMnG4E7YoMpAW3EHuGqHAaDDIp/I8vgTd/rmMnQ4STg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629965392;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSpS6PcsCITbcSByIm0FcQ5QKyXGeek2rVjkVyuT2rc=;
        b=t6J4SfWzFcZL2MhyvkRX66eI+IfSGLixIbThuTIryClOBFtr0UE4z7pQwirQgqTXrDWuV0
        +/2eWto9DZxwNcDQ==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/uncore: Clean up header use, use <linux/
 include paths instead of <asm/
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210817221048.88063-6-kim.phillips@amd.com>
References: <20210817221048.88063-6-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <162996539153.25758.766673531258678054.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0a0b53e0c3793c0930d258786702d48d21fc6383
Gitweb:        https://git.kernel.org/tip/0a0b53e0c3793c0930d258786702d48d21fc6383
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 17 Aug 2021 17:10:45 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Aug 2021 09:14:36 +02:00

perf/amd/uncore: Clean up header use, use <linux/ include paths instead of <asm/

Found by checkpatch.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210817221048.88063-6-kim.phillips@amd.com
---
 arch/x86/events/amd/uncore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 05bdb4c..7fb50ad 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -12,11 +12,11 @@
 #include <linux/init.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
+#include <linux/cpufeature.h>
+#include <linux/smp.h>
 
-#include <asm/cpufeature.h>
 #include <asm/perf_event.h>
 #include <asm/msr.h>
-#include <asm/smp.h>
 
 #define NUM_COUNTERS_NB		4
 #define NUM_COUNTERS_L2		4
