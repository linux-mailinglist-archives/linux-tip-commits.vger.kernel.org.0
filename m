Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E9D278725
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Sep 2020 14:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgIYMYI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 25 Sep 2020 08:24:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55972 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgIYMX6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 25 Sep 2020 08:23:58 -0400
Date:   Fri, 25 Sep 2020 12:23:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601036636;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gB96ZgLSYVe3GKnZFMHUgDCpjXM3cM0D/5fPtt/dZXQ=;
        b=2h3dWSAU2H97mU49rl9e1JgjvRnhWcDfux9HZa/5GRLc1s0J/2CLpSO34elD2T5datxvyh
        Fm8/UTPlg530nCglLMwCAOEo+aJjaYUX5m6SiODDsyHwdlNHCC6CugLvPi6ZVRauW0b3LF
        M8ukK5mfLmOxQStdvkZARx2tLGRVknbMWoihagf5Rvq56yiutpKvfKNjDbZT/DYJJVCivS
        k8uh4l35sU5X7Psm6us+7SwFOcyjcX14TUJdOvtk4IK2BChGNBqmqDc3x4Migsh+Vko51q
        EGcTt+A9veYwRsKuAtpgg3WdzDZbE3TmEMCRyUT1JpySC+Xz3MkWeFDHiMR1NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601036636;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gB96ZgLSYVe3GKnZFMHUgDCpjXM3cM0D/5fPtt/dZXQ=;
        b=rFkXy+4ZOyIP/5AS9436UaXOgK1SkA8w9SHwJAIzWuqIH3mGGioRcusmM4lYKas/46KHdA
        hFBB97fMXBGvjtCw==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/uncore: Inform the user how many counters
 each uncore PMU has
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200921144330.6331-5-kim.phillips@amd.com>
References: <20200921144330.6331-5-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <160103663538.7002.12744259154529037292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9ed9647dc0671486f9e998b7258f75167a9c4697
Gitweb:        https://git.kernel.org/tip/9ed9647dc0671486f9e998b7258f75167a9c4697
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Mon, 21 Sep 2020 09:43:30 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Sep 2020 15:55:50 +02:00

perf/amd/uncore: Inform the user how many counters each uncore PMU has

Previously, the uncore driver would say "NB counters detected" on F17h
machines, which don't have NorthBridge (NB) counters.  They have Data
Fabric (DF) counters.  Just use the pmu.name to inform users which pmu
to use and its associated counter count.

F17h dmesg BEFORE:

amd_uncore: AMD NB counters detected
amd_uncore: AMD LLC counters detected

F17h dmesg AFTER:

amd_uncore: 4 amd_df counters detected
amd_uncore: 6 amd_l3 counters detected

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200921144330.6331-5-kim.phillips@amd.com
---
 arch/x86/events/amd/uncore.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index f026715..7f014d4 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -595,9 +595,10 @@ static int __init amd_uncore_init(void)
 		if (ret)
 			goto fail_nb;
 
-		pr_info("%s NB counters detected\n",
-			boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?
-				"HYGON" : "AMD");
+		pr_info("%d %s %s counters detected\n", num_counters_nb,
+			boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON" : "",
+			amd_nb_pmu.name);
+
 		ret = 0;
 	}
 
@@ -626,9 +627,9 @@ static int __init amd_uncore_init(void)
 		if (ret)
 			goto fail_llc;
 
-		pr_info("%s LLC counters detected\n",
-			boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?
-				"HYGON" : "AMD");
+		pr_info("%d %s %s counters detected\n", num_counters_llc,
+			boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON" : "",
+			amd_llc_pmu.name);
 		ret = 0;
 	}
 
