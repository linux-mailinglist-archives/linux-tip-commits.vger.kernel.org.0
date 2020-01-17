Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC1D140789
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Jan 2020 11:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgAQKIs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Jan 2020 05:08:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55329 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgAQKIr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Jan 2020 05:08:47 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYR-0005P5-TA; Fri, 17 Jan 2020 11:08:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7EE311C19CC;
        Fri, 17 Jan 2020 11:08:39 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:08:39 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Fix missing marker for
 snr_uncore_imc_freerunning_events
Cc:     Like Xu <like.xu@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        stable@vger.kernel.org, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200116200210.18937-1-kan.liang@linux.intel.com>
References: <20200116200210.18937-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157925571931.396.10786662135233748797.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     ff7be8a42c8844c7923288b218c9151934aa9b26
Gitweb:        https://git.kernel.org/tip/ff7be8a42c8844c7923288b218c9151934aa9b26
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 16 Jan 2020 12:02:09 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:24 +01:00

perf/x86/intel/uncore: Fix missing marker for snr_uncore_imc_freerunning_events

An Oops during the boot is found on some SNR machines.  It turns out
this is because the snr_uncore_imc_freerunning_events[] array was
missing an end-marker.

Fixes: ee49532b38dd ("perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge")
Reported-by: Like Xu <like.xu@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Like Xu <like.xu@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20200116200210.18937-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index b10a5ec..0116448 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4536,6 +4536,7 @@ static struct uncore_event_desc snr_uncore_imc_freerunning_events[] = {
 	INTEL_UNCORE_EVENT_DESC(write,		"event=0xff,umask=0x21"),
 	INTEL_UNCORE_EVENT_DESC(write.scale,	"3.814697266e-6"),
 	INTEL_UNCORE_EVENT_DESC(write.unit,	"MiB"),
+	{ /* end: all zeroes */ },
 };
 
 static struct intel_uncore_ops snr_uncore_imc_freerunning_ops = {
