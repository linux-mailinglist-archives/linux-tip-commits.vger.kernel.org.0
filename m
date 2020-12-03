Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82332CD222
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 10:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbgLCJIX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 04:08:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39410 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388475AbgLCJIO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 04:08:14 -0500
Date:   Thu, 03 Dec 2020 09:07:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606986452;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ylstBfkGIp6f8PA/uydSSOdgeALXkHofBl+i/pMxRCc=;
        b=Y/XAuqJAeT8nR4sHmEDTeXzEdGirsM5r2+wMM7pJ6la7oagkmx1wFV2tYm4WA2pYra5NPO
        oHHVvQ1MUthYPw2UZt4PrFDNqwwe1PjopoTFB3eRl+R/aqfkVZWKggmF60wO2m6hubEhJA
        N1dh6nQfFdUdP4f4+qLgrS1eIXRp7cubIU7EXdF6knuZvITEaA6MybEwGJOcg/5NALgqv7
        kw0+cn+wxNvPNnuvHwpIZDjeGEWm0eM099f2WwsOqL+suEQDVOvOFPSeJXeisEPysQsS+q
        izh4OBrOEgLloCl0POc9lcnkQj09o03gi6RSlQ0IhbcLwOa77orhhLgEx3yfyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606986452;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ylstBfkGIp6f8PA/uydSSOdgeALXkHofBl+i/pMxRCc=;
        b=hWldpK07p5ZjT2wgOgXGj4UmfdPezPfjHkgxgqNZ99bGLEyCJYcWSjO7MrOzxqZRHxGkss
        +DpCVbdyjIWIoPBQ==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Fix a warning on x86_pmu_stop()
 with large PEBS
Cc:     John Sperbeck <jsperbeck@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201126110922.317681-1-namhyung@kernel.org>
References: <20201126110922.317681-1-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <160698645187.3364.7298123727260503184.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     5debf02131227d39988e44adf5090fb796fa8466
Gitweb:        https://git.kernel.org/tip/5debf02131227d39988e44adf5090fb796fa8466
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Thu, 26 Nov 2020 20:09:21 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 10:00:26 +01:00

perf/x86/intel: Fix a warning on x86_pmu_stop() with large PEBS

The commit 3966c3feca3f ("x86/perf/amd: Remove need to check "running"
bit in NMI handler") introduced this.  It seems x86_pmu_stop can be
called recursively (like when it losts some samples) like below:

  x86_pmu_stop
    intel_pmu_disable_event  (x86_pmu_disable)
      intel_pmu_pebs_disable
        intel_pmu_drain_pebs_nhm  (x86_pmu_drain_pebs_buffer)
          x86_pmu_stop

While commit 35d1ce6bec13 ("perf/x86/intel/ds: Fix x86_pmu_stop
warning for large PEBS") fixed it for the normal cases, there's
another path to call x86_pmu_stop() recursively when a PEBS error was
detected (like two or more counters overflowed at the same time).

Like in the Kan's previous fix, we can skip the interrupt accounting
for large PEBS, so check the iregs which is set for PMI only.

Fixes: 3966c3feca3f ("x86/perf/amd: Remove need to check "running" bit in NMI handler")
Reported-by: John Sperbeck <jsperbeck@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201126110922.317681-1-namhyung@kernel.org
---
 arch/x86/events/intel/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index b47cc42..89dba58 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1940,7 +1940,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 		if (error[bit]) {
 			perf_log_lost_samples(event, error[bit]);
 
-			if (perf_event_account_interrupt(event))
+			if (iregs && perf_event_account_interrupt(event))
 				x86_pmu_stop(event, 0);
 		}
 
