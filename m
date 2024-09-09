Return-Path: <linux-tip-commits+bounces-2237-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234319720B0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB5C1C23AB3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736DE189F39;
	Mon,  9 Sep 2024 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3rLy5Tz+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H2tvAMtO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F9118859E;
	Mon,  9 Sep 2024 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902874; cv=none; b=qaKw/6a9GHBpOjo7pznGHVeJAmftUlgrUdUftCR+pLMGjlL2fZ39UN2rzsQmU3AsGCqlQgsPZNXL5mlEGB/uORA+X9SktxmI3+Y8DCss8mpQWtES+wYLyjgpzFnTPVN2u87T3A0grCKms+EFk0V/KymTFxC/OEQH1seB6hBvbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902874; c=relaxed/simple;
	bh=pUQMs8wMW1JGyxPLe8A5yf7rj3TeygKsTWcinSm3b5M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ww40e0DW/zb7xPwv9WV0imper6VqWCLtqlVcLCNbetgAczVDvaKzwHQEaatqA4+q2Bvr7O6DxJAdf2zKVPie+qaD4faFXI3sJ8FDcKij8Ifn3rWGZhZUYgZc4CApK1JnFdRT3LvEF4mjMg4GQP8m4cv0XMPEtRwJE2n3XR6708c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3rLy5Tz+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H2tvAMtO; arc=none smtp.client-ip=193.142.43.55
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
	bh=JOunnIquxWgf4BeX8X/EoXgldMQcaEqD0fnsHYEc0D8=;
	b=3rLy5Tz+M29gsflyzAjKOskeZ+neYkB8NIT6cPcaPp+bTDsSw7RztdzqMfRthU8c+88O/2
	euk6qh/BtsnFarXvb+yD+qir+MMEE3aGy5qaC9HQPZomYkQPZ+bwR9L91GQcBxpnZVhEfL
	Z1czSRSKYJ2Q3x2eaBYYlMJGJ7o77g3XMxuO4FPqGJ/bcp+cTTOQYqI8pyQCwU8ygqzwB5
	3VodkxOSwDtquucNG/2zR1AjV1/LvcNd28Wkrw3gDrGQGW1qBoQpbUvMwKe6eXLBQHrav1
	2sOyj+Fw3Ajr/qSzNhKfL047Moq0HKw7Es4f4gR5RCe3qZrpfllNWkikQRVGKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOunnIquxWgf4BeX8X/EoXgldMQcaEqD0fnsHYEc0D8=;
	b=H2tvAMtO/QBzlOtyuntaJ3PXQ402YzyX9pXIEYQSLz323VDNaUtB4gjAAEC/XtSq4aMl5a
	AP1cAYjAdq7sviAw==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] rcu: Mark emergency sections in rcu stalls
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-35-john.ogness@linutronix.de>
References: <20240820063001.36405-35-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286848.2215.7170833106070361301.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     8c03273a509c88b12c53a9ddf07702f83983e4de
Gitweb:        https://git.kernel.org/tip/8c03273a509c88b12c53a9ddf07702f83983e4de
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:36:00 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 15:03:04 +02:00

rcu: Mark emergency sections in rcu stalls

Mark emergency sections wherever multiple lines of
rcu stall information are generated. In an emergency
section, every printk() call will attempt to directly
flush to the consoles using the EMERGENCY priority.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20240820063001.36405-35-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/rcu/tree_exp.h   |  7 +++++++
 kernel/rcu/tree_stall.h |  9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 4acd29d..f6b35a0 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -7,6 +7,7 @@
  * Authors: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
+#include <linux/console.h>
 #include <linux/lockdep.h>
 
 static void rcu_exp_handler(void *unused);
@@ -590,6 +591,9 @@ static void synchronize_rcu_expedited_wait(void)
 			return;
 		if (rcu_stall_is_suppressed())
 			continue;
+
+		nbcon_cpu_emergency_enter();
+
 		j = jiffies;
 		rcu_stall_notifier_call_chain(RCU_STALL_NOTIFY_EXP, (void *)(j - jiffies_start));
 		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
@@ -643,6 +647,9 @@ static void synchronize_rcu_expedited_wait(void)
 			rcu_exp_print_detail_task_stall_rnp(rnp);
 		}
 		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
+
+		nbcon_cpu_emergency_exit();
+
 		panic_on_rcu_stall();
 	}
 }
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 4b0e9d7..b3a6943 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -7,6 +7,7 @@
  * Author: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
+#include <linux/console.h>
 #include <linux/kvm_para.h>
 #include <linux/rcu_notifier.h>
 
@@ -605,6 +606,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	if (rcu_stall_is_suppressed())
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	/*
 	 * OK, time to rat on our buddy...
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
@@ -657,6 +660,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
+	nbcon_cpu_emergency_exit();
+
 	panic_on_rcu_stall();
 
 	rcu_force_quiescent_state();  /* Kick them all. */
@@ -677,6 +682,8 @@ static void print_cpu_stall(unsigned long gps)
 	if (rcu_stall_is_suppressed())
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	/*
 	 * OK, time to rat on ourselves...
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
@@ -706,6 +713,8 @@ static void print_cpu_stall(unsigned long gps)
 			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
+	nbcon_cpu_emergency_exit();
+
 	panic_on_rcu_stall();
 
 	/*

