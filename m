Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A95137F880
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 15:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhEMNS6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 13 May 2021 09:18:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58520 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbhEMNSk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 13 May 2021 09:18:40 -0400
Date:   Thu, 13 May 2021 13:17:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620911848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HMwn8O3nBoPuE7nUlO7ip7NNJF+oVD6bUgbDrgpjT/k=;
        b=fffC+ZHsPvoZ9liHabQWAGOFafd4nYsA+4Wo58hGHVVuiuoxnWkCYTUXpeskHcsyzJATdS
        gsebEQx/pkWISj0JLZrEcOd6ocJgflYJJNbG4g6A2huHssMa3jvNCraeJ7OCS56rYy2hAy
        eAB9hZn/HwY/w5k1rwxIS/6kXrVthjeAcUqg9JDMbpRpGv84+DSTVRQhdKXn7ZjpcN4Esz
        SinjI6b7TK3px9/uyThILAc2t3BgMh6YwrE6rLCbojvolG55K5Sbxn+RvIcj9rLVR/r3A6
        t288tnq2JDgKNHCEVPSypxVlIqm1z5tzUTqB8DUXwR75Ac3LkG2IRHUgmTZSkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620911848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HMwn8O3nBoPuE7nUlO7ip7NNJF+oVD6bUgbDrgpjT/k=;
        b=nfXvMgKT1kDn922NkeqFo6E1GBO11sCCwV8fLYwM0YguZNvVH3C7l+u6QlrC4AdKGdFpjN
        s5dQhqNuGln0JNBg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/nohz] tick/nohz: Update nohz_full Kconfig help
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210512232924.150322-6-frederic@kernel.org>
References: <20210512232924.150322-6-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <162091184822.29796.1242283230683760221.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/nohz branch of tip:

Commit-ID:     176b8906c399a170886ea4bad5b24763c6713d61
Gitweb:        https://git.kernel.org/tip/176b8906c399a170886ea4bad5b24763c6713d61
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 13 May 2021 01:29:19 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 May 2021 14:21:21 +02:00

tick/nohz: Update nohz_full Kconfig help

CONFIG_NO_HZ_FULL behaves just like CONFIG_NO_HZ_IDLE by default.
Reassure distros about it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210512232924.150322-6-frederic@kernel.org
---
 kernel/time/Kconfig | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 83e158d..7df71ef 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -117,13 +117,14 @@ config NO_HZ_FULL
 	 the task mostly runs in userspace and has few kernel activity.
 
 	 You need to fill up the nohz_full boot parameter with the
-	 desired range of dynticks CPUs.
+	 desired range of dynticks CPUs to use it. This is implemented at
+	 the expense of some overhead in user <-> kernel transitions:
+	 syscalls, exceptions and interrupts.
 
-	 This is implemented at the expense of some overhead in user <-> kernel
-	 transitions: syscalls, exceptions and interrupts. Even when it's
-	 dynamically off.
+	 By default, without passing the nohz_full parameter, this behaves just
+	 like NO_HZ_IDLE.
 
-	 Say N.
+	 If you're a distro say Y.
 
 endchoice
 
