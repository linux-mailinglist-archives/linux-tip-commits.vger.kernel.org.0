Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91AB3E115C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Aug 2021 11:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbhHEJeu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 5 Aug 2021 05:34:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41640 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238958AbhHEJet (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 5 Aug 2021 05:34:49 -0400
Date:   Thu, 05 Aug 2021 09:34:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628156074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RjvlCLNLQMEOHBa4pu2I3ZAxvthgoW66trV7b8hD6Uk=;
        b=C/hCXucQV80Bmp4D96mP2A8ZOMXUl8t357O+acl9ORP3z2ZFH+XSAU7vb+cPRCvhBsuhub
        EK+yTCDiFzY+Fb+ACQYFUKCoaIzpja6P2MJcGDkfvtc+KG24hx+195DncAo2sbRrkl6wNv
        Xen2rRKvfoFpMKRH7/OvsbFjHQfHnZdpG+97F7B0MUAR5gdzMSprnuUHIwJBVz4ocg695V
        MTyWQbwzlrt3D+t2lea2WvLLun40VPxwdSzoV7GT46ByWkgFcptEcraCw517cgebY5yhal
        hjSsM/AEtTgo1Su7HW/pO+IgvIVeQzEXP/Czc7yl+TqsyjzRS6YWQMltf2f55g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628156074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RjvlCLNLQMEOHBa4pu2I3ZAxvthgoW66trV7b8hD6Uk=;
        b=G0HGVM3+AGl3gYdquN6e1mkG20kOGJ5w4lskYpVTHkaV5lBrEuJDBWkjkcAYvgF6yhghOq
        UmRFL7le44kfnCDg==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Avoid a second scan of target in
 select_idle_cpu
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210804115857.6253-3-mgorman@techsingularity.net>
References: <20210804115857.6253-3-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <162815607370.395.4560583728552595431.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     56498cfb045d7147cdcba33795d19429afcd1d00
Gitweb:        https://git.kernel.org/tip/56498cfb045d7147cdcba33795d19429afcd1d00
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Wed, 04 Aug 2021 12:58:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Aug 2021 15:16:44 +02:00

sched/fair: Avoid a second scan of target in select_idle_cpu

When select_idle_cpu starts scanning for an idle CPU, it starts with
a target CPU that has already been checked by select_idle_sibling.
This patch starts with the next CPU instead.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210804115857.6253-3-mgorman@techsingularity.net
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7ee394b..47a0fbf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6220,7 +6220,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool 
 		time = cpu_clock(this);
 	}
 
-	for_each_cpu_wrap(cpu, cpus, target) {
+	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
 			if ((unsigned int)i < nr_cpumask_bits)
