Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FD329D558
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Oct 2020 23:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgJ1V70 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Oct 2020 17:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbgJ1V70 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Oct 2020 17:59:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5607C0613CF;
        Wed, 28 Oct 2020 14:59:26 -0700 (PDT)
Date:   Wed, 28 Oct 2020 14:53:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603896832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgXvIqLYv72DaF7oICyGH2Ps5zQbCTbcLjc0yNij5h0=;
        b=sTCIRqNfEqeNvBUmCxWSmTRi2OeEVhkrUAukrBKGiNAvG9K7638Lhrrj3Zkei/ROeJ/SXZ
        1GUnk21iNitiCxFI1x+cax1lT+l6iu5iGrACEYb/L3iUSDZdUTkSrrqeZpr47j04CRExg6
        Uh7N8B2dytz+e34H5CVjYVsRB9FtxDYLitz7PusjLaTn0/B6V31G9yJlm8s9cZnk0RkEwN
        GspBjxiZYnMWnpqtC6cCY6t/imOvNa3HGE6c57CQIgJ5mN41gA6R6ryLiQtAg22wYd8Kpy
        aSZYVGB/n9H47ZzhtTBhT6XNEKE3LOTrByPnwxVcCq22vciNHLgBHzMoQNJ9gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603896832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgXvIqLYv72DaF7oICyGH2Ps5zQbCTbcLjc0yNij5h0=;
        b=z0Gji0gjVYvBioKIDYLtif2gVuWWHIEEUe48C7TA0PpkpgRgRuQXsAF0cvdLj/V4bDpnqZ
        KCDCB208VprkbuAw==
From:   "tip-bot2 for Mateusz Nosek" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Fix incorrect should_fail_futex() handling
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200927000858.24219-1-mateusznosek0@gmail.com>
References: <20200927000858.24219-1-mateusznosek0@gmail.com>
MIME-Version: 1.0
Message-ID: <160389683158.397.17433889538041702702.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     921c7ebd1337d1a46783d7e15a850e12aed2eaa0
Gitweb:        https://git.kernel.org/tip/921c7ebd1337d1a46783d7e15a850e12aed2eaa0
Author:        Mateusz Nosek <mateusznosek0@gmail.com>
AuthorDate:    Sun, 27 Sep 2020 02:08:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 15:48:51 +01:00

futex: Fix incorrect should_fail_futex() handling

If should_futex_fail() returns true in futex_wake_pi(), then the 'ret'
variable is set to -EFAULT and then immediately overwritten. So the failure
injection is non-functional.

Fix it by actually leaving the function and returning -EFAULT.

The Fixes tag is kinda blury because the initial commit which introduced
failure injection was already sloppy, but the below mentioned commit broke
it completely.

[ tglx: Massaged changelog ]

Fixes: 6b4f4bc9cb22 ("locking/futex: Allow low-level atomic operations to return -EAGAIN")
Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200927000858.24219-1-mateusznosek0@gmail.com

---
 kernel/futex.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index a587669..39681bf 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1502,8 +1502,10 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_
 	 */
 	newval = FUTEX_WAITERS | task_pid_vnr(new_owner);
 
-	if (unlikely(should_fail_futex(true)))
+	if (unlikely(should_fail_futex(true))) {
 		ret = -EFAULT;
+		goto out_unlock;
+	}
 
 	ret = cmpxchg_futex_value_locked(&curval, uaddr, uval, newval);
 	if (!ret && (curval != uval)) {
