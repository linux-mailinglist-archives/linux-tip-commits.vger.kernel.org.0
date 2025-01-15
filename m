Return-Path: <linux-tip-commits+bounces-3226-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC93FA11D3D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83B21645DD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA78C3DAC03;
	Wed, 15 Jan 2025 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bg7M1gRP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zs76RWn/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2921620AF6C;
	Wed, 15 Jan 2025 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932642; cv=none; b=p57mOvhgNGsUWOocy/jm6dg4pbL3x4mG5h7ybCWOlz1KEj2Re6GF3K3DMD4Z5/eN/16xkTdPSV83nuDexnMV9hkFkSptWQnAckAWpiLasqeQfnfArUrpF9aSEnbuzA+sdWAIoj9g5cM5L0KJoGqy4Bc5D4Yriey8eCEA1wXPpEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932642; c=relaxed/simple;
	bh=JEGciQq6m9GrP4/z31FVUwVKR4JwWnSnNhz9mZ8mOdE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Cynca7gUQ8oUi1wh0x0TvONGtyj8u1W7dUQxJxvMX7WNFtaownC6wpETQLVbHUDCaERg81HiXu9zNeARm7m9pT6+UdmZvXYg7+s/whlRkQ+e+GFgJVvhK9B1vQZQ7rSNYrEOBKwf7H2fHYCopOmy2k3xH0b341VtqswwVJ4BjQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bg7M1gRP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zs76RWn/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932638;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGJuXkGa8U5lZR5kYUAZXxXK0zI4DuCfU0jPpX90Fn4=;
	b=bg7M1gRPRv4vvQr2lS7OdCNlR/s3XsAflnJfNwkycLGnbBWpMriCCtShZ+NLgBpQACApUP
	3CaW2+6MHcuZ7VcqD9jOEZaGApfIkraUpz8fJ64gwk1XMM8LLSWn1MwjQUBHXExyKk2vA6
	w9SqK1PYhaaSQWc06ddDuAvt8jFZ5zpPNJZIE5YsJTJ9wZ0T172ey9YSzB7LovjjjjZxpb
	joFJK4pW6MlBzwv6sgd8NmEpnEZjFyGeMgkwhtYy96UV3n21Jmu6QIrkfeOl7p0hTcx7d7
	80Uw9yVWgEhtgov3aIchCQpEIVxWut1z9DxqhCQbBOX8PCW7XkWLzqziR0sVFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932638;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGJuXkGa8U5lZR5kYUAZXxXK0zI4DuCfU0jPpX90Fn4=;
	b=Zs76RWn/RYCu79vFRizRPTduQzifmbgiW0frY5rrb3///eBHEuHWm4Mu59BFWNqfZdSf0r
	ia8/dbNfIqEh7FBA==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] x86/itmt: Convert "sysctl_sched_itmt_enabled" to boolean
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241223043407.1611-2-kprateek.nayak@amd.com>
References: <20241223043407.1611-2-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693263776.31546.17073955195344462319.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2f6f726bdda5f24227de10bc599038e0ca0d65f4
Gitweb:        https://git.kernel.org/tip/2f6f726bdda5f24227de10bc599038e0ca0d65f4
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Mon, 23 Dec 2024 04:34:00 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jan 2025 14:10:23 +01:00

x86/itmt: Convert "sysctl_sched_itmt_enabled" to boolean

In preparation to move "sysctl_sched_itmt_enabled" to debugfs, convert
the unsigned int to bool since debugfs readily exposes boolean fops
primitives (debugfs_read_file_bool, debugfs_write_file_bool) which can
streamline the conversion.

Since the current ctl_table initializes extra1 and extra2 to SYSCTL_ZERO
and SYSCTL_ONE respectively, the value of "sysctl_sched_itmt_enabled"
can only be 0 or 1 and this datatype conversion should not cause any
functional changes.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Link: https://lore.kernel.org/r/20241223043407.1611-2-kprateek.nayak@amd.com
---
 arch/x86/include/asm/topology.h | 4 ++--
 arch/x86/kernel/itmt.c          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index fd41103..63bab25 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -250,7 +250,7 @@ extern bool x86_topology_update;
 #include <asm/percpu.h>
 
 DECLARE_PER_CPU_READ_MOSTLY(int, sched_core_priority);
-extern unsigned int __read_mostly sysctl_sched_itmt_enabled;
+extern bool __read_mostly sysctl_sched_itmt_enabled;
 
 /* Interface to set priority of a cpu */
 void sched_set_itmt_core_prio(int prio, int core_cpu);
@@ -263,7 +263,7 @@ void sched_clear_itmt_support(void);
 
 #else /* CONFIG_SCHED_MC_PRIO */
 
-#define sysctl_sched_itmt_enabled	0
+#define sysctl_sched_itmt_enabled	false
 static inline void sched_set_itmt_core_prio(int prio, int core_cpu)
 {
 }
diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 51b805c..28f4491 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -36,7 +36,7 @@ static bool __read_mostly sched_itmt_capable;
  *
  * It can be set via /proc/sys/kernel/sched_itmt_enabled
  */
-unsigned int __read_mostly sysctl_sched_itmt_enabled;
+bool __read_mostly sysctl_sched_itmt_enabled;
 
 static int sched_itmt_update_handler(const struct ctl_table *table, int write,
 				     void *buffer, size_t *lenp, loff_t *ppos)

