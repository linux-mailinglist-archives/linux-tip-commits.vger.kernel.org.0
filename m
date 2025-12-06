Return-Path: <linux-tip-commits+bounces-7613-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D49FCAA342
	for <lists+linux-tip-commits@lfdr.de>; Sat, 06 Dec 2025 10:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 011A63183ACC
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Dec 2025 09:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C963F2E0904;
	Sat,  6 Dec 2025 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yny6Ve6r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xZftH6lA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FDE2DECC5;
	Sat,  6 Dec 2025 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765012251; cv=none; b=WKFCxWyGsTe/rkA13XDaUAelTS2nP7+UGn1gYyS1vslgxW0P2ueCqjtMxx58rPnX//rb6kpxgrMUMpv4YAOFO+UwEzz6A+WTgv04v971CDEIcw8pUw/P1YP1xizFdnfttlm47vH53NwJvUhSsGqovsK4qYdM/PDsW0dX8Gb0RlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765012251; c=relaxed/simple;
	bh=/1+SUn8scsqV2DIOxLJnnE0EG5t3+a1uCulmngyduyE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XHICIuaENfNrE8dr5Lfaf+k9sMvp6D5d/O5+RvDYCO/imwTJKtI4lDjYka5QbYno8wlQuTE5Z4uKN8gBzxddlrumbX3q+11+woWG/tRLzxDW9+5/asWa//Qdry2dOi0U9xZiUMHAoXM2gID0OuvBkRCH6y32ecQxJzzn1jJWwBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yny6Ve6r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xZftH6lA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 06 Dec 2025 09:10:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765012247;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5EgijiL/iBrMXT9B7aGmSHQhnyiCqVdCjhXZwjvwCk=;
	b=yny6Ve6r5oMiAJNjCPutmxPQ3WPB4osc4IKZ8otJqYjY6C+0M5H1WKA8GVbQaGgACsRVTe
	MG/T23ETNWs8XDv6sd/v+KjODay0SG3qRzeK/LLw1lS0RCpT39+ZcWapzNVVT7rm5EF2IN
	b1jKdmLTsjy/RDOQ6L4VNfs30Uw9OzX4s1k5Pp5Es8YPepeyPJKLkySZ7Wu+v6mIz8pile
	ltqJ/cjFvFE2AoJ0Y7oHPw2YBqCZZ9o0sm79yZloYOfIiT/VLXjuyCAVBsHzUJ25vK5SbE
	kUknZ+S5g832+ojN8kjqts5QB0RQmYLHWdqOQgAUEs+FXAo7JZ+kNOdJkJnv6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765012247;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5EgijiL/iBrMXT9B7aGmSHQhnyiCqVdCjhXZwjvwCk=;
	b=xZftH6lAPF0NlLXyy7JrHVS44wYrr3CN03hz+wSa62+0w9DqFFQ5lmVttFEMvNUHFGsIM0
	w+QmK7rFVqPQRTAQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/headers: Remove whitespace noise from
 kernel/sched/sched.h
Cc:
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <176478595428.498.13816176784792752599.tip-bot2@tip-bot2>
References: <176478595428.498.13816176784792752599.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176501224596.498.18028339805260548825.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     dde3763365d80398d1465214458d0c38cc32de9c
Gitweb:        https://git.kernel.org/tip/dde3763365d80398d1465214458d0c38cc3=
2de9c
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 03 Dec 2025 18:19:14=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Dec 2025 10:03:13 +01:00

sched/headers: Remove whitespace noise from kernel/sched/sched.h

A single case of space-Tab noise snuck in recently.

Fixes: 36569780b0d6 ("sched: Change nr_uninterruptible type to unsigned long")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/176478595428.498.13816176784792752599.tip-bot2=
@tip-bot2
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8590113..cb80666 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1165,7 +1165,7 @@ struct rq {
 	 * one CPU and if it got migrated afterwards it may decrease
 	 * it on another CPU. Always updated under the runqueue lock:
 	 */
-	unsigned long 		nr_uninterruptible;
+	unsigned long		nr_uninterruptible;
=20
 #ifdef CONFIG_SCHED_PROXY_EXEC
 	struct task_struct __rcu	*donor;  /* Scheduling context */

