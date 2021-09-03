Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5DF40073E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  3 Sep 2021 23:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhICVHB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 3 Sep 2021 17:07:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52922 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbhICVHB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 3 Sep 2021 17:07:01 -0400
Date:   Fri, 03 Sep 2021 21:05:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630703159;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=EUnjBpEMZ7i4sY4cYTSFcAbg/ETtTZieay4ENTVaTas=;
        b=MDr+WwdB6Fff+XNg9UzOEIrByFd3xWXI5REb84rL2G6+6ZuOs0KQNjXWQW3EjZdHGpJD/1
        qnkOUSh/02ziSE3zKBCRpkZZAW44Q47ChauuJEc1BIbZOTmUXF6JOPMA6hJYeVmFPypE+9
        Q41gdOP4wCWr81d6LXiztDES4hhi/t0NpA/7RJlAjUnXWbjtZPVlNCVkn8fVxqcaUOM0vp
        C1tPh4ssiPrKsjhP6x6YyA+98TAFipEGzDhz0d8KFEJelNtiPKSFrU/+Gg8Nw7wvJ0fUxU
        ukKYYmloiRkX5ZG7VOCuDKrDr7NZa0plQAHxcY8knqIMKIWsjUtJHg9bUl4Gfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630703159;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=EUnjBpEMZ7i4sY4cYTSFcAbg/ETtTZieay4ENTVaTas=;
        b=f/oXY2K6AZVKvI3AP1sZcjcTj7BphyPocCqTZrX/2QWxIrhYznilKXpC6ttD7NoUZTu4CX
        5g0bwoBqIYEgQvAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Remove unused variable 'vpid' in
 futex_proxy_trylock_atomic()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <163070315821.25758.10852043423900886118.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     d66e3edee7af87fe212df611ab9846b987a5070f
Gitweb:        https://git.kernel.org/tip/d66e3edee7af87fe212df611ab9846b987a5070f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 03 Sep 2021 22:47:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 03 Sep 2021 23:00:22 +02:00

futex: Remove unused variable 'vpid' in futex_proxy_trylock_atomic()

The recent bug fix left the variable 'vpid' and an assignment to it around,
but the variable is otherwise unused.

clang dose not complain even with W=1, but gcc exposed this.

Fixes: 4f07ec0d76f2 ("futex: Prevent inconsistent state and exit race")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index a316dce..c15ad27 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2034,7 +2034,7 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
 {
 	struct futex_q *top_waiter = NULL;
 	u32 curval;
-	int ret, vpid;
+	int ret;
 
 	if (get_futex_value_locked(&curval, pifutex))
 		return -EFAULT;
@@ -2079,7 +2079,6 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
 	 * the user space lock can be acquired then PI state is attached to
 	 * the new owner (@top_waiter->task) when @set_waiters is true.
 	 */
-	vpid = task_pid_vnr(top_waiter->task);
 	ret = futex_lock_pi_atomic(pifutex, hb2, key2, ps, top_waiter->task,
 				   exiting, set_waiters);
 	if (ret == 1) {
