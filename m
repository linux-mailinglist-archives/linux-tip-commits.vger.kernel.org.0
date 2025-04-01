Return-Path: <linux-tip-commits+bounces-4597-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD3DA774F5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 09:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01C83A7C26
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 07:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB87E1D63C0;
	Tue,  1 Apr 2025 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="awpjpW/U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rd26zC04"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428B83C6BA;
	Tue,  1 Apr 2025 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743491719; cv=none; b=Og2irJnjJeFeA8t6oZSDupBBKNnCg8FMeq/AKZPdeLRSxAkmQjJEOdjWAm4bQINehvb1nPhM2uhmkMwIGoqD3itipPbXMIBHK+ZzhLMIhAZ97y98aRvNgCtnb4jVDYoqRncF6FekMfuh6v/FkrODK6bNU0LW4XOYeHa4Y0SZB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743491719; c=relaxed/simple;
	bh=ASqZrEhmyQYBJLw3mbRJGyndrO09fkzvpgX99F0rdK0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JEIJyMaaeNoDsU6LBgSo9F2spK2XzQb4mZxICNoEdIZK14oc4Krtl1j+E/YYhusn0yuxThJ2AbetWl/PlL/Hu40v4w3/Y03iM6jfYgCXmw6sqLryXzthCbKlY43QTTzLromVV13UEgjtNmUqEbcLZdadHBiYRl/MeO/KF58a950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=awpjpW/U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rd26zC04; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 07:14:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743491716;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJ3ohgp8Hd2OPzNgQkKZW77hDJizmmMN1f2Bm68eUf4=;
	b=awpjpW/Ukj4mGfv1gdJVZlOD9FXSk496nqpKJcLQ9nVF8EdMtRtNKrQq6yiq5pIInQgv8n
	kGbii5qaDlDv0zDwlSb1ujIH/UcPL+daKf3e8ddHwsjOrRUqlwx3azUAdO7znFoKBIOOpc
	eMxuAo5HAJFixvLghX3xvfo69Ai3B49ZNr44SwRWKxK6ViX8fUf+XDv+xKOQDXj03t3Yr8
	c4Q5plhH0uVapjUFQmvb816rcGYd8QomjUid63IWnvVk1WApkRFqcPihkgmWBsuzmZqr3T
	rIOGZRXpJKtWkkDvXqc/p/lvvj376byLx5N8qzw8vO+mjD3l0m9RZUUyh1/Tjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743491716;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJ3ohgp8Hd2OPzNgQkKZW77hDJizmmMN1f2Bm68eUf4=;
	b=Rd26zC04YoekIDTguMzdd5hrvsyOXH8kl/qmbqqakBwwvNVL/BF010QdhaIYDL/DAeZrmc
	fhbCuYpskZKt49Cw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] rcu-tasks: Always inline rcu_irq_work_resched()
Cc: Randy Dunlap <rdunlap@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <174349168923.14745.14986706790553425929.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     f117dc45092f45e4620de4b928ce02591077ab66
Gitweb:        https://git.kernel.org/tip/f117dc45092f45e4620de4b928ce02591077ab66
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 31 Mar 2025 21:26:46 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 09:07:14 +02:00

rcu-tasks: Always inline rcu_irq_work_resched()

Thanks to CONFIG_DEBUG_SECTION_MISMATCH, empty functions can be
generated out of line.  rcu_irq_work_resched() can be called from
noinstr code, so make sure it's always inlined.

Fixes: 564506495ca9 ("rcu/context-tracking: Move deferred nocb resched to context tracking")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

