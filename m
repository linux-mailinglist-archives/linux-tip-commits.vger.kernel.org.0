Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78F836568A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhDTKrR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51694 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhDTKrP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:15 -0400
Date:   Tue, 20 Apr 2021 10:46:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6XAob3vAhduNyORLGlSq3Q+X7Cb3Sfzw3RuTIN5onW0=;
        b=kKrSyZQYy+aJ9j1GNTT1JoiNLVXJiAta54Gpykt9uyLX973ILQRREeRhD7GGVuD3CBGP17
        2W+NiVodUTVU9Jh6QabOqeH9OXrrpgQtSh7hamBBHkfcp6Yu6XFrFZo3xdH4R97gakiPTR
        aHHxnRqzPr1VJuWY7I5kisDKQ4F2qlo78Q8U2kQeppSn2zAyUZOOkdbFzsBryadjbbvy1L
        SMgSV0sccEbWnFJ+fp/r0L97j1ARQ/NeavQGvfe8Me8CL0hJROPVv6tGb0p0uRs9y2zWIx
        biNsy8MXBiBltfKhdc32Ra2WSELHSAxXwLrBJUr4S+Lkw1zDMuwg7Hanft+dWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6XAob3vAhduNyORLGlSq3Q+X7Cb3Sfzw3RuTIN5onW0=;
        b=UkjTZKq01TXtc6u/um5Y6uj7UmoXulBo/aqINf++JOOvZQkxWAlN1kkKRop9KmCsQpOLB3
        QQDCGdDc1/nWw/CA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Support filter_match callback
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-20-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-20-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560282.29796.9965092803424778731.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3e9a8b219e4cc897dba20e19185d0471f129f6f3
Gitweb:        https://git.kernel.org/tip/3e9a8b219e4cc897dba20e19185d0471f129f6f3
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:30:59 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:28 +02:00

perf/x86: Support filter_match callback

Implement filter_match callback for X86, which check whether an event is
schedulable on the current CPU.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1618237865-33448-20-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       | 10 ++++++++++
 arch/x86/events/perf_event.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 37ab109..4f6595e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2641,6 +2641,14 @@ static int x86_pmu_aux_output_match(struct perf_event *event)
 	return 0;
 }
 
+static int x86_pmu_filter_match(struct perf_event *event)
+{
+	if (x86_pmu.filter_match)
+		return x86_pmu.filter_match(event);
+
+	return 1;
+}
+
 static struct pmu pmu = {
 	.pmu_enable		= x86_pmu_enable,
 	.pmu_disable		= x86_pmu_disable,
@@ -2668,6 +2676,8 @@ static struct pmu pmu = {
 	.check_period		= x86_pmu_check_period,
 
 	.aux_output_match	= x86_pmu_aux_output_match,
+
+	.filter_match		= x86_pmu_filter_match,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e2be927..606fb6e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -879,6 +879,7 @@ struct x86_pmu {
 
 	int (*aux_output_match) (struct perf_event *event);
 
+	int (*filter_match)(struct perf_event *event);
 	/*
 	 * Hybrid support
 	 *
