Return-Path: <linux-tip-commits+bounces-6394-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8038DB3D2CF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 31 Aug 2025 14:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A9B179BB4
	for <lists+linux-tip-commits@lfdr.de>; Sun, 31 Aug 2025 12:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE561684B4;
	Sun, 31 Aug 2025 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KK/wfnK4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q/INEAt6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B525785C;
	Sun, 31 Aug 2025 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756643043; cv=none; b=f00M1Py/yMEg7DK2JPe9DB2vHDmLZ6RwHjtKxh1iw04nc172tOd3NvTxHgHH6R8SgzLAuY/YQlBDIBLCv5Cp6Y32jfhpHeQs8QUfhib1nSxU2l7t+7tRI0J8FlRJfFrKzr0kr5KO0c2hougyiG3i5IOj89163fkKGhUQfj9bjyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756643043; c=relaxed/simple;
	bh=TkwWDfkc2V4ryy0AWFtUjVoTAYL21FJ1M/VQVsrWIL4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KDxCIW/QV9w3XXNSFep+yL95H0EjUx7rHSkSexl4qokmer0uh9t1uO+2gWpP08U+Wo78STGtRMFmDRZEEY2Tv8ColxpfS8oaavaXdbspY+FxvshIYUsVDhYoX1zJJYFNeBr93V6ExjhDHEJS1RsGJhhx6b7sXMINppJqWOQ+pt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KK/wfnK4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q/INEAt6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 31 Aug 2025 12:23:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756643039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RUx1wjLxLywXDHDPhrV5rYxI8zpC1+Ce2rYLWx0Q2c4=;
	b=KK/wfnK4OkOt1WYMeYWs+QHT26koO8ljW8ppkGUav31V5UG80Yp+HkKSYN435YJMoedBO6
	i5kFabIGj3ZPYHbLY2KEg34Zc/EJKOYK54bmOMCXR8kTTPQwEYAeLFJ+vZJW0SGocGEcBG
	r20+PdM/naJR7G3p8SSAIc7J8wLuflb1cAu68nNmuYaBMGBoORj4hNFAgDtx9wMciILymE
	wKC4zudX0ycQrf7/c+O7z5nlySOWqGDtrQQCRsAK1ScSgUXoh4ksOdEyD0JPrBoVsYLsiF
	Hg5w7WfAye/LwqesC3aktOzUABsDDG3t87glVWgUjnGJzZiNgucLaDQFUismig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756643039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RUx1wjLxLywXDHDPhrV5rYxI8zpC1+Ce2rYLWx0Q2c4=;
	b=Q/INEAt6U1eCifGM0jHVJV6rIsgBVssV5Oab3Uv5qlpqYF/w8wbGECP12MjQjo/e9rcKYM
	BQ4quI/n3/FbUDAg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Move futex_hash_free() back to __mmput()
Cc: Jakub Kicinski <kuba@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250822141238.PfnkTjFb@linutronix.de>
References: <20250822141238.PfnkTjFb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175664303766.1920.13212322629796216488.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     d9b05321e21e4b218de4ce8a590bf375f58b6346
Gitweb:        https://git.kernel.org/tip/d9b05321e21e4b218de4ce8a590bf375f58=
b6346
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 22 Aug 2025 16:12:38 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 31 Aug 2025 11:48:19 +02:00

futex: Move futex_hash_free() back to __mmput()

To avoid a memory leak via mm_alloc() + mmdrop() the futex cleanup code
has been moved to __mmdrop(). This resulted in a warnings if the futex
hash table has been allocated via vmalloc() the mmdrop() was invoked
from atomic context.
The free path must stay in __mmput() to ensure it is invoked from
preemptible context.

In order to avoid the memory leak, delay the allocation of
mm_struct::mm->futex_ref to futex_hash_allocate(). This works because
neither the per-CPU counter nor the private hash has been allocated and
therefore
- futex_private_hash() callers (such as exit_pi_state_list()) don't
  acquire reference if there is no private hash yet. There is also no
  reference put.

- Regular callers (futex_hash()) fallback to global hash. No reference
  counting here.

The futex_ref member can be allocated in futex_hash_allocate() before
the private hash itself is allocated. This happens either while the
first thread is created or on request. In both cases the process has
just a single thread so there can be either futex operation in progress
or the request to create a private hash.

Move futex_hash_free() back to __mmput();
Move the allocation of mm_struct::futex_ref to futex_hash_allocate().

  [ bp: Fold a follow-up fix to prevent a use-after-free:
    https://lore.kernel.org/r/20250830213806.sEKuuGSm@linutronix.de ]

Fixes:  e703b7e247503 ("futex: Move futex cleanup to __mmdrop()")
Closes: https://lore.kernel.org/all/20250821102721.6deae493@kernel.org/
Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lkml.kernel.org/r/20250822141238.PfnkTjFb@linutronix.de
---
 kernel/fork.c       |  2 +-
 kernel/futex/core.c | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index af67385..c4ada32 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -689,7 +689,6 @@ void __mmdrop(struct mm_struct *mm)
 	mm_pasid_drop(mm);
 	mm_destroy_cid(mm);
 	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
-	futex_hash_free(mm);
=20
 	free_mm(mm);
 }
@@ -1138,6 +1137,7 @@ static inline void __mmput(struct mm_struct *mm)
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
 	lru_gen_del_mm(mm);
+	futex_hash_free(mm);
 	mmdrop(mm);
 }
=20
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index d9bb556..125804f 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1722,12 +1722,9 @@ int futex_mm_init(struct mm_struct *mm)
 	RCU_INIT_POINTER(mm->futex_phash, NULL);
 	mm->futex_phash_new =3D NULL;
 	/* futex-ref */
+	mm->futex_ref =3D NULL;
 	atomic_long_set(&mm->futex_atomic, 0);
 	mm->futex_batches =3D get_state_synchronize_rcu();
-	mm->futex_ref =3D alloc_percpu(unsigned int);
-	if (!mm->futex_ref)
-		return -ENOMEM;
-	this_cpu_inc(*mm->futex_ref); /* 0 -> 1 */
 	return 0;
 }
=20
@@ -1801,6 +1798,17 @@ static int futex_hash_allocate(unsigned int hash_slots=
, unsigned int flags)
 		}
 	}
=20
+	if (!mm->futex_ref) {
+		/*
+		 * This will always be allocated by the first thread and
+		 * therefore requires no locking.
+		 */
+		mm->futex_ref =3D alloc_percpu(unsigned int);
+		if (!mm->futex_ref)
+			return -ENOMEM;
+		this_cpu_inc(*mm->futex_ref); /* 0 -> 1 */
+	}
+
 	fph =3D kvzalloc(struct_size(fph, queues, hash_slots),
 		       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!fph)

