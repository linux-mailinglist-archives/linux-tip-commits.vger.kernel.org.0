Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9613F479C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbhHWJdd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:33:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39208 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbhHWJdb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:33:31 -0400
Date:   Mon, 23 Aug 2021 09:32:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629711168;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dUq9xCygggOTFb6UxVPlBq454KbJy1bwYVtsXOM120k=;
        b=Je/ftLReeGvyIZdfBiFA84kPhuoBnvJAOqDbFtG2k5yeOyLUHLndPQUR5LEBBkEKq/RbFs
        jqapOoo0IdFP+FkbOmZ24Zg8x0ThT0di6ikB8xplSkT7H0rkFY6mIQVUacaG3F4jfHYS7c
        9f45wp0uiICvneZMfAl00AhtZ8hPJzxKOhci0JibQ69A6ee5ILLjN2kXMGVVNF5nIkIpT3
        Gtj3g4pHz5EjCzDVyUuAp0YVFqSKzit8AY7O+zwdIiiZbHz7SxyhIf2YbngHVDynSlvuha
        VoVMaXfAbWT5xkp0Euzw05x6V8YP+URhBpkFheRzAxf/dVMy5S4Hp9m0egFcDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629711168;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dUq9xCygggOTFb6UxVPlBq454KbJy1bwYVtsXOM120k=;
        b=XQAHdPgY6gULhaAjww3ODtBcckhGaFI+vWKJyfZVKyzeWmQ2QBKg0GtRjsFULYhbGWGAMJ
        53yLEhyQc8SFgPAg==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/power: Assign pmu.module
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210817221048.88063-4-kim.phillips@amd.com>
References: <20210817221048.88063-4-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <162971116730.25758.1147991214565796429.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b159f2ed7a712ae24b22414cda22ed93db7033bb
Gitweb:        https://git.kernel.org/tip/b159f2ed7a712ae24b22414cda22ed93db7033bb
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 17 Aug 2021 17:10:43 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:33:12 +02:00

perf/x86/amd/power: Assign pmu.module

Assign pmu.module so the driver can't be unloaded whilst in use.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210817221048.88063-4-kim.phillips@amd.com
---
 arch/x86/events/amd/power.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index 16a2369..37d5b38 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -213,6 +213,7 @@ static struct pmu pmu_class = {
 	.stop		= pmu_event_stop,
 	.read		= pmu_event_read,
 	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+	.module		= THIS_MODULE,
 };
 
 static int power_cpu_exit(unsigned int cpu)
