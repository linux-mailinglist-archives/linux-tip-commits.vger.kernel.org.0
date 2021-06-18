Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444593AC66F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 10:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhFRIsU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 04:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbhFRIsR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 04:48:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B0FC061760;
        Fri, 18 Jun 2021 01:46:08 -0700 (PDT)
Date:   Fri, 18 Jun 2021 08:46:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624005967;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ohcrc38O26Lfr2W3uV2igtbJnbPRi35ZDw36F/4nYKg=;
        b=SdVyRBumYjaOJX2rZEJpF/4w/20uxkec0cvG2Q9udTNgI458+vuqB/J3GDLZ8UyUltpvoG
        JIfFhmg95IxjjlQmGtBHED5ykU/JQuE2L6b1ic7CYoGrdofrpL3YuDzmqleKanQNeqMlfQ
        SNueQN6f87N0Di4kKHX2v24GByH3sRetlhqNp6LXRhGsGIKMtzhQGF/402aVv3OwMFUBUm
        y5LwQn+8t/3Ie7sk+ZX6bx+O801Yd7J7r2hYyLIiRlRHSeMcax8yh8xg0QsuK0vlSpJeIC
        VwhOiS4LHQlIsnRLJWVf1CTlGCA6fRngAA0pfrqi1Tj4CqythHH74Szg0BCfpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624005967;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ohcrc38O26Lfr2W3uV2igtbJnbPRi35ZDw36F/4nYKg=;
        b=PEEfJcgZ1XTey+HT73DuHMLSos+/GLEgcRWnHGLxRBSqcP1g/SAghFlZCpOmI3bo3XMVEQ
        VCNRK5wALNRhdWAQ==
From:   "tip-bot2 for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] thermal/cpufreq_cooling: Update offline CPUs
 per-cpu thermal_pressure
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210614191030.22241-1-lukasz.luba@arm.com>
References: <20210614191030.22241-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <162400596666.19906.7832650619393639498.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2ad8ccc17d1e4270cf65a3f2a07a7534aa23e3fb
Gitweb:        https://git.kernel.org/tip/2ad8ccc17d1e4270cf65a3f2a07a7534aa23e3fb
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Mon, 14 Jun 2021 20:10:30 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 17 Jun 2021 14:11:43 +02:00

thermal/cpufreq_cooling: Update offline CPUs per-cpu thermal_pressure

The thermal pressure signal gives information to the scheduler about
reduced CPU capacity due to thermal. It is based on a value stored in
a per-cpu 'thermal_pressure' variable. The online CPUs will get the
new value there, while the offline won't. Unfortunately, when the CPU
is back online, the value read from per-cpu variable might be wrong
(stale data).  This might affect the scheduler decisions, since it
sees the CPU capacity differently than what is actually available.

Fix it by making sure that all online+offline CPUs would get the
proper value in their per-cpu variable when thermal framework sets
capping.

Fixes: f12e4f66ab6a3 ("thermal/cpu-cooling: Update thermal pressure in case of a maximum frequency capping")
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lore.kernel.org/r/20210614191030.22241-1-lukasz.luba@arm.com
---
 drivers/thermal/cpufreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index eeb4e4b..43b1ae8 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -478,7 +478,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	ret = freq_qos_update_request(&cpufreq_cdev->qos_req, frequency);
 	if (ret >= 0) {
 		cpufreq_cdev->cpufreq_state = state;
-		cpus = cpufreq_cdev->policy->cpus;
+		cpus = cpufreq_cdev->policy->related_cpus;
 		max_capacity = arch_scale_cpu_capacity(cpumask_first(cpus));
 		capacity = frequency * max_capacity;
 		capacity /= cpufreq_cdev->policy->cpuinfo.max_freq;
