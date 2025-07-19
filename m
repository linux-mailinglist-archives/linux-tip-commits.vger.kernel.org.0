Return-Path: <linux-tip-commits+bounces-6148-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4881B0B126
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Jul 2025 19:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572B8189D9F6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Jul 2025 17:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016C6288C87;
	Sat, 19 Jul 2025 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FM+c55+B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M3bIhlgW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D1F2877FE;
	Sat, 19 Jul 2025 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752946822; cv=none; b=qEhSiu/fGmhwmjlZsk9tK6DsYplCnZQDp2IHRfgLsKgrstdNLpy9zir+L9dB03N/1Q/cVb8Falb6U6qux5/amT47SkGnOC02ltZkQn28eN5UDpzk0ZGamW7LJZDpJ9bYTY29E8fQXQKI8JP5WgOiBZrMNm4a+RTg2gqJ9ToITFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752946822; c=relaxed/simple;
	bh=mpRWe8EgaPVNiDfYuBgyxW6dshOVtMblRkrk4zGLchA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b/rC6BIE0z3dVtMrg2QY/Sj+dZJatXJ9LxAvhN+E4ukWvE7tJOlZ7o+bW0uGzY7vRmr7IUquyL8kJOSMbqAcBrt0LuCjE9xV3RPq+rmr92PjB6z0yLvCw0S8cQmQvG6Z8nxjWylK0nob2vvNx8K3mCxV87x0bHZN39Yc3y/W5F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FM+c55+B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M3bIhlgW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 19 Jul 2025 17:40:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752946813;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9oMBnPwo9oxmBUR4RRG+Oad41l3/8fY+Q8U/4BXPTlc=;
	b=FM+c55+BRN6hHAQD3s9mlpGkYUab/VHx4uye0mctYa263irpvi+8VgtX8pjuAGx2q4ROdc
	8yDJMkEJ3RMw79umyVX8ZVh+GWq+4LRH/zW0487eLXFb9T6q4+L1jkjqvcmkvZruf7GO4r
	6mKo7WL1a/aum+NS3y2d5lLjpZ6CXefgVGn875801UPehR0MnOEU44QzptiBpk5kKW0k69
	AQ19L3Gj4toyUHnIl+EfXOpvHuCykw+Fe5gIzjFQS+dH+/0R/Wn2+ENQrD8evnE+QWd/4j
	ha0TUuzcu6M6ndkhtO3qD1NiiqudW+kqbXEL+HDCCCW/TzPU0GYRRWx9UuBVtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752946813;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9oMBnPwo9oxmBUR4RRG+Oad41l3/8fY+Q8U/4BXPTlc=;
	b=M3bIhlgWL71Il/u6BY5GlKsDoTqESkjbON0oqZIBk8Lb7Jc9rvrFvj8Vi/Zo07GBm4Uw/2
	rYthk003nRnD0XDA==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] locking/lockdep: Avoid struct return in lock_stats()
Cc: Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250610092941.2642847-1-arnd@kernel.org>
References: <20250610092941.2642847-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175294681199.1420.7085850697376354418.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d7c36d6350b5a4b27256eaeeea3b72621a819c9a
Gitweb:        https://git.kernel.org/tip/d7c36d6350b5a4b27256eaeeea3b72621a8=
19c9a
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 10 Jun 2025 11:29:21 +02:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Mon, 14 Jul 2025 21:57:20 -07:00

locking/lockdep: Avoid struct return in lock_stats()

Returning a large structure from the lock_stats() function causes clang
to have multiple copies of it on the stack and copy between them, which
can end up exceeding the frame size warning limit:

kernel/locking/lockdep.c:300:25: error: stack frame size (1464) exceeds limit=
 (1280) in 'lock_stats' [-Werror,-Wframe-larger-than]
  300 | struct lock_class_stats lock_stats(struct lock_class *class)

Change the calling conventions to directly operate on the caller's copy,
which apparently is what gcc does already.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250610092941.2642847-1-arnd@kernel.org
---
 include/linux/lockdep_types.h |  2 +-
 kernel/locking/lockdep.c      | 27 ++++++++++++---------------
 kernel/locking/lockdep_proc.c |  2 +-
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 9f361d3..eae115a 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -175,7 +175,7 @@ struct lock_class_stats {
 	unsigned long			bounces[nr_bounce_types];
 };
=20
-struct lock_class_stats lock_stats(struct lock_class *class);
+void lock_stats(struct lock_class *class, struct lock_class_stats *stats);
 void clear_lock_stats(struct lock_class *class);
 #endif
=20
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index dd2bbf7..0c94141 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -297,33 +297,30 @@ static inline void lock_time_add(struct lock_time *src,=
 struct lock_time *dst)
 	dst->nr +=3D src->nr;
 }
=20
-struct lock_class_stats lock_stats(struct lock_class *class)
+void lock_stats(struct lock_class *class, struct lock_class_stats *stats)
 {
-	struct lock_class_stats stats;
 	int cpu, i;
=20
-	memset(&stats, 0, sizeof(struct lock_class_stats));
+	memset(stats, 0, sizeof(struct lock_class_stats));
 	for_each_possible_cpu(cpu) {
 		struct lock_class_stats *pcs =3D
 			&per_cpu(cpu_lock_stats, cpu)[class - lock_classes];
=20
-		for (i =3D 0; i < ARRAY_SIZE(stats.contention_point); i++)
-			stats.contention_point[i] +=3D pcs->contention_point[i];
+		for (i =3D 0; i < ARRAY_SIZE(stats->contention_point); i++)
+			stats->contention_point[i] +=3D pcs->contention_point[i];
=20
-		for (i =3D 0; i < ARRAY_SIZE(stats.contending_point); i++)
-			stats.contending_point[i] +=3D pcs->contending_point[i];
+		for (i =3D 0; i < ARRAY_SIZE(stats->contending_point); i++)
+			stats->contending_point[i] +=3D pcs->contending_point[i];
=20
-		lock_time_add(&pcs->read_waittime, &stats.read_waittime);
-		lock_time_add(&pcs->write_waittime, &stats.write_waittime);
+		lock_time_add(&pcs->read_waittime, &stats->read_waittime);
+		lock_time_add(&pcs->write_waittime, &stats->write_waittime);
=20
-		lock_time_add(&pcs->read_holdtime, &stats.read_holdtime);
-		lock_time_add(&pcs->write_holdtime, &stats.write_holdtime);
+		lock_time_add(&pcs->read_holdtime, &stats->read_holdtime);
+		lock_time_add(&pcs->write_holdtime, &stats->write_holdtime);
=20
-		for (i =3D 0; i < ARRAY_SIZE(stats.bounces); i++)
-			stats.bounces[i] +=3D pcs->bounces[i];
+		for (i =3D 0; i < ARRAY_SIZE(stats->bounces); i++)
+			stats->bounces[i] +=3D pcs->bounces[i];
 	}
-
-	return stats;
 }
=20
 void clear_lock_stats(struct lock_class *class)
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index b52c07c..1916db9 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -657,7 +657,7 @@ static int lock_stat_open(struct inode *inode, struct fil=
e *file)
 			if (!test_bit(idx, lock_classes_in_use))
 				continue;
 			iter->class =3D class;
-			iter->stats =3D lock_stats(class);
+			lock_stats(class, &iter->stats);
 			iter++;
 		}
=20

