Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1405161B71
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Feb 2020 20:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgBQTSt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 17 Feb 2020 14:18:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34627 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbgBQTSt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 17 Feb 2020 14:18:49 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j3luo-0006BQ-1W; Mon, 17 Feb 2020 20:18:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7026A1C20B8;
        Mon, 17 Feb 2020 20:18:45 +0100 (CET)
Date:   Mon, 17 Feb 2020 19:18:45 -0000
From:   "tip-bot2 for Amol Grover" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Pass lockdep expression to RCU lists
Cc:     Amol Grover <frextrite@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200216074330.GA14025@workstation-portable>
References: <20200216074330.GA14025@workstation-portable>
MIME-Version: 1.0
Message-ID: <158196712510.13786.4601056224517728789.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5fb1c2a5bbf79ccca8d17cf97f66085be5808027
Gitweb:        https://git.kernel.org/tip/5fb1c2a5bbf79ccca8d17cf97f66085be5808027
Author:        Amol Grover <frextrite@gmail.com>
AuthorDate:    Sun, 16 Feb 2020 13:13:30 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Feb 2020 20:12:19 +01:00

posix-timers: Pass lockdep expression to RCU lists

head is traversed using hlist_for_each_entry_rcu outside an RCU read-side
critical section but under the protection of hash_lock.

Hence, add corresponding lockdep expression to silence false-positive
lockdep warnings, and harden RCU lists.

[ tglx: Removed the macro and put the condition right where it's used ]

Signed-off-by: Amol Grover <frextrite@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200216074330.GA14025@workstation-portable


---
 kernel/time/posix-timers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index ff0eb30..07709ac 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -121,7 +121,8 @@ static struct k_itimer *__posix_timers_find(struct hlist_head *head,
 {
 	struct k_itimer *timer;
 
-	hlist_for_each_entry_rcu(timer, head, t_hash) {
+	hlist_for_each_entry_rcu(timer, head, t_hash,
+				 lockdep_is_held(&hash_lock)) {
 		if ((timer->it_signal == sig) && (timer->it_id == id))
 			return timer;
 	}
