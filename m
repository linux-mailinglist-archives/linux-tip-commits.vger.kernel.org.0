Return-Path: <linux-tip-commits+bounces-2234-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67539720A8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F351C23A63
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8AF189B83;
	Mon,  9 Sep 2024 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="crvBR/UK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ovqKTIz6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDDD18801E;
	Mon,  9 Sep 2024 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902873; cv=none; b=N9YMu2jrvueEK8Iyl3OmDAWWsQOA2762nUxl0x3oh0eW7udRY0acZokzIsZzEGQyYlc84Rs3iPuaSaJdlttHmPoecP7lrSrutRvvNhqCR+V7uedqKLTXLkKKAqEy+wZlQGM2nlSqYvV4UawdzFbQoJTLEsPI3PRu/Xs5Uo2b1lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902873; c=relaxed/simple;
	bh=4HlvjtPE2WP+ZW3I3JYxSnGh6YftplEJgo8n8/QVeS4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wb3Mkoi886e+iKGvLzx/RMMuxENhOSv+6v+Z2hd5fs68yi5rmx4VJHRXAnWjEiuOIu4O1eaRDBlJVtUKa29NzaCk8DG67cnchq9DHWaliAnrMxLdV+UneWv9ColGnY6vEfVTVDLY5OvBgVUAYjCbuLgxG0t6VExNpUCamBLBH/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=crvBR/UK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ovqKTIz6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WI/eRbk0BT93j8EPmQ12xlZjbIkXsHomcGSuX7bRbFk=;
	b=crvBR/UKB9fUGDQuZNy3+Zd7FRMJoKZSnb3ydZNTkOJfXN0ASRpuIr073gkzlxcZDmiHOD
	aZtl28otxypROihYsrnqYIhD/HN9tnBkqcESd2MuDnDtKkG1Vni3ZnIVw9QbROkuQQnIsJ
	t2m2fvObgAOLpxobwigqchU5lCIgYn32/9oKH/QA6zYJVPS97B5yZpkq5llBTeF89pCCjK
	A5Yt6QCUtPVXK6hFZSRzMxVf0hNctNx+7E04t9aegakN2AmKEHmWqxqMmGet0228LLFMXC
	Uxr9jBDKbB1s22exRNr1HnYw889uYjdpxMIJh2rm0zPqIOOgL61rcDjrNFAj8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WI/eRbk0BT93j8EPmQ12xlZjbIkXsHomcGSuX7bRbFk=;
	b=ovqKTIz6awndrks6ZTg2vc90YSzkTH/YGGzSybEqmXiKOQnTzRIxh6bYK4g2ciZumEpEnA
	x11crHl45qPYpwAw==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] lockdep: Mark emergency sections in lockdep splats
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-36-john.ogness@linutronix.de>
References: <20240820063001.36405-36-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286811.2215.14622827742069540838.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     59cd94ef80094857f0d0085daa2e32badc4cddf4
Gitweb:        https://git.kernel.org/tip/59cd94ef80094857f0d0085daa2e32badc4cddf4
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:36:01 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 15:03:04 +02:00

lockdep: Mark emergency sections in lockdep splats

Mark emergency sections wherever multiple lines of
lock debugging output are generated. In an emergency
section, every printk() call will attempt to directly
flush to the consoles using the EMERGENCY priority.

Note that debug_show_all_locks() and
lockdep_print_held_locks() rely on their callers to
enter the emergency section. This is because these
functions can also be called in non-emergency
situations (such as sysrq).

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-36-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/locking/lockdep.c | 83 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 0349f95..7963dea 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -56,6 +56,7 @@
 #include <linux/kprobes.h>
 #include <linux/lockdep.h>
 #include <linux/context_tracking.h>
+#include <linux/console.h>
 
 #include <asm/sections.h>
 
@@ -573,8 +574,10 @@ static struct lock_trace *save_trace(void)
 		if (!debug_locks_off_graph_unlock())
 			return NULL;
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_STACK_TRACE_ENTRIES too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 
 		return NULL;
 	}
@@ -887,11 +890,13 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 	if (unlikely(subclass >= MAX_LOCKDEP_SUBCLASSES)) {
 		instrumentation_begin();
 		debug_locks_off();
+		nbcon_cpu_emergency_enter();
 		printk(KERN_ERR
 			"BUG: looking up invalid subclass: %u\n", subclass);
 		printk(KERN_ERR
 			"turning off the locking correctness validator.\n");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		instrumentation_end();
 		return NULL;
 	}
@@ -968,11 +973,13 @@ static bool assign_lock_key(struct lockdep_map *lock)
 	else {
 		/* Debug-check: all keys must be persistent! */
 		debug_locks_off();
+		nbcon_cpu_emergency_enter();
 		pr_err("INFO: trying to register non-static key.\n");
 		pr_err("The code is fine but needs lockdep annotation, or maybe\n");
 		pr_err("you didn't initialize this object before use?\n");
 		pr_err("turning off the locking correctness validator.\n");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return false;
 	}
 
