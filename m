Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60DA2244CA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Jul 2020 22:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgGQUAY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Jul 2020 16:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbgGQUAX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Jul 2020 16:00:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3390BC0619D5;
        Fri, 17 Jul 2020 13:00:23 -0700 (PDT)
Date:   Fri, 17 Jul 2020 20:00:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595016021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cjtzIlht2e8cifhJtagb58N1MpRwjVqYl6gzVBnQQxw=;
        b=OiofMFDeW2teAk3bAHXbY88yBnfYzwj3W25CN0zBoF1819i/OngFXD15pkebj4q9jk7u4W
        GCbGJ0os4bJ6G08lusryMKBRykc3rsQDqZisQZ5dvwGI9jBWsojRhQotJgAso2n/hfHn1C
        cT19qlurrtKwIpCSXpkNnxWHjktpmLhty7z+y5fNU6Y/gv9rpzjhVpcKaMoOTCGk78DAbo
        ZaZ7GEIk5nFwbTt2sHmMhk/vy3u9/ZeQKVaK53pGtlRkVCBdfvq2EBw0Tx7JdP1T62vXWV
        AktOY8XsN1a4vJBEImSkXMvAIQfHQ3ZQcuAPWpWBn3Ig5Obx542SL7dFibuOYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595016021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cjtzIlht2e8cifhJtagb58N1MpRwjVqYl6gzVBnQQxw=;
        b=twwaAXMYYN1UOAvje7oeRMmA+BIeRh1sk+wlTl3tmJmJ89sMYsJ5l30HHwQhbu4hSuJHju
        vqtvnMkPpk7yZjDA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Preserve higher bits of expiration on
 index calculation
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200717140551.29076-3-frederic@kernel.org>
References: <20200717140551.29076-3-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <159501602116.4006.6815042885951437361.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3d2e83a2a6a0657c1cf145fa6ba23620715d6c36
Gitweb:        https://git.kernel.org/tip/3d2e83a2a6a0657c1cf145fa6ba23620715d6c36
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 17 Jul 2020 16:05:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 21:55:21 +02:00

timers: Preserve higher bits of expiration on index calculation

The higher bits of the timer expiration are cropped while calling
calc_index() due to the implicit cast from unsigned long to unsigned int.

This loss shouldn't have consequences on the current code since all the
computation to calculate the index is done on the lower 32 bits.

However to prepare for returning the actual bucket expiration from
calc_index() in order to properly fix base->next_expiry updates, the higher
bits need to be preserved.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200717140551.29076-3-frederic@kernel.org

---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index df1ff80..bcdc304 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -487,7 +487,7 @@ static inline void timer_set_idx(struct timer_list *timer, unsigned int idx)
  * Helper function to calculate the array index for a given expiry
  * time.
  */
-static inline unsigned calc_index(unsigned expires, unsigned lvl)
+static inline unsigned calc_index(unsigned long expires, unsigned lvl)
 {
 	expires = (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
 	return LVL_OFFS(lvl) + (expires & LVL_MASK);
