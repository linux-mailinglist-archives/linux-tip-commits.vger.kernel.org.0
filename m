Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1662F2D8FFD
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392302AbgLMTVU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:21:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46814 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389441AbgLMTC2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:28 -0500
Date:   Sun, 13 Dec 2020 19:01:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=H1FaVROqRiSK0Z14JjfcbBDuKFu1o3FCgVjd5xuJ+Lc=;
        b=mzqgLT+Ttq/XDxvQI58Ave+OlwEAgVL2GFdXk3vdq5PRkDusCu2Cnyz8RkMLA+SIqLtbY6
        fDJBkebkvbCEGMB2aRBliFgSRSBUIAOm8JiWZFBKFixYyiMCX3V/y0bWVn0iSLtDlBMFRv
        YgBvih60XT+okkHB0raOQs0/1UpTtaJ1nL/48mIz777pqy/4uiTBigED7Hn/xB/RM2yP4p
        g/3Is/zelAGkfUPdfpcgkbni1TF8XItcEbhgYBgTEIHsns/jzZbFuFy8FTLtlLG6F4YeVc
        gPEb/vtwap1MQ2mIZQacweEjPhUq+D8Vyfv3Yl8txBjN6N6g3fMfFVScvgEgRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=H1FaVROqRiSK0Z14JjfcbBDuKFu1o3FCgVjd5xuJ+Lc=;
        b=BG7ZHtrL+kPen/MIB14xayGsa82sKlLkucltFQj1cclW8SKbdmKSfkw6RdcQI5xSVB6JVF
        C85TW/VvWoFPD4Cw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Convert rcu_tasks_wait_gp() for-loop to while-loop
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607305.3364.16307522616795772988.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     77dc174103fdb121c47621e9856d73704b7eddd2
Gitweb:        https://git.kernel.org/tip/77dc174103fdb121c47621e9856d73704b7eddd2
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 15 Sep 2020 15:41:50 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 02 Nov 2020 17:12:42 -08:00

rcu-tasks: Convert rcu_tasks_wait_gp() for-loop to while-loop

The infinite for-loop in rcu_tasks_wait_gp() has its only exit at the
top of the loop, so this commit does the straightforward conversion to
a while-loop, thus saving a few lines.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d5d9f2d..a93271f 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -338,14 +338,11 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	if (fract > HZ)
 		fract = HZ;
 
-	for (;;) {
+	while (!list_empty(&holdouts)) {
 		bool firstreport;
 		bool needreport;
 		int rtst;
 
-		if (list_empty(&holdouts))
-			break;
-
 		/* Slowly back off waiting for holdouts */
 		set_tasks_gp_state(rtp, RTGS_WAIT_SCAN_HOLDOUTS);
 		schedule_timeout_idle(HZ/fract);
