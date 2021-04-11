Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F6035B4EE
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbhDKNoZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33440 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbhDKNoG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:06 -0400
Date:   Sun, 11 Apr 2021 13:43:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148614;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=c0eC3OHbzo0MmENIs4LzmXjEZyj71sIXjrcbf7wHC80=;
        b=HtrvYYxqr8tadgSFkWPAKR3YKtffnq00ClpCuaxInXmyKPa0ZDHWZ/J9izF0reedCGdFzg
        5V/O/5EaUSVHLqY+kmKwpVUKPWIcNJPViShwmDQQUSqCdVxnyLMmgScKzDSjAxEBRzujqB
        62DvnAUQFVcANqeWdLtFJ0jH9hkX6R/qA/AaVZ8zSdfG0vA/isrr+IT8NLxPa4Eawz/IQ2
        N7YOvebKHt2joFBvL9GkO34DNziDFONaIxYcUG43NgusD6a3PFYL9qMsxR7brnMp6SDCkG
        IExljVMjw0mpmnIsuWfZCL/p4cGWnkJdg+nN+pMmVtnuTeyEQFT4xPhcNMve7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148614;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=c0eC3OHbzo0MmENIs4LzmXjEZyj71sIXjrcbf7wHC80=;
        b=4nqWc2SZSe8x6Reufwb8ORoxDnbQFjWESUreoWpEL3zPittoKm6V303Jz94mkaqlCOGePV
        Ajcjorl7em2a6LBw==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Rectify kernel-doc for struct rcu_tasks
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861412.29796.9006237685310304393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     85b86994284820ec070182ec269e6e79735f523a
Gitweb:        https://git.kernel.org/tip/85b86994284820ec070182ec269e6e79735f523a
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Mon, 25 Jan 2021 08:41:05 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:22:02 -08:00

rcu-tasks: Rectify kernel-doc for struct rcu_tasks

The command 'find ./kernel/rcu/ | xargs ./scripts/kernel-doc -none'
reported an issue with the kernel-doc of struct rcu_tasks.

This commit rectifies the kernel-doc, such that no issues remain for
./kernel/rcu/.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index af7c194..17c8ebe 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -20,7 +20,7 @@ typedef void (*holdouts_func_t)(struct list_head *hop, bool ndrpt, bool *frptp);
 typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
 
 /**
- * Definition for a Tasks-RCU-like mechanism.
+ * struct rcu_tasks - Definition for a Tasks-RCU-like mechanism.
  * @cbs_head: Head of callback list.
  * @cbs_tail: Tail pointer for callback list.
  * @cbs_wq: Wait queue allowning new callback to get kthread's attention.
@@ -38,7 +38,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @pregp_func: This flavor's pre-grace-period function (optional).
  * @pertask_func: This flavor's per-task scan function (optional).
  * @postscan_func: This flavor's post-task scan function (optional).
- * @holdout_func: This flavor's holdout-list scan function (optional).
+ * @holdouts_func: This flavor's holdout-list scan function (optional).
  * @postgp_func: This flavor's post-grace-period function (optional).
  * @call_func: This flavor's call_rcu()-equivalent function.
  * @name: This flavor's textual name.
