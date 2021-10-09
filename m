Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE92F4278B6
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244585AbhJIKJJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49394 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244461AbhJIKJG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:06 -0400
Date:   Sat, 09 Oct 2021 10:07:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774029;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4pZs7I/bd51vp0/gQHyhb4e3/kuUaJ0j47Y67WXZSI=;
        b=X3mWwPufp7AsxL0KjtBP3IDltZ+nwejGgmW5YxqvD+CtLZJySGi5EEHXfM2I8H8rV6gOGM
        b5HHm8huBEvZBCxvdzO7CK3s0/O+EjuNDy+huh1mXxh4Uhj6bKKgXhf5kX316WsN6L/KOv
        8TFdxJ589X/mKRbA6BRUNuLAlktSi2ptt8I5OCE1EnIwcsJOQDIDwOyCcpLYTXxu4LiFKT
        U3YXGCuUKW2uAAZLaHXpoJ6viWVnJZ+NRavbcNCSquUT5y5KKONYbNLHLdKUL4cPpwrSEp
        Q7ctiwuh1udorguZEXRDgRDqBC6FE4BCD8z9dztXnNS86uiNxBjtM7v6/isb1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774029;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4pZs7I/bd51vp0/gQHyhb4e3/kuUaJ0j47Y67WXZSI=;
        b=gmCdNTILoHPIjdxIp15yBe/Y0iq1gWEcc+xq3s8YFZV9lQgoT/jM+lCCwmujMqsG5iNoXx
        kf1eD1yXW+I8LwBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Rename mark_wake_futex()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        andrealmeid@collabora.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-13-andrealmeid@collabora.com>
References: <20210923171111.300673-13-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377402830.25758.18347799780873122384.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     95c336a7d8f0c1c34ee99e0162dc64d283da7618
Gitweb:        https://git.kernel.org/tip/95c336a7d8f0c1c34ee99e0162dc64d283d=
a7618
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Sep 2021 14:11:01 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:10 +02:00

futex: Rename mark_wake_futex()

In order to prepare introducing these symbols into the global
namespace; rename:

  s/mark_wake_futex/futex_wake_mark/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210923171111.300673-13-andrealmeid@collabor=
a.com
---
 kernel/futex/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 30246e6..bcc4aa0 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -732,7 +732,7 @@ static void __futex_unqueue(struct futex_q *q)
  * must ensure to later call wake_up_q() for the actual
  * wakeups to occur.
  */
-static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
+static void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q)
 {
 	struct task_struct *p =3D q->task;
=20
@@ -818,7 +818,7 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, int=
 nr_wake, u32 bitset)
 			if (!(this->bitset & bitset))
 				continue;
=20
-			mark_wake_futex(&wake_q, this);
+			futex_wake_mark(&wake_q, this);
 			if (++ret >=3D nr_wake)
 				break;
 		}
@@ -933,7 +933,7 @@ retry_private:
 				ret =3D -EINVAL;
 				goto out_unlock;
 			}
-			mark_wake_futex(&wake_q, this);
+			futex_wake_mark(&wake_q, this);
 			if (++ret >=3D nr_wake)
 				break;
 		}
@@ -947,7 +947,7 @@ retry_private:
 					ret =3D -EINVAL;
 					goto out_unlock;
 				}
-				mark_wake_futex(&wake_q, this);
+				futex_wake_mark(&wake_q, this);
 				if (++op_ret >=3D nr_wake2)
 					break;
 			}
@@ -1489,7 +1489,7 @@ retry_private:
 		/* Plain futexes just wake or requeue and are done */
 		if (!requeue_pi) {
 			if (++task_count <=3D nr_wake)
-				mark_wake_futex(&wake_q, this);
+				futex_wake_mark(&wake_q, this);
 			else
 				requeue_futex(this, hb1, hb2, &key2);
 			continue;
