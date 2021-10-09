Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EF14278B7
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244550AbhJIKJK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhJIKJH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:07 -0400
Date:   Sat, 09 Oct 2021 10:07:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774030;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5IbTqhzOGb0zYbY6g5/MK9naQdt1JE7Fh/rl+SODmMU=;
        b=TsNoPoCnTm9PbWCJjNY3FtE8gUqZyl7f2qJdAVXT9hCI21w84w8ynRV1L7J09a9SUKeP8h
        e92oAZrhNkZDtKKD7Xz2k4HExHPwW8tlWXRyE03i7NVQDqUtDGq0OJIpde24J5V/Z1e879
        Rxob1hk6Dvg9PB/BKLxqQVYdjmtsStB3409pk+RsszjCIn1vTdWw1y0KK4UajiapWH4L5Q
        208CYYl8239WUlPuEAuKgY8VuRHOqB97znQRV8CDIPBsxv9NeOrA1fcF/6c0CUjHG85Gmu
        9wkzqLxCYV6bhuTMmj23yn5SU6lfbWnuiShGNQt/48A6MJyA0bWagov4RG1gdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774030;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5IbTqhzOGb0zYbY6g5/MK9naQdt1JE7Fh/rl+SODmMU=;
        b=U+abGj30MRmakyA/CkrKrsVVeAV5cS0IEG1GOCwyqwod1SpSsNQD4NbJ9Ha0EOhEqaNVFI
        uRiWQ81rluSt8gAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Rename: match_futex()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        andrealmeid@collabora.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-12-andrealmeid@collabora.com>
References: <20210923171111.300673-12-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377402919.25758.2682691761436860722.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f56a76fde353dd274eef0ea9d371379950079951
Gitweb:        https://git.kernel.org/tip/f56a76fde353dd274eef0ea9d3713799500=
79951
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Sep 2021 14:11:00 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:10 +02:00

futex: Rename: match_futex()

In order to prepare introducing these symbols into the global
namespace; rename:

  s/match_futex/futex_match/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210923171111.300673-12-andrealmeid@collabor=
a.com
---
 kernel/futex/core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index a26045e..30246e6 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -324,13 +324,13 @@ struct futex_hash_bucket *futex_hash(union futex_key *k=
ey)
=20
=20
 /**
- * match_futex - Check whether two futex keys are equal
+ * futex_match - Check whether two futex keys are equal
  * @key1:	Pointer to key1
  * @key2:	Pointer to key2
  *
  * Return 1 if two futex_keys are equal, 0 otherwise.
  */
-static inline int match_futex(union futex_key *key1, union futex_key *key2)
+static inline int futex_match(union futex_key *key1, union futex_key *key2)
 {
 	return (key1 && key2
 		&& key1->both.word =3D=3D key2->both.word
@@ -381,7 +381,7 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *=
timeout,
  * a new sequence number and will _NOT_ match, even though it is the exact s=
ame
  * file.
  *
- * It is important that match_futex() will never have a false-positive, esp.
+ * It is important that futex_match() will never have a false-positive, esp.
  * for PI futexes that can mess up the state. The above argues that false-ne=
gatives
  * are only possible for malformed programs.
  */
@@ -648,7 +648,7 @@ struct futex_q *futex_top_waiter(struct futex_hash_bucket=
 *hb, union futex_key *
 	struct futex_q *this;
=20
 	plist_for_each_entry(this, &hb->chain, list) {
-		if (match_futex(&this->key, key))
+		if (futex_match(&this->key, key))
 			return this;
 	}
 	return NULL;
@@ -808,7 +808,7 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, int=
 nr_wake, u32 bitset)
 	spin_lock(&hb->lock);
=20
 	plist_for_each_entry_safe(this, next, &hb->chain, list) {
-		if (match_futex (&this->key, &key)) {
+		if (futex_match (&this->key, &key)) {
 			if (this->pi_state || this->rt_waiter) {
 				ret =3D -EINVAL;
 				break;
@@ -928,7 +928,7 @@ retry_private:
 	}
=20
 	plist_for_each_entry_safe(this, next, &hb1->chain, list) {
-		if (match_futex (&this->key, &key1)) {
+		if (futex_match (&this->key, &key1)) {
 			if (this->pi_state || this->rt_waiter) {
 				ret =3D -EINVAL;
 				goto out_unlock;
@@ -942,7 +942,7 @@ retry_private:
 	if (op_ret > 0) {
 		op_ret =3D 0;
 		plist_for_each_entry_safe(this, next, &hb2->chain, list) {
-			if (match_futex (&this->key, &key2)) {
+			if (futex_match (&this->key, &key2)) {
 				if (this->pi_state || this->rt_waiter) {
 					ret =3D -EINVAL;
 					goto out_unlock;
@@ -1199,7 +1199,7 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct =
futex_hash_bucket *hb1,
 		return -EINVAL;
=20
 	/* Ensure we requeue to the expected futex. */
-	if (!match_futex(top_waiter->requeue_pi_key, key2))
+	if (!futex_match(top_waiter->requeue_pi_key, key2))
 		return -EINVAL;
=20
 	/* Ensure that this does not race against an early wakeup */
@@ -1334,7 +1334,7 @@ retry:
 	 * The check above which compares uaddrs is not sufficient for
 	 * shared futexes. We need to compare the keys:
 	 */
-	if (requeue_pi && match_futex(&key1, &key2))
+	if (requeue_pi && futex_match(&key1, &key2))
 		return -EINVAL;
=20
 	hb1 =3D futex_hash(&key1);
@@ -1469,7 +1469,7 @@ retry_private:
 		if (task_count - nr_wake >=3D nr_requeue)
 			break;
=20
-		if (!match_futex(&this->key, &key1))
+		if (!futex_match(&this->key, &key1))
 			continue;
=20
 		/*
@@ -1496,7 +1496,7 @@ retry_private:
 		}
=20
 		/* Ensure we requeue to the expected futex for requeue_pi. */
-		if (!match_futex(this->requeue_pi_key, &key2)) {
+		if (!futex_match(this->requeue_pi_key, &key2)) {
 			ret =3D -EINVAL;
 			break;
 		}
@@ -2033,7 +2033,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 	 * The check above which compares uaddrs is not sufficient for
 	 * shared futexes. We need to compare the keys:
 	 */
-	if (match_futex(&q.key, &key2)) {
+	if (futex_match(&q.key, &key2)) {
 		futex_q_unlock(hb);
 		ret =3D -EINVAL;
 		goto out;
