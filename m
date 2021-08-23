Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A513F4797
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhHWJda (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbhHWJda (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:33:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58D3C06175F;
        Mon, 23 Aug 2021 02:32:47 -0700 (PDT)
Date:   Mon, 23 Aug 2021 09:32:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629711166;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvGhgvjGG0TydiX1nZymYpqpernrxCJ2EJveFyImzqY=;
        b=BFN7j12p37amZdMOYM/4qhd/kHUtjm0L70NXIzwJyRQdPjgjNvwy/8/fkw8Easf18NdpjZ
        yqQCawCOy8gYOUpbKKfwcaryHJEXxSjqbdRz+Zff6jZcL1YbZsI9gwzinDeUK1+pnxhVEX
        SU51oPq+eee/EHMHsZIcWBd6LNs4VIewza63TKbN0SaWIBPZRtOyzdi5th8TRNxdzZzSzh
        gndwbL17RcBDNE22D6XFK5JQLpZSElPWbw32Pze+WQP6TJfvON3cb+hYK+xQuxmwoLrRih
        VXOLawE8coA5C+HjxmGPSYs1GKuzeiFLY6cGJ4DMeD6V3LLK4XFY/jLgacjABQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629711166;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvGhgvjGG0TydiX1nZymYpqpernrxCJ2EJveFyImzqY=;
        b=6z4u6VTh4mwkCKR5NibbTwnzwyaXZShZ8gG0n7gP5cA1gAEoM4SHGQ+bBBm0k3r5n6s6TB
        iv2S0ryImMZ4BTDA==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/uncore: Use linux/ include paths instead of asm/
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210817221048.88063-6-kim.phillips@amd.com>
References: <20210817221048.88063-6-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <162971116566.25758.345222925040721144.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e1706b30e939d3e62c2a2b9415ed9c6313bbb8e9
Gitweb:        https://git.kernel.org/tip/e1706b30e939d3e62c2a2b9415ed9c6313bbb8e9
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 17 Aug 2021 17:10:45 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:33:13 +02:00

perf/amd/uncore: Use linux/ include paths instead of asm/

Found by checkpatch.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
