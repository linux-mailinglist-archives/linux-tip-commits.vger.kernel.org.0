Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422F641ECFA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 14:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354305AbhJAMMR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 08:12:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56880 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354298AbhJAMMO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 08:12:14 -0400
Date:   Fri, 01 Oct 2021 12:10:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633090229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1O7WlkPk5PYR+j7PcHMxLt095JRaPAe7bwcm02jctOI=;
        b=yq7rIH29EKCsVhKKIvK5NMio18iXmVvxzZzHWxakTHf3LS3+gLIX5jNseyaHWCoKtMCb+r
        JwAv1VyzGedC7CVwoFlLAUn/p6EQW3/CJVANyUAoSX2MMwTzF4Qs1XIClZY76crCB7vki4
        g29F7U49WU55iVySoUJzJiumA7rm8IAyvF/JeiI3C6Ch0BcGk5JqunZW+3tZx0iiSKw5+k
        7DaX8+TRE5sgPn7OT9ukUF2egUsx2u3AoaxQaVdUX5iWn5v/v4+TURfA0z8IOpcm1kSvvZ
        vTjDKaKP/L4hhOFlmH6KgS+tLtSYBey8SfhvNDuwyqNG9I517XEfOlVIklbxfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633090229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1O7WlkPk5PYR+j7PcHMxLt095JRaPAe7bwcm02jctOI=;
        b=+CT6t2LdfmOIqY68zzIsLncpWdFAYjwnoyxSYlW/e4obtsigAGp/NoON+0wUji2uTeAW66
        d2GPXBaPjkQsucBg==
From:   "tip-bot2 for Anand K Mistry" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86: Reset destroy callback on event init failure
Cc:     Anand K Mistry <amistry@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210929170405.1.I078b98ee7727f9ae9d6df8262bad7e325e40faf0@changeid>
References: <20210929170405.1.I078b98ee7727f9ae9d6df8262bad7e325e40faf0@changeid>
MIME-Version: 1.0
Message-ID: <163309022815.25758.6278577173770964571.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     02d029a41dc986e2d5a77ecca45803857b346829
Gitweb:        https://git.kernel.org/tip/02d029a41dc986e2d5a77ecca45803857b346829
Author:        Anand K Mistry <amistry@google.com>
AuthorDate:    Wed, 29 Sep 2021 17:04:21 +10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:57:54 +02:00

perf/x86: Reset destroy callback on event init failure

perf_init_event tries multiple init callbacks and does not reset the
event state between tries. When x86_pmu_event_init runs, it
unconditionally sets the destroy callback to hw_perf_event_destroy. On
the next init attempt after x86_pmu_event_init, in perf_try_init_event,
if the pmu's capabilities includes PERF_PMU_CAP_NO_EXCLUDE, the destroy
callback will be run. However, if the next init didn't set the destroy
callback, hw_perf_event_destroy will be run (since the callback wasn't
reset).

Looking at other pmu init functions, the common pattern is to only set
the destroy callback on a successful init. Resetting the callback on
failure tries to replicate that pattern.

This was discovered after commit f11dd0d80555 ("perf/x86/amd/ibs: Extend
PERF_PMU_CAP_NO_EXCLUDE to IBS Op") when the second (and only second)
run of the perf tool after a reboot results in 0 samples being
generated. The extra run of hw_perf_event_destroy results in
active_events having an extra decrement on each perf run. The second run
has active_events == 0 and every subsequent run has active_events < 0.
When active_events == 0, the NMI handler will early-out and not record
any samples.

Signed-off-by: Anand K Mistry <amistry@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210929170405.1.I078b98ee7727f9ae9d6df8262bad7e325e40faf0@changeid
---
 arch/x86/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 2a57dbe..6dfa8dd 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2465,6 +2465,7 @@ static int x86_pmu_event_init(struct perf_event *event)
 	if (err) {
 		if (event->destroy)
 			event->destroy(event);
+		event->destroy = NULL;
 	}
 
 	if (READ_ONCE(x86_pmu.attr_rdpmc) &&
