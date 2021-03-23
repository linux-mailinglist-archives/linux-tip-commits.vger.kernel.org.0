Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B93346267
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Mar 2021 16:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhCWPJY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Mar 2021 11:09:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33848 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbhCWPJA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Mar 2021 11:09:00 -0400
Date:   Tue, 23 Mar 2021 15:08:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616512138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SwPdYmVzl6wak2B8Ftvkic+OejtDVfYyFMGoDfjWwiQ=;
        b=TdyVkPW/E+g5115yOLubVOJ/6nSTe6rgA8tJ8AYcylzmgHxdGsAdeTvFfDGGxQHoRN9sq3
        YAbR+R8fPKwXpFWkybKFEBrNcAal01O3M7W2Gcn/fT7Kj8tRH5ti5HMnKyWWKOf1I1D3Ph
        H0qDhje+JZNHqR8efga/Ee5c7JQwc8v5EZEt9nYJ5p7TmVeifrFDzP+FSALFsfWT5LKgGN
        pUz97qO12geYbba589VTMT3yKu06mkQlMAuBvZfDpmVNBKjNgptV/eNDk/9H0Mz7wBK3jV
        msAo6/cMW2PxvDlXK7Tx9+Sp2eOGw235ee+YonOw/nIBoS/yLq0cfgddLjlclg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616512138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SwPdYmVzl6wak2B8Ftvkic+OejtDVfYyFMGoDfjWwiQ=;
        b=KvI/5oR+YixcmN+E9z4apsbg4PwjVxv8zOFAh3EPQhjYr6J+d+tVGSeJdztdRJbfNeSmtL
        o+B0KOkqGgJcUgBw==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] stop_machine: Add caller debug info to queue_stop_cpus_work
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201210163830.21514-2-valentin.schneider@arm.com>
References: <20201210163830.21514-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <161651213787.398.6254970835942552162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2a2f80ff63bc36a874ed569bcaef932a8fe43514
Gitweb:        https://git.kernel.org/tip/2a2f80ff63bc36a874ed569bcaef932a8fe43514
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Thu, 10 Dec 2020 16:38:29 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Mar 2021 16:01:58 +01:00

stop_machine: Add caller debug info to queue_stop_cpus_work

Most callsites were covered by commit

  a8b62fd08505 ("stop_machine: Add function and caller debug info")

but this skipped queue_stop_cpus_work(). Add caller debug info to it.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201210163830.21514-2-valentin.schneider@arm.com
---
 kernel/stop_machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 971d8ac..cbc3027 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -409,6 +409,7 @@ static bool queue_stop_cpus_work(const struct cpumask *cpumask,
 		work->fn = fn;
 		work->arg = arg;
 		work->done = done;
+		work->caller = _RET_IP_;
 		if (cpu_stop_queue_work(cpu, work))
 			queued = true;
 	}
