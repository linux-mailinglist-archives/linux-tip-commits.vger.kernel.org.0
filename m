Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F503A265A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jun 2021 10:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFJIPS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Jun 2021 04:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhFJIPS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Jun 2021 04:15:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D15C061574;
        Thu, 10 Jun 2021 01:13:22 -0700 (PDT)
Date:   Thu, 10 Jun 2021 08:13:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623312799;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPRLsWDpAS3p/LIfEHZkL1Ek7QN8Qor7KWqFnEhcH1g=;
        b=vB+SEkRaqihfFcXUnKVDhRkElBcGVBBhM6kxkUxjoFA4NXjiI/oosvRBdsw/Hldn8/ybEQ
        7pb9jtE2MxtKYxKadaWSpyzq41ShbfyAzhOGxwwlpBvfX6/ubt08NS3S7hADX0qyt110rV
        O8vfTyQWapK0KQjzrHlJ4WdMnQkepOY72q3RpI5nt1vqoUWbH0zbvOeoJwfruHX//lwONk
        xU7zppjEK4Lz+HYdeCytc/VLGA4+DvMqUmbYpocXXQZ0xvEcDHORdhXBdvdFUhGWuc/6Fi
        U+HYyIJTfNon82oKwx+Tg5gz3+8bW7IgyErXNuSYV/LXz/KQBWv/cFPvQIInKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623312799;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPRLsWDpAS3p/LIfEHZkL1Ek7QN8Qor7KWqFnEhcH1g=;
        b=vcIBf/cP9p1FA9LFN8Vjgim8WTROoHTTMmOaHCFnX1bpDq+eXFQ1CVD1oYVgmAWuZns1fP
        KF8rS3WU/soM7UCw==
From:   "tip-bot2 for CodyYao-oc" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] x86/nmi_watchdog: Fix old-style NMI watchdog
 regression on old Intel CPUs
Cc:     "CodyYao-oc" <CodyYao-oc@zhaoxin.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210607025335.9643-1-CodyYao-oc@zhaoxin.com>
References: <20210607025335.9643-1-CodyYao-oc@zhaoxin.com>
MIME-Version: 1.0
Message-ID: <162331279824.29796.12682254131606162477.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     a8383dfb2138742a1bb77b481ada047aededa2ba
Gitweb:        https://git.kernel.org/tip/a8383dfb2138742a1bb77b481ada047aededa2ba
Author:        CodyYao-oc <CodyYao-oc@zhaoxin.com>
AuthorDate:    Mon, 07 Jun 2021 10:53:35 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Jun 2021 10:04:40 +02:00

x86/nmi_watchdog: Fix old-style NMI watchdog regression on old Intel CPUs

The following commit:

   3a4ac121c2ca ("x86/perf: Add hardware performance events support for Zhaoxin CPU.")

Got the old-style NMI watchdog logic wrong and broke it for basically every
Intel CPU where it was active. Which is only truly old CPUs, so few people noticed.

On CPUs with perf events support we turn off the old-style NMI watchdog, so it
was pretty pointless to add the logic for X86_VENDOR_ZHAOXIN to begin with ... :-/

Anyway, the fix is to restore the old logic and add a 'break'.

[ mingo: Wrote a new changelog. ]

Fixes: 3a4ac121c2ca ("x86/perf: Add hardware performance events support for Zhaoxin CPU.")
Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210607025335.9643-1-CodyYao-oc@zhaoxin.com
---
 arch/x86/kernel/cpu/perfctr-watchdog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/perfctr-watchdog.c b/arch/x86/kernel/cpu/perfctr-watchdog.c
index 3ef5868..7aecb2f 100644
--- a/arch/x86/kernel/cpu/perfctr-watchdog.c
+++ b/arch/x86/kernel/cpu/perfctr-watchdog.c
@@ -63,7 +63,7 @@ static inline unsigned int nmi_perfctr_msr_to_bit(unsigned int msr)
 		case 15:
 			return msr - MSR_P4_BPU_PERFCTR0;
 		}
-		fallthrough;
+		break;
 	case X86_VENDOR_ZHAOXIN:
 	case X86_VENDOR_CENTAUR:
 		return msr - MSR_ARCH_PERFMON_PERFCTR0;
@@ -96,7 +96,7 @@ static inline unsigned int nmi_evntsel_msr_to_bit(unsigned int msr)
 		case 15:
 			return msr - MSR_P4_BSU_ESCR0;
 		}
-		fallthrough;
+		break;
 	case X86_VENDOR_ZHAOXIN:
 	case X86_VENDOR_CENTAUR:
 		return msr - MSR_ARCH_PERFMON_EVENTSEL0;
