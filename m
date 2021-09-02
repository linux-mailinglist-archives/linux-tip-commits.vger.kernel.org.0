Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25083FF4AD
	for <lists+linux-tip-commits@lfdr.de>; Thu,  2 Sep 2021 22:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345517AbhIBUPc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 2 Sep 2021 16:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345418AbhIBUPc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 2 Sep 2021 16:15:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D89C061575;
        Thu,  2 Sep 2021 13:14:33 -0700 (PDT)
Date:   Thu, 02 Sep 2021 20:14:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630613671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9I8OlriWSRjNHUXRiqNwrgJsUjSPy3bhZS7GrgiHUgE=;
        b=UtpGUechQGiFRtEq3SAQSqir6YMnHMYfzpXAD6C4jvlth/qmXT/5TPYGv2V7q1MTC5YRR3
        j75rgCswR5oquFcKKSXg/aEe5RYNxfbxym/k4Uq+bFpVMbglJLBSfzVf2QPqHnvAxZam1g
        2JGiDov/DsFWs2aG4qgnnMdiS1pnQaygse9tpi0gsmEHnQtdYNWbOJU4P7cP0exWSClwi9
        tb6uyAp1R8mdD2togCbxRD0ppohKEezXTcA0+b4jHsUJGvzTP0uAAaIV3ypzaUtntJC7yU
        H8q7qzQ9lLwnBpSEzQiRCccUDoAT8YBBi2+Rh2Fq0AYFGF2Ecfxfjr0qYTJy2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630613671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9I8OlriWSRjNHUXRiqNwrgJsUjSPy3bhZS7GrgiHUgE=;
        b=BA8udAARbqDBZ7JJHK8hwbRnrMPZuelttSZPBjGgAVt4/mulciOszMAP4G8oYrw52fFIUS
        Qod8z3kzL3XFpGBQ==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Return error code instead of assigning
 it without effect
Cc:     Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        andrealmeid@collabora.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210818131840.34262-1-colin.king@canonical.com>
References: <20210818131840.34262-1-colin.king@canonical.com>
MIME-Version: 1.0
Message-ID: <163061367113.25758.10441165083274844287.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     a974b54036f79dd5e395e9f6c80c3decb4661a14
Gitweb:        https://git.kernel.org/tip/a974b54036f79dd5e395e9f6c80c3decb46=
61a14
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Wed, 18 Aug 2021 14:18:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 02 Sep 2021 22:07:18 +02:00

futex: Return error code instead of assigning it without effect

The check on the rt_waiter and top_waiter->pi_state is assigning an error
return code to ret but this later gets re-assigned, hence the check is
ineffective.

Return -EINVAL rather than assigning it to ret which was the original
intent.

Fixes: dc7109aaa233 ("futex: Validate waiter correctly in futex_proxy_trylock=
_atomic()")
Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210818131840.34262-1-colin.king@canonical.c=
om

---
 kernel/futex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index e7b4c61..30e7dae 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2025,7 +2025,7 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct =
futex_hash_bucket *hb1,
 	 * and waiting on the 'waitqueue' futex which is always !PI.
 	 */
 	if (!top_waiter->rt_waiter || top_waiter->pi_state)
-		ret =3D -EINVAL;
+		return -EINVAL;
=20
 	/* Ensure we requeue to the expected futex. */
 	if (!match_futex(top_waiter->requeue_pi_key, key2))
