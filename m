Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06693FE304
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Sep 2021 21:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbhIAT3f (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 1 Sep 2021 15:29:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39106 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbhIAT3f (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 1 Sep 2021 15:29:35 -0400
Date:   Wed, 01 Sep 2021 19:28:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630524517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikhT/bNDDiuyvn8y/gZbDDhHdEz/w7q7Zp6oSh20Hes=;
        b=I7L3Sx8Z7hlIMmtCIO4WPRcAmf8U6guzl+SGC79xFVK3/9qkhV8EqiO+5Mwt/TTzNn3N6d
        LmhE69rU6xGS1yy/L4uDYMKYFWINIzmZdzdkHVwT+XWgLLZwSQ1R9nG4rrW+Q/ezsDLpZG
        KEFqxjobKt82WM6E+sb96H8XauziMUgJ/JZO9lZl+c1w9TOoOVCJGkqfVUaYHj1kgEdN3r
        TJT8heGuqPrOSovn9N03vAmqCkFCDjR7G2YABGz1pcgY//jTZSBPwsvA/5v1gkZj2sACa1
        z/PD3Q9HhZw9gr32p4aZcpwev/1WkM0P8njVS2o16xet95fSFl7rL3NuUfBbwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630524517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikhT/bNDDiuyvn8y/gZbDDhHdEz/w7q7Zp6oSh20Hes=;
        b=v7BT0ugc/apqXlHX3Fw48F2TZOCSKAdvKgHG+8FsRFpvz8tuUqHKiYbxEq9tLsceqEDUr6
        JbMBa4flyK1OTxCQ==
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
Message-ID: <163052451566.25758.7272209152781403112.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     1f15eb89144fdd4c881ef7181d51e989a732f4f0
Gitweb:        https://git.kernel.org/tip/1f15eb89144fdd4c881ef7181d51e989a73=
2f4f0
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Wed, 18 Aug 2021 14:18:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Sep 2021 21:26:33 +02:00

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
