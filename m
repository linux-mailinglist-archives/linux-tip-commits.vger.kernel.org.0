Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCD03928AA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 May 2021 09:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbhE0HkA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 27 May 2021 03:40:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32824 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbhE0Hj5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 27 May 2021 03:39:57 -0400
Date:   Thu, 27 May 2021 07:38:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622101103;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aFPG8tfLl1K+ayt94VTNQmG3JxAwHc5JV+Nj4l7AQo8=;
        b=oOyFgNMZwry8GuEyY4j5e5Wh9vLI9Xc44SpUd7NjxooIHt4/u/sgogcCyRfHBeBctdoFdw
        GLziteXEeMPE7JImr56fM4nvzZY7t1TTzkFF00CtmkYxWxn9/sTAfJuwNSKcHjiT6UargP
        4U3Y8p/S2Eh5hNc1ilA+E51yuEtQjcuOJRw4IAje7OmD4jDgqriG20/wKHKAXvfZgHCOmA
        ligxrpfsqJ2RJwC0DA3JctM7pqSF6B09EYliPoOiiGIAx3rPvPk/AQKXEA/c+PqqISH/Zw
        VrzW4t56rzzzbN9s2rTYIT4sreaE2q9DfI4uzh4b9fwC4UfoRbUo5y68mL0aYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622101103;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aFPG8tfLl1K+ayt94VTNQmG3JxAwHc5JV+Nj4l7AQo8=;
        b=VTHtnXok/xnPIst1cF+dd1fDH9QQNCVG6QKEliFeoDniBZdlN9lAZ83fum/muGkvitm22f
        XkBt7h1DbH07fIDg==
From:   "tip-bot2 for Haocheng Xie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Make local function
 perf_pmu_snapshot_aux() static
Cc:     Haocheng Xie <xiehaocheng.cn@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210527031947.1801-2-xiehaocheng.cn@gmail.com>
References: <20210527031947.1801-2-xiehaocheng.cn@gmail.com>
MIME-Version: 1.0
Message-ID: <162210110309.29796.12559510690660075400.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     32961aecf9da85c9e4c98d91ab8337424e0c8372
Gitweb:        https://git.kernel.org/tip/32961aecf9da85c9e4c98d91ab8337424e0c8372
Author:        Haocheng Xie <xiehaocheng.cn@gmail.com>
AuthorDate:    Thu, 27 May 2021 11:19:45 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 May 2021 09:35:21 +02:00

perf/core: Make local function perf_pmu_snapshot_aux() static

Fixes the following W=1 kernel build warning:

  kernel/events/core.c:6670:6: warning: no previous prototype for 'perf_pmu_snapshot_aux' [-Wmissing-prototypes]

Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210527031947.1801-2-xiehaocheng.cn@gmail.com
---
 kernel/events/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2e947a4..4c6b320 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6674,10 +6674,10 @@ out:
 	return data->aux_size;
 }
 
-long perf_pmu_snapshot_aux(struct perf_buffer *rb,
-			   struct perf_event *event,
-			   struct perf_output_handle *handle,
-			   unsigned long size)
+static long perf_pmu_snapshot_aux(struct perf_buffer *rb,
+                                 struct perf_event *event,
+                                 struct perf_output_handle *handle,
+                                 unsigned long size)
 {
 	unsigned long flags;
 	long ret;