@@ -1316,8 +1323,10 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 			return NULL;
 		}
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCKDEP_KEYS too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return NULL;
 	}
 	nr_lock_classes++;
@@ -1349,11 +1358,13 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	if (verbose(class)) {
 		graph_unlock();
 
+		nbcon_cpu_emergency_enter();
 		printk("\nnew class %px: %s", class->key, class->name);
 		if (class->name_version > 1)
 			printk(KERN_CONT "#%d", class->name_version);
 		printk(KERN_CONT "\n");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 
 		if (!graph_lock()) {
 			return NULL;
@@ -1392,8 +1403,10 @@ static struct lock_list *alloc_list_entry(void)
 		if (!debug_locks_off_graph_unlock())
 			return NULL;
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCKDEP_ENTRIES too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return NULL;
 	}
 	nr_list_entries++;
@@ -2039,6 +2052,8 @@ static noinline void print_circular_bug(struct lock_list *this,
 
 	depth = get_lock_depth(target);
 
+	nbcon_cpu_emergency_enter();
+
 	print_circular_bug_header(target, depth, check_src, check_tgt);
 
 	parent = get_lock_parent(target);
@@ -2057,6 +2072,8 @@ static noinline void print_circular_bug(struct lock_list *this,
 
 	printk("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static noinline void print_bfs_bug(int ret)
@@ -2569,6 +2586,8 @@ print_bad_irq_dependency(struct task_struct *curr,
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=====================================================\n");
 	pr_warn("WARNING: %s-safe -> %s-unsafe lock order detected\n",
@@ -2618,11 +2637,13 @@ print_bad_irq_dependency(struct task_struct *curr,
 	pr_warn(" and %s-irq-unsafe lock:\n", irqclass);
 	next_root->trace = save_trace();
 	if (!next_root->trace)
-		return;
+		goto out;
 	print_shortest_lock_dependencies(forwards_entry, next_root);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+out:
+	nbcon_cpu_emergency_exit();
 }
 
 static const char *state_names[] = {
@@ -2987,6 +3008,8 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("============================================\n");
 	pr_warn("WARNING: possible recursive locking detected\n");
@@ -3009,6 +3032,8 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 /*
@@ -3606,6 +3631,8 @@ static void print_collision(struct task_struct *curr,
 			struct held_lock *hlock_next,
 			struct lock_chain *chain)
 {
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("============================\n");
 	pr_warn("WARNING: chain_key collision\n");
@@ -3622,6 +3649,8 @@ static void print_collision(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 #endif
 
@@ -3712,8 +3741,10 @@ static inline int add_chain_cache(struct task_struct *curr,
 		if (!debug_locks_off_graph_unlock())
 			return 0;
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCKDEP_CHAINS too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return 0;
 	}
 	chain->chain_key = chain_key;
@@ -3730,8 +3761,10 @@ static inline int add_chain_cache(struct task_struct *curr,
 		if (!debug_locks_off_graph_unlock())
 			return 0;
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return 0;
 	}
 
@@ -3970,6 +4003,8 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 	if (!debug_locks_off() || debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("================================\n");
 	pr_warn("WARNING: inconsistent lock state\n");
@@ -3998,6 +4033,8 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 /*
@@ -4032,6 +4069,8 @@ print_irq_inversion_bug(struct task_struct *curr,
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("========================================================\n");
 	pr_warn("WARNING: possible irq lock inversion dependency detected\n");
@@ -4072,11 +4111,13 @@ print_irq_inversion_bug(struct task_struct *curr,
 	pr_warn("\nthe shortest dependencies between 2nd lock and 1st lock:\n");
 	root->trace = save_trace();
 	if (!root->trace)
-		return;
+		goto out;
 	print_shortest_lock_dependencies(other, root);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+out:
+	nbcon_cpu_emergency_exit();
 }
 
 /*
@@ -4153,6 +4194,8 @@ void print_irqtrace_events(struct task_struct *curr)
 {
 	const struct irqtrace_events *trace = &curr->irqtrace;
 
+	nbcon_cpu_emergency_enter();
+
 	printk("irq event stamp: %u\n", trace->irq_events);
 	printk("hardirqs last  enabled at (%u): [<%px>] %pS\n",
 		trace->hardirq_enable_event, (void *)trace->hardirq_enable_ip,
@@ -4166,6 +4209,8 @@ void print_irqtrace_events(struct task_struct *curr)
 	printk("softirqs last disabled at (%u): [<%px>] %pS\n",
 		trace->softirq_disable_event, (void *)trace->softirq_disable_ip,
 		(void *)trace->softirq_disable_ip);
+
+	nbcon_cpu_emergency_exit();
 }
 
 static int HARDIRQ_verbose(struct lock_class *class)
@@ -4686,10 +4731,12 @@ unlock:
 	 * We must printk outside of the graph_lock:
 	 */
 	if (ret == 2) {
+		nbcon_cpu_emergency_enter();
 		printk("\nmarked lock as {%s}:\n", usage_str[new_bit]);
 		print_lock(this);
 		print_irqtrace_events(curr);
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 	}
 
 	return ret;
@@ -4730,6 +4777,8 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 	if (debug_locks_silent)
 		return 0;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=============================\n");
 	pr_warn("[ BUG: Invalid wait context ]\n");
@@ -4749,6 +4798,8 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 	pr_warn("stack backtrace:\n");
 	dump_stack();
 
+	nbcon_cpu_emergency_exit();
+
 	return 0;
 }
 
@@ -4956,6 +5007,8 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("==================================\n");
 	pr_warn("WARNING: Nested lock was not taken\n");
@@ -4976,6 +5029,8 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static int __lock_is_held(const struct lockdep_map *lock, int read);
@@ -5024,11 +5079,13 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	debug_class_ops_inc(class);
 
 	if (very_verbose(class)) {
+		nbcon_cpu_emergency_enter();
 		printk("\nacquire class [%px] %s", class->key, class->name);
 		if (class->name_version > 1)
 			printk(KERN_CONT "#%d", class->name_version);
 		printk(KERN_CONT "\n");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 	}
 
 	/*
@@ -5155,6 +5212,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 #endif
 	if (unlikely(curr->lockdep_depth >= MAX_LOCK_DEPTH)) {
 		debug_locks_off();
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCK_DEPTH too low!");
 		printk(KERN_DEBUG "depth: %i  max: %lu!\n",
 		       curr->lockdep_depth, MAX_LOCK_DEPTH);
@@ -5162,6 +5220,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		lockdep_print_held_locks(current);
 		debug_show_all_locks();
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 
 		return 0;
 	}
@@ -5181,6 +5240,8 @@ static void print_unlock_imbalance_bug(struct task_struct *curr,
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=====================================\n");
 	pr_warn("WARNING: bad unlock balance detected!\n");
@@ -5197,6 +5258,8 @@ static void print_unlock_imbalance_bug(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static noinstr int match_held_lock(const struct held_lock *hlock,
@@ -5901,6 +5964,8 @@ static void print_lock_contention_bug(struct task_struct *curr,
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=================================\n");
 	pr_warn("WARNING: bad contention detected!\n");
@@ -5917,6 +5982,8 @@ static void print_lock_contention_bug(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static void
@@ -6536,6 +6603,8 @@ print_freed_lock_bug(struct task_struct *curr, const void *mem_from,
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=========================\n");
 	pr_warn("WARNING: held lock freed!\n");
@@ -6548,6 +6617,8 @@ print_freed_lock_bug(struct task_struct *curr, const void *mem_from,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static inline int not_in_range(const void* mem_from, unsigned long mem_len,
@@ -6594,6 +6665,8 @@ static void print_held_locks_bug(void)
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("====================================\n");
 	pr_warn("WARNING: %s/%d still has locks held!\n",
@@ -6603,6 +6676,8 @@ static void print_held_locks_bug(void)
 	lockdep_print_held_locks(current);
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 void debug_check_no_locks_held(void)
@@ -6660,6 +6735,7 @@ asmlinkage __visible void lockdep_sys_exit(void)
 	if (unlikely(curr->lockdep_depth)) {
 		if (!debug_locks_off())
 			return;
+		nbcon_cpu_emergency_enter();
 		pr_warn("\n");
 		pr_warn("================================================\n");
 		pr_warn("WARNING: lock held when returning to user space!\n");
@@ -6668,6 +6744,7 @@ asmlinkage __visible void lockdep_sys_exit(void)
 		pr_warn("%s/%d is leaving the kernel with locks still held!\n",
 				curr->comm, curr->pid);
 		lockdep_print_held_locks(curr);
+		nbcon_cpu_emergency_exit();
 	}
 
 	/*
@@ -6684,6 +6761,7 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	bool rcu = warn_rcu_enter();
 
 	/* Note: the following can be executed concurrently, so be careful. */
+	nbcon_cpu_emergency_enter();
 	pr_warn("\n");
 	pr_warn("=============================\n");
 	pr_warn("WARNING: suspicious RCU usage\n");
@@ -6722,6 +6800,7 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	lockdep_print_held_locks(curr);
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+	nbcon_cpu_emergency_exit();
 	warn_rcu_exit(rcu);
 }
 EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);

