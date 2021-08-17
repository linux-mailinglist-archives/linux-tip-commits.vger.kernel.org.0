Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5883E3EF337
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhHQUOj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34620 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbhHQUOi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:38 -0400
Date:   Tue, 17 Aug 2021 20:14:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwvmQBYbxXL0i3yQwky+gRpqRuU3fjcDVAR8vmH1qag=;
        b=vk+0/qyX9jQ4CkdxZwtCiuMHxEQY9l2JnUgMJAFcEABmKBKNzwM24lyZvMclysO3pivWIv
        JGaduz4wNQh0+p90oYFflN3emGrle463XOK78iQytY3LmWvkclyvREKmb/1aLyODrVqeig
        wklkBAJo2uooIfiAhzbynXL2w/32qKQZS/H2eA/I223JAcc1tcXL0+/fN0rZaOwse99dC8
        Piru23/6D+6jWvs7jbXoKtQ2S+T6V4NZbkBBA5ggkSLuQJPa6zP1W7wfr9Ps2Y3ugKP9/F
        kkMRHonyA2awgV4CtyqGaWw3mxUAfWt+doV88bVkViqDSt0MUWVZ/a1fsI9cAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwvmQBYbxXL0i3yQwky+gRpqRuU3fjcDVAR8vmH1qag=;
        b=RWhrDoMNwYIvv5Yq7Vn1mo5/TDYP6XeBD1a4QkrmwZyaPP6rD40lBZFC7LKaUYyDvIUHnF
        m/IW2hx19fcsDVAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Correct the number of requeued waiters for PI
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211305.416427548@linutronix.de>
References: <20210815211305.416427548@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923124287.25758.5175526164956598130.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     59c7ecf1544e1841b5be8847e81bc9842f838e7e
Gitweb:        https://git.kernel.org/tip/59c7ecf1544e1841b5be8847e81bc9842f838e7e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:29:10 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:46 +02:00

futex: Correct the number of requeued waiters for PI

The accounting is wrong when either the PI sanity check or the
requeue PI operation fails. Adjust it in the failure path.

Will be simplified in the next step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211305.416427548@linutronix.de
---
 kernel/futex.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/futex.c b/kernel/futex.c
index 8ddc87c..5439742 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2116,6 +2116,8 @@ retry_private:
 
 		/* Ensure we requeue to the expected futex for requeue_pi. */
 		if (requeue_pi && !match_futex(this->requeue_pi_key, &key2)) {
+			/* Don't account for it */
+			task_count--;
 			ret = -EINVAL;
 			break;
 		}
@@ -2157,6 +2159,8 @@ retry_private:
 				 */
 				this->pi_state = NULL;
 				put_pi_state(pi_state);
+				/* Don't account for it */
+				task_count--;
 				/*
 				 * We stop queueing more waiters and let user
 				 * space deal with the mess.
