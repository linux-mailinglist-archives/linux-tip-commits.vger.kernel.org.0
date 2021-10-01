Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854B441F06E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 17:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354901AbhJAPHp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 11:07:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58078 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354903AbhJAPHg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:36 -0400
Date:   Fri, 01 Oct 2021 15:05:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLrOKw/rD1A44FcDnzTS2BGBGHCDDzz2qjYnr6lOWcQ=;
        b=AbeTVOL9FnT88XYekJMPVuHf8nOg259DOWgor1DfZ82VCFczsWX2kIvxLeDvzbHHwiF2XS
        fst+k6sea49WGf35J0+kxEqR2CKshbpkEXEAmqs5zr5gLZSIxKBqRH7fLgXzAwwhJZETbH
        UrBzpHX/PUnUwpL2kN1flyhJRXqBhsb0cjn8txBM+MMxitTbYeQt6OiwmcIqt8wyqlSDEe
        TlZndoqntK1UU8DUTdmKlFHZXzO4fT3B6KWSrGfUkJlmluE8xvP1OMACBcAfhpabYgNA3p
        WFqcSEWTYHJ4//IpBje7dGBM8G0g5x/QSbeWlXVD9I+I/kTyoWFZm9bwXth/wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLrOKw/rD1A44FcDnzTS2BGBGHCDDzz2qjYnr6lOWcQ=;
        b=OcJuWdU3re3LH6kKrzZzvie8c1Uz+AfyxLOTnJlcCMhVTrmITxZZPuynGI1rxNw7tQhxf9
        /bdbhHkZV5rj12CQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Disable TTWU_QUEUE on RT
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210928122411.482262764@linutronix.de>
References: <20210928122411.482262764@linutronix.de>
MIME-Version: 1.0
Message-ID: <163310075076.25758.6051466757079955662.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e3865866752e1b9fd26383f548dea58334fe6eba
Gitweb:        https://git.kernel.org/tip/e3865866752e1b9fd26383f548dea58334fe6eba
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 28 Sep 2021 14:24:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:58:07 +02:00

sched: Disable TTWU_QUEUE on RT

The queued remote wakeup mechanism has turned out to be suboptimal for RT
enabled kernels. The maximum latencies go up by a factor of > 5x in certain
scenarious.

This is caused by either long wake lists or by a large number of TTWU IPIs
which are processed back to back.

Disable it for RT.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210928122411.482262764@linutronix.de
---
 kernel/sched/features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 7f8dace..1cf435b 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -46,11 +46,16 @@ SCHED_FEAT(DOUBLE_TICK, false)
  */
 SCHED_FEAT(NONTASK_CAPACITY, true)
 
+#ifdef CONFIG_PREEMPT_RT
+SCHED_FEAT(TTWU_QUEUE, false)
+#else
+
 /*
  * Queue remote wakeups on the target CPU and process them
  * using the scheduler IPI. Reduces rq->lock contention/bounces.
  */
 SCHED_FEAT(TTWU_QUEUE, true)
+#endif
 
 /*
  * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
