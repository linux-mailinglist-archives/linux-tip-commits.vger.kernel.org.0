Return-Path: <linux-tip-commits+bounces-5405-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8942AADB03
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D6750465E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD7524C069;
	Wed,  7 May 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iSrgzk+k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5Kd7fd0V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FC92459C8;
	Wed,  7 May 2025 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608867; cv=none; b=RINxDmDPOI1JUQLua+GKVx9TFpC1Hzy110c4jn2JVP4tWioij3XpyARNW4fBBlhDS5uEgUGtqYQ5G95nJUUSdLlf7FYwghKv7zyMNbVxtvU2vmZGesPdwvkECk2RbXed7IMhUzKTbpxbWz2HbBqoxgvY0dZ1glsQIOy0WPNes3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608867; c=relaxed/simple;
	bh=DQtvgm4dA3sOg7dLTJADOPJvNS+uEnWKnTXUhlSu3X4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VXl+seinolXdrl8G5WqeTxi0e3QkgvhnxDTSjZPKt/DYdsmHzh0gUpO0hcS9Q8pxvZ+RkkBL75m6Sg82JARh1w34q03FihSwRoxZ2VQva3zrm3khKjGlJsqyzzhOZnNkw5HqYQ5XWYLUNcyiUec+VM/jjUYV9I4YfEx/Lrr7+X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iSrgzk+k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5Kd7fd0V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7jUHZd/Q+IUM3LrnGjrtiY+aQVbRlKr4Z5ipvn06T58=;
	b=iSrgzk+kEP57oVZyyBTaFZg0VzXeZIQV8dOD0W4GUZFj2ONrNKjlLCXec3/1ddUWNszRoo
	z5KSQtMmRLOraT+COQjHNuOrDLEGrOAMVUXWxcj/dEprXe7zByuIk+7rmKsyBq9+GOQEGd
	NaRKaGOHZh5KZSe1sZ2cnHlyP3UXUcPtHuUcM9hDJ2bjtBh+egK38YdeGw+M4qNJKkA3pH
	7wdKwK5heZKAd9luqn7af818fCL5vXD/OzjJ9d5KZCvAJZ3SQ8ZMnBGSW943kZRq5x2sgJ
	T+d5/ZDW5uhwmoWrrsNhptW7RTDNITVkrxloX9Qui2l/AJMk5bOaTHehJiBBIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7jUHZd/Q+IUM3LrnGjrtiY+aQVbRlKr4Z5ipvn06T58=;
	b=5Kd7fd0VVMo8dVn/9ZCYB9z6P6prPbdaoGu1zOmELiA/aldrt4opZ3WXNZ5CugLKscguYD
	N9hFUTlHtTlmCEAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/cpuhotplug: Convert to lock guards
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065420.560083665@linutronix.de>
References: <20250429065420.560083665@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660886305.406.10409714575311817343.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     88a4df117ad66100d0f870aa02032dfb9cb29179
Gitweb:        https://git.kernel.org/tip/88a4df117ad66100d0f870aa02032dfb9cb29179
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:12 +02:00

genirq/cpuhotplug: Convert to lock guards

Convert all lock/unlock pairs to guards and tidy up the code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065420.560083665@linutronix.de


---
 kernel/irq/cpuhotplug.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 15a7654..7bd4c2a 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -177,9 +177,8 @@ void irq_migrate_all_off_this_cpu(void)
 		bool affinity_broken;
 
 		desc = irq_to_desc(irq);
-		raw_spin_lock(&desc->lock);
-		affinity_broken = migrate_one_irq(desc);
-		raw_spin_unlock(&desc->lock);
+		scoped_guard(raw_spinlock, &desc->lock)
+			affinity_broken = migrate_one_irq(desc);
 
 		if (affinity_broken) {
 			pr_debug_ratelimited("IRQ %u: no longer affine to CPU%u\n",
@@ -244,9 +243,8 @@ int irq_affinity_online_cpu(unsigned int cpu)
 	irq_lock_sparse();
 	for_each_active_irq(irq) {
 		desc = irq_to_desc(irq);
-		raw_spin_lock_irq(&desc->lock);
-		irq_restore_affinity_of_irq(desc, cpu);
-		raw_spin_unlock_irq(&desc->lock);
+		scoped_guard(raw_spinlock, &desc->lock)
+			irq_restore_affinity_of_irq(desc, cpu);
 	}
 	irq_unlock_sparse();
 

