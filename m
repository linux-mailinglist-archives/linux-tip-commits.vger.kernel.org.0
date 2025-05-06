Return-Path: <linux-tip-commits+bounces-5321-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA3EAACC84
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 19:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEE35054F5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 17:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855822857C7;
	Tue,  6 May 2025 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FhMTS4H5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u6fb4KEk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0902857F9;
	Tue,  6 May 2025 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746553924; cv=none; b=HhOnwR6dmWWPfk1hrXuQeJX9v9R9W240SHwZ2HYT2bNZdcgVyhqKkUEHSR/t81bwjNNGVk/5C21k0U3Ddfz1FvT6VRIOOzPB6B6KxhHmyD0RhUR5cy1JbAYvxRMi2o1lVEWz6jjVit0wO4+mj6d+ACgzQmjuydWoEmmLs0bpYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746553924; c=relaxed/simple;
	bh=+zBvID6pdQggJhA19nORDhI+WskB0lYsDHOqPp+OYlE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Q7S2cBOp+49fWQ3lD87FE1SdRZaQpa5ZAdHK9hGeHe5XbYx/Vc5EOh/vF6pvMwDBTxR9RO8+vlh9AQPZMzP3IGqNGxEGxdIiqLNgwRszWCAIHxG4fni1zsn3cjXW490HW3Dmk950/KEbNNxwdLnoje/UHcRVIvSd5VDaCYcqH0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FhMTS4H5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u6fb4KEk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 17:51:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746553920;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrELiDwvwRJZFDFJYCE8vcMrS3XwWZLY1inE0Rnih+s=;
	b=FhMTS4H5ZKQxWzBsOzT0xRf1dWHNwVB2S3wijtGgQd98nk2opSW18JNgopaLVtAfCODYzw
	uaJtfpPL8dyHPo1L32N7W7FbpDx4uTtKW0h2rCxbUG3Qoyi0SVGyPMrWllUyM5Bhj/r+mC
	n0eziuM/AdUAYk5VLOywpHhX7occhYfe5uugmhe7Ljf0/IOzlK3kvfh/N7aV4NeiX3fLyz
	cD2oFXhy9KhFTKAzgUVeSaWmmvem/5/QoSB2Ico0ORIt6rj2dwwXcZY5t+M9h9S6Rneg+E
	PCmHKnjl4ROJT5sFcV5Yoj/Eu1WBT6XSbzT8gmeH8EpRWIWpBfHGDI1Kw12MhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746553920;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrELiDwvwRJZFDFJYCE8vcMrS3XwWZLY1inE0Rnih+s=;
	b=u6fb4KEkfBkZlouyv+fOkog/5lDVGQx9hQOnNsGMzU7EjLSxh1Qv4kd2QK16563uc7bIwe
	2SEEYWGvl+9o69BQ==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Add number of dynamic keys to
 /proc/lockdep_stats
Cc: Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 llvm@lists.linux.dev, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250506042049.50060-4-boqun.feng@gmail.com>
References: <20250506042049.50060-4-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174655391949.406.15401244848537848279.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     cdb7d2d68cde6145a06a56c9d5d5d917297501c6
Gitweb:        https://git.kernel.org/tip/cdb7d2d68cde6145a06a56c9d5d5d917297501c6
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Mon, 05 May 2025 21:20:49 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 06 May 2025 18:34:43 +02:00

locking/lockdep: Add number of dynamic keys to /proc/lockdep_stats

There have been recent reports about running out of lockdep keys:

	MAX_LOCKDEP_KEYS too low!

One possible reason is that too many dynamic keys have been registered.
A possible culprit is the lockdep_register_key() call in qdisc_alloc()
of net/sched/sch_generic.c.

Currently, there is no way to find out how many dynamic keys have been
registered. Add such a stat to the /proc/lockdep_stats to get better
clarity.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: llvm@lists.linux.dev
Link: https://lore.kernel.org/r/20250506042049.50060-4-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c           | 3 +++
 kernel/locking/lockdep_internals.h | 1 +
 kernel/locking/lockdep_proc.c      | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 050dbe9..dd2bbf7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -219,6 +219,7 @@ static DECLARE_BITMAP(list_entries_in_use, MAX_LOCKDEP_ENTRIES);
 static struct hlist_head lock_keys_hash[KEYHASH_SIZE];
 unsigned long nr_lock_classes;
 unsigned long nr_zapped_classes;
+unsigned long nr_dynamic_keys;
 unsigned long max_lock_class_idx;
 struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
 DECLARE_BITMAP(lock_classes_in_use, MAX_LOCKDEP_KEYS);
@@ -1238,6 +1239,7 @@ void lockdep_register_key(struct lock_class_key *key)
 			goto out_unlock;
 	}
 	hlist_add_head_rcu(&key->hash_entry, hash_head);
+	nr_dynamic_keys++;
 out_unlock:
 	graph_unlock();
 restore_irqs:
@@ -6609,6 +6611,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
 		pf = get_pending_free();
 		__lockdep_free_key_range(pf, key, 1);
 		need_callback = prepare_call_rcu_zapped(pf);
+		nr_dynamic_keys--;
 	}
 	lockdep_unlock();
 	raw_local_irq_restore(flags);
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 20f9ef5..82156ca 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -138,6 +138,7 @@ extern unsigned long nr_lock_classes;
 extern unsigned long nr_zapped_classes;
 extern unsigned long nr_zapped_lock_chains;
 extern unsigned long nr_list_entries;
+extern unsigned long nr_dynamic_keys;
 long lockdep_next_lockchain(long i);
 unsigned long lock_chain_count(void);
 extern unsigned long nr_stack_trace_entries;
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 6db0f43..b52c07c 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -286,6 +286,8 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 #endif
 	seq_printf(m, " lock-classes:                  %11lu [max: %lu]\n",
 			nr_lock_classes, MAX_LOCKDEP_KEYS);
+	seq_printf(m, " dynamic-keys:                  %11lu\n",
+			nr_dynamic_keys);
 	seq_printf(m, " direct dependencies:           %11lu [max: %lu]\n",
 			nr_list_entries, MAX_LOCKDEP_ENTRIES);
 	seq_printf(m, " indirect dependencies:         %11lu\n",

