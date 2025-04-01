Return-Path: <linux-tip-commits+bounces-4607-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 132D2A7752E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 09:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2960168BC4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 07:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9781E5B72;
	Tue,  1 Apr 2025 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bfb6oyzn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CUTVEpUJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420921E2606;
	Tue,  1 Apr 2025 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743492389; cv=none; b=lC28cImsjNsSIdrMZ224isCwAtlz99nWcvZGCZnxY4Y6cRHnnBXeG248fhIXGKVcNZldQFc8yJ3X5O4FB4db1rZjhEblVlwqj+jCjOTVMJmyKt5a3+pv49TmBCViObEyshY4B/iblAu1hm7NluRE3DtPRR5rbhXE2+IDp1nlVf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743492389; c=relaxed/simple;
	bh=m0gzkraztbFb0l8OHdYTlzvXmpUdfOYmyLF6tVGoZhU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f4NgwUj1iRdJKh5VI6Ff4i+RSw18GQp3/DwaIEKxnSlBf2WmMniDyuV7SLiTVIbTuVvfJd4ClBmoTcEXWAglcOBhn9EU4M1/td6dJPIr4ujK5vHoV0L9LUdu4VADq2r7khXfF+aepN7w4UWfcVhsWL75ovqpD0/xng4DYzgJO+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bfb6oyzn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CUTVEpUJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 07:26:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743492386;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9iMNr9RP9gXkgUe4AKnyW/x5iC28ohrP27CspkD+LCY=;
	b=Bfb6oyzneWXYCftyuJY7j4fpg1dIELs5mvPPZDAItKvqVhX+R4NlhwyIzqQa9H9ajnOxE5
	r84LtTzrUC4VrJNkQv6Iie0EGFcXqhEJZ4Eb1bgGeommSosKI1J40JLvi9Ak0C5Pob5Fmj
	0MDVFqAA9M0xoWoRME2gAaHJzBUe60er49JMya9r8UDZmYYWUIateOgQpb3C5/tVCpqYYf
	cia6X8lcmEyBXBFfs5k+NhR+2HBgTqYt6dA7JaKzoY2GjnJwBPhR3gjuSaPblrZ1fqgkkM
	ZOV+ENlf4Si/ZscOyBExs0i7C4M2ao+h8WjYANNYmfZsxKWx0jmNboUmOd0Waw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743492386;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9iMNr9RP9gXkgUe4AKnyW/x5iC28ohrP27CspkD+LCY=;
	b=CUTVEpUJQTWiPoD6WGLOfmAFTjwRnzoMr25PiNVruhFT0kDqG495eaFfTd+FLgbTQPpbED
	AlAvUkqEGU684QBA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] rcu-tasks: Always inline rcu_irq_work_resched()
Cc: Randy Dunlap <rdunlap@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <e84f15f013c07e4c410d972e75620c53b62c1b3e.1743481539.git.jpoimboe@kernel.org>
References:
 <e84f15f013c07e4c410d972e75620c53b62c1b3e.1743481539.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174349238441.14745.9346726989479333425.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     6309a5c43b0dc629851f25b2e5ef8beff61d08e5
Gitweb:        https://git.kernel.org/tip/6309a5c43b0dc629851f25b2e5ef8beff61d08e5
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 31 Mar 2025 21:26:46 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 09:12:17 +02:00

rcu-tasks: Always inline rcu_irq_work_resched()

Thanks to CONFIG_DEBUG_SECTION_MISMATCH, empty functions can be
generated out of line.  rcu_irq_work_resched() can be called from
noinstr code, so make sure it's always inlined.

Fixes: 564506495ca9 ("rcu/context-tracking: Move deferred nocb resched to context tracking")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/e84f15f013c07e4c410d972e75620c53b62c1b3e.1743481539.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/d1eca076-fdde-484a-b33e-70e0d167c36d@infradead.org
---
 include/linux/rcupdate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index f8159f8..120536f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -132,7 +132,7 @@ static inline void rcu_sysrq_end(void) { }
 #if defined(CONFIG_NO_HZ_FULL) && (!defined(CONFIG_GENERIC_ENTRY) || !defined(CONFIG_KVM_XFER_TO_GUEST_WORK))
 void rcu_irq_work_resched(void);
 #else
-static inline void rcu_irq_work_resched(void) { }
+static __always_inline void rcu_irq_work_resched(void) { }
 #endif
 
 #ifdef CONFIG_RCU_NOCB_CPU

