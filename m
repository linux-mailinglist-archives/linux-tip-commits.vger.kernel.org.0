Return-Path: <linux-tip-commits+bounces-2268-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8722C9720F4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28F81C23B86
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B49B18E374;
	Mon,  9 Sep 2024 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RTWnDtmh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I4T4gaW4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291F718E02F;
	Mon,  9 Sep 2024 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902884; cv=none; b=EHLktguibw00IfqxlNm7F+NmHRDyjoseMp1O6lHYMWVhhFb2uUvX8DPwHaER0UBgSbtqlowf2xD1qL/4iF5j0JaFiRfmwuDWpJkX8WPfg9OPzZMZBeGeWaySCD3qgdaVjG0Wmj+yPf2HPcuNuEE8IW7J5BbkKdK3B96LDv/L5Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902884; c=relaxed/simple;
	bh=aSAM4YOy+HTnclWr3Fnft6JvmjDRC5i0Oh3rGJe3sUo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OnQ1UOznlfaRuJ1wNAlFlCCmMknORF0bk975K4EgXOYTPRuOkfH4EtGW7UXTtqqM62g0CsqgCG+5+UnUeKMmivUgZdnJ8i0vK8/Qowtb03dGaQoBE/aitrJFrU3+fvoGxRPly2v0SnoTg/R6DoTc3JDDrZuGHfQ/zEjzakpQGmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RTWnDtmh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I4T4gaW4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:28:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902880;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4v3BvG5qrI0wueZV5CJJEru4ls0gBnBXvmnya0hMswY=;
	b=RTWnDtmhnUF9VBImxXeqPnlyo8JCZbtuonTZ6xmfKSj79MCeq7s0lho6RgqwxNcBTfFS4J
	Mm3cmEy+ClUluab8+gjw3aJESQNdKvdBFz9ji24lqEnKIR5AdX/+taRUSXRmx5zlWttKtt
	yySvNAuYdvDUIjwpAJpODBHASpqzbh0OECGI/vgrpkJ0FtW3L7asopq4QxZlJTZPvyhBpm
	elzKyaIhhx2h+MpoVUhd827Hfiuj3HQ7s1ZH0/Fp8GvqsVR2Hjj/sTt05+Kj/vD7WuxZiR
	I866FlaJBhjBfHlBH1SOzMStOrEAhy286QGU0WYQQs8wYKApR2ZEkRttDbftqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902880;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4v3BvG5qrI0wueZV5CJJEru4ls0gBnBXvmnya0hMswY=;
	b=I4T4gaW42JYW9GfyjrHdlsUS4s3j2FYucn5W8Y6MhQ1Hm1yUsNYz5SBbiEB3LCNahfMMxW
	+DQ7zOGTgAcOj/CA==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: Add notation to console_srcu locking
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-2-john.ogness@linutronix.de>
References: <20240820063001.36405-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590288017.2215.17291222253474528955.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     eda25860bf6e71932311f1b5acdf8fc05cd84ff3
Gitweb:        https://git.kernel.org/tip/eda25860bf6e71932311f1b5acdf8fc05cd84ff3
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:27 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:22 +02:00

printk: Add notation to console_srcu locking

kernel/printk/printk.c:284:5: sparse: sparse: context imbalance in
'console_srcu_read_lock' - wrong count at exit
include/linux/srcu.h:301:9: sparse: sparse: context imbalance in
'console_srcu_read_unlock' - unexpected unlock

Fixes: 6c4afa79147e ("printk: Prepare for SRCU console list protection")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20240820063001.36405-2-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c22b070..93c67eb 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -282,6 +282,7 @@ EXPORT_SYMBOL(console_list_unlock);
  * Return: A cookie to pass to console_srcu_read_unlock().
  */
 int console_srcu_read_lock(void)
+	__acquires(&console_srcu)
 {
 	return srcu_read_lock_nmisafe(&console_srcu);
 }
@@ -295,6 +296,7 @@ EXPORT_SYMBOL(console_srcu_read_lock);
  * Counterpart to console_srcu_read_lock()
  */
 void console_srcu_read_unlock(int cookie)
+	__releases(&console_srcu)
 {
 	srcu_read_unlock_nmisafe(&console_srcu, cookie);
 }

