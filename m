Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2A4278B9
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhJIKJL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244611AbhJIKJL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9F5C061755;
        Sat,  9 Oct 2021 03:07:14 -0700 (PDT)
Date:   Sat, 09 Oct 2021 10:07:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774033;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mgVcg86ySe7V9//qZNso9eTJvEn+J0ELgoA21bz10VQ=;
        b=0bx1Vsf3c00FpPJX1yy6pi/5EMh/8q/le/h/h309rgxGvaPvKkf8lJcqqBBm+YWtkQnoR8
        NnuqZYdXILzygOJJOjyX270R7dkFReoMMdteJUJGjsFif3rpvw7PSZwNTHeTqNQkzqMQLp
        4hqwspVvf6MZVDxyDgcJX5+nJIb98nNvHGBBmSgpibW5zzJyXxQsbAI1EZKlCp9eimDcIL
        ZlxavwitG7sdxAzctQ/JhltfmONKrfzHc+ZN5kPLxRdKFCRWWnSC+8ESp4viwZE8Cn+jSb
        W99gbcbgjkgmoGtgpy9OrsV9qU3nUG1XRHTvT0yFPgTL7Q6Ufi5P3uinVYFj/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774033;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mgVcg86ySe7V9//qZNso9eTJvEn+J0ELgoA21bz10VQ=;
        b=7E6okQSo8wPmtC/VFZqodzuD6TyzWkX1FnvOaWdJEifxyBRCoh/bFs54HxhIJwMX6s7dGA
        zCCd+z7Y5d2m/YCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Rename: {get,cmpxchg}_futex_value_locked()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        andrealmeid@collabora.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-9-andrealmeid@collabora.com>
References: <20210923171111.300673-9-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377403205.25758.15141836376026436573.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     966cb75f86fb15e2659c8105d20d4889e18dda24
Gitweb:        https://git.kernel.org/tip/966cb75f86fb15e2659c8105d20d4889e18=
dda24
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Sep 2021 14:10:57 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:09 +02:00

futex: Rename: {get,cmpxchg}_futex_value_locked()

In order to prepare introducing these symbols into the global
namespace; rename them:

 s/\<\([^_ ]*\)_futex_value_locked/futex_\1_value_locked/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210923171111.300673-9-andrealmeid@collabora=
.com
---
 kernel/futex/core.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 032189f..0e10aee 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -732,7 +732,7 @@ static struct futex_q *futex_top_waiter(struct futex_hash=
_bucket *hb,
 	return NULL;
 }
