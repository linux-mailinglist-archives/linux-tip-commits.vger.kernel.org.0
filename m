Return-Path: <linux-tip-commits+bounces-7660-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25342CBB7A7
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12E81302DB41
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 07:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC872D47E6;
	Sun, 14 Dec 2025 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ZVTk67z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zlxfk/wp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5DC2C15BA;
	Sun, 14 Dec 2025 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765698411; cv=none; b=daqAIjH2VV/FmFOUhoBXcSzcYEXQWa+sDyWEHQvMWfIT3ZwIDeD/E9CsNuU/xnSBpuutgD2spi9sbbxZLTfPSrPGfX4gX4IcjrmCF8/BuX5t7H46c4sphvlgjFjt8BlJVT2isdixwj0KSAh8s3dH4nUggVHJzkr+S65vWiAN+gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765698411; c=relaxed/simple;
	bh=VOs43nOmU7BhkL1Ws7D6evaAN9Kn6XZQJgZ+DtKhdbw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=FdFYeSLZfoIS7V/URKIQ6xhQUDaXdm4p+OOZ6Tqd5DfRUiCwYwSt9JuOJLcXeOBo7wn8q+heOCPTt+80SurbbqtuYXux7T3496EY18OnVnpkYg0ukUBAHrB1SVAxrrZ9FFqrK+JTZi3VSwwpHDyQuhIIHODnJJ4pndKWUYk5Zx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ZVTk67z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zlxfk/wp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 07:46:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765698408;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Kukr87NGHRNDZjewuIGhXaZ9/3YjVKHKrrZKHTe0t8I=;
	b=2ZVTk67zdyPo6zzsThM7YdN1Navgj4KygwHrZioFhKNnBa0CMt6U1CjwT7NRawVPenG1l4
	atu0ddmDro4J2MGbwa19//0a5RZ+0sH5C4mobTf0y3D5xVnHjUBPDv//8ehoyd8Z6eHoPC
	a4oJmS/9XPoayj9CaSh3zvaye1uKIKgXVh/Fq+RBX+Icn9Fd01SpgBZe/mXGfnnqEfjU/8
	Fu2pSxdXjhLtIIrGBAm/TEfrshAHdgH/e7ZN0SPn996kbxajKSMoy/gNsQeokvzL3pMd83
	KMKPu6SB+hdU9R7JAcqF2GVO7NejfaYSfW8oVsNEqctqeyXj4e9mgihoa3xuDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765698408;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Kukr87NGHRNDZjewuIGhXaZ9/3YjVKHKrrZKHTe0t8I=;
	b=zlxfk/wp/eCPz2031Da8IPSH8GqTVCd7vt8ALpcC7L6kjNUpI7yFbjJ5y9cv5FnlXoTnhx
	9T4wL8uBqSdgEuAg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Rename
 rcu_dereference_check_sched_domain() => rcu_dereference_sched_domain()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176569840673.498.17925870710882448818.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f24165bfa7ef6b37856c8f51e2001b9ad10ba688
Gitweb:        https://git.kernel.org/tip/f24165bfa7ef6b37856c8f51e2001b9ad10=
ba688
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 28 Nov 2025 13:31:36 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 08:25:02 +01:00

sched/headers: Rename rcu_dereference_check_sched_domain() =3D> rcu_dereferen=
ce_sched_domain()

Remove check from the name for being surplus to requirements.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c  | 2 +-
 kernel/sched/sched.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 708ad01..74a0550 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12857,7 +12857,7 @@ static int sched_balance_newidle(struct rq *this_rq, =
struct rq_flags *rf)
 	rq_unpin_lock(this_rq, rf);
=20
 	rcu_read_lock();
-	sd =3D rcu_dereference_check_sched_domain(this_rq->sd);
+	sd =3D rcu_dereference_sched_domain(this_rq->sd);
 	if (!sd) {
 		rcu_read_unlock();
 		goto out;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d30cca6..2c0a4ea 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2010,7 +2010,7 @@ queue_balance_callback(struct rq *rq,
 	rq->balance_callback =3D head;
 }
=20
-#define rcu_dereference_check_sched_domain(p) \
+#define rcu_dereference_sched_domain(p) \
 	rcu_dereference_check((p), lockdep_is_held(&sched_domains_mutex))
=20
 /*
@@ -2021,7 +2021,7 @@ queue_balance_callback(struct rq *rq,
  * preempt-disabled sections.
  */
 #define for_each_domain(cpu, __sd) \
-	for (__sd =3D rcu_dereference_check_sched_domain(cpu_rq(cpu)->sd); \
+	for (__sd =3D rcu_dereference_sched_domain(cpu_rq(cpu)->sd); \
 			__sd; __sd =3D __sd->parent)
=20
 /* A mask of all the SD flags that have the SDF_SHARED_CHILD metaflag */