=20
-static int cmpxchg_futex_value_locked(u32 *curval, u32 __user *uaddr,
+static int futex_cmpxchg_value_locked(u32 *curval, u32 __user *uaddr,
 				      u32 uval, u32 newval)
 {
 	int ret;
@@ -744,7 +744,7 @@ static int cmpxchg_futex_value_locked(u32 *curval, u32 __=
user *uaddr,
 	return ret;
 }
=20
-static int get_futex_value_locked(u32 *dest, u32 __user *from)
+static int futex_get_value_locked(u32 *dest, u32 __user *from)
 {
 	int ret;
=20
@@ -1070,7 +1070,7 @@ static int attach_to_pi_state(u32 __user *uaddr, u32 uv=
al,
 	 * still is what we expect it to be, otherwise retry the entire
 	 * operation.
 	 */
-	if (get_futex_value_locked(&uval2, uaddr))
+	if (futex_get_value_locked(&uval2, uaddr))
 		goto out_efault;
=20
 	if (uval !=3D uval2)
@@ -1220,7 +1220,7 @@ static int handle_exit_race(u32 __user *uaddr, u32 uval,
 	 * The same logic applies to the case where the exiting task is
 	 * already gone.
 	 */
-	if (get_futex_value_locked(&uval2, uaddr))
+	if (futex_get_value_locked(&uval2, uaddr))
 		return -EFAULT;
=20
 	/* If the user space value has changed, try again. */
@@ -1341,7 +1341,7 @@ static int lock_pi_update_atomic(u32 __user *uaddr, u32=
 uval, u32 newval)
 	if (unlikely(should_fail_futex(true)))
 		return -EFAULT;
=20
-	err =3D cmpxchg_futex_value_locked(&curval, uaddr, uval, newval);
+	err =3D futex_cmpxchg_value_locked(&curval, uaddr, uval, newval);
 	if (unlikely(err))
 		return err;
=20
@@ -1388,7 +1388,7 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, stru=
ct futex_hash_bucket *hb,
 	 * Read the user space value first so we can validate a few
 	 * things before proceeding further.
 	 */
-	if (get_futex_value_locked(&uval, uaddr))
+	if (futex_get_value_locked(&uval, uaddr))
 		return -EFAULT;
=20
 	if (unlikely(should_fail_futex(true)))
@@ -1559,7 +1559,7 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, s=
truct futex_pi_state *pi_
 		goto out_unlock;
 	}
=20
-	ret =3D cmpxchg_futex_value_locked(&curval, uaddr, uval, newval);
+	ret =3D futex_cmpxchg_value_locked(&curval, uaddr, uval, newval);
 	if (!ret && (curval !=3D uval)) {
 		/*
 		 * If a unconditional UNLOCK_PI operation (user space did not
@@ -2006,7 +2006,7 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct =
futex_hash_bucket *hb1,
 	u32 curval;
 	int ret;
=20
-	if (get_futex_value_locked(&curval, pifutex))
+	if (futex_get_value_locked(&curval, pifutex))
 		return -EFAULT;
=20
 	if (unlikely(should_fail_futex(true)))
@@ -2182,7 +2182,7 @@ retry_private:
 	if (likely(cmpval !=3D NULL)) {
 		u32 curval;
=20
-		ret =3D get_futex_value_locked(&curval, uaddr1);
+		ret =3D futex_get_value_locked(&curval, uaddr1);
=20
 		if (unlikely(ret)) {
 			double_unlock_hb(hb1, hb2);
@@ -2628,14 +2628,14 @@ retry:
 	if (!pi_state->owner)
 		newtid |=3D FUTEX_OWNER_DIED;
=20
-	err =3D get_futex_value_locked(&uval, uaddr);
+	err =3D futex_get_value_locked(&uval, uaddr);
 	if (err)
 		goto handle_err;
=20
 	for (;;) {
 		newval =3D (uval & FUTEX_OWNER_DIED) | newtid;
=20
-		err =3D cmpxchg_futex_value_locked(&curval, uaddr, uval, newval);
+		err =3D futex_cmpxchg_value_locked(&curval, uaddr, uval, newval);
 		if (err)
 			goto handle_err;
=20
@@ -2872,7 +2872,7 @@ retry:
 retry_private:
 	*hb =3D futex_q_lock(q);
=20
-	ret =3D get_futex_value_locked(&uval, uaddr);
+	ret =3D futex_get_value_locked(&uval, uaddr);
=20
 	if (ret) {
 		futex_q_unlock(*hb);
@@ -3250,7 +3250,7 @@ retry:
 	 * preserve the WAITERS bit not the OWNER_DIED one. We are the
 	 * owner.
 	 */
-	if ((ret =3D cmpxchg_futex_value_locked(&curval, uaddr, uval, 0))) {
+	if ((ret =3D futex_cmpxchg_value_locked(&curval, uaddr, uval, 0))) {
 		spin_unlock(&hb->lock);
 		switch (ret) {
 		case -EFAULT:
@@ -3588,7 +3588,7 @@ retry:
 	 * does not guarantee R/W access. If that fails we
 	 * give up and leave the futex locked.
 	 */
-	if ((err =3D cmpxchg_futex_value_locked(&nval, uaddr, uval, mval))) {
+	if ((err =3D futex_cmpxchg_value_locked(&nval, uaddr, uval, mval))) {
 		switch (err) {
 		case -EFAULT:
 			if (fault_in_user_writeable(uaddr))
@@ -3934,7 +3934,7 @@ static void __init futex_detect_cmpxchg(void)
 	 * implementation, the non-functional ones will return
 	 * -ENOSYS.
 	 */
-	if (cmpxchg_futex_value_locked(&curval, NULL, 0, 0) =3D=3D -EFAULT)
+	if (futex_cmpxchg_value_locked(&curval, NULL, 0, 0) =3D=3D -EFAULT)
 		futex_cmpxchg_enabled =3D 1;
 #endif
 }
