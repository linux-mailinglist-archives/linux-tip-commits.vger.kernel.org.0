Return-Path: <linux-tip-commits+bounces-5369-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F837AADAB7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F169A15EA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFED5230BC6;
	Wed,  7 May 2025 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="27qnk8Bl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BER8zzrd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E141148832;
	Wed,  7 May 2025 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608842; cv=none; b=T+ES+BX3G7FRRUPb+XQ1rOvWSvFHegkgzCAmbpwKE62J0+sKlSvFVJHs+3w0AwVHKcLoqv3pMeGKfcxdLJ1m0zpr2GZWRPFeA6pwYD55DZJ7qOp82Y7qLfpr4/EPBpso8ncwZeuYyqKAHZFoRJSgZlsj+Mhz08RJXa5NVBkUTg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608842; c=relaxed/simple;
	bh=/2JGXCg2iXnM4IwdNWOVz0dAcm8hk2gvn5PV0dLs/zE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P2jnkV8AxqogQgFOSALk8/WaAUVJVzgmT/5WZ2aIGYgFHQmxpGnveZG5EyWm1n6g4/2kus0b8Go9E6ddk0Q523Z2Fkyjgn+9ilBPYYK50cHf0RMqcS5OkC6GxdEXhY3hGA3qQoy9Se+mEuFK+NZFJ/v81YGMgpKaFCXJ/BZ7iDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=27qnk8Bl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BER8zzrd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tancZG+ppQnGwiLpkvbOVs0/l7HyydebuKkEu8nPHac=;
	b=27qnk8BlHtlwLzTYUDC9ftQh8eh8ulTgr3WBWNzGcEwVsKtbK3AFm08g2CG3Yn2xcGsFdo
	EYrRpkUm+xm4tyb1fVl/szidqRuC3gUaL+YQt4ZYhG1OcDvfZTDgLGaggLpLqx3CdYCmbX
	nXGWXlzryk5RUjiKpP2oDd46HCdL2sLMgJWOmtn0oxJ3SSCkCvdD5KVMkdaE6/YNN24SUb
	ds4jKdoebw23q+aZb3cHFoGA9x0vPzDxDQWIhr6epE5YCfTd7NN1Dooo0ue7+5UXBevIvo
	IyqDzgQr3Tex32KYsEdBZZ1cr8J6lmp+QjUsP5NBm+SB19u207YG6UahzfzR+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tancZG+ppQnGwiLpkvbOVs0/l7HyydebuKkEu8nPHac=;
	b=BER8zzrdmlcartqzdkd987UyZMcSkcyisAN6Q+dM0I50NY9Uzc6ylf5xOd0Cv+kiyF2Ww5
	HLp2pcMHBCK6rZDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove irq_[get|put]_desc*()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065422.729586582@linutronix.de>
References: <20250429065422.729586582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660883834.406.9096907142350031159.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     104361217c2a2ab7d6a9de756952814af0a8a5ad
Gitweb:        https://git.kernel.org/tip/104361217c2a2ab7d6a9de756952814af0a8a5ad
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:17 +02:00

genirq: Remove irq_[get|put]_desc*()

All users are converted to the guards. Remove the helpers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065422.729586582@linutronix.de


---
 kernel/irq/internals.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 44d3a67..bd2db6e 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -191,30 +191,6 @@ static inline class_irqdesc_lock_t class_irqdesc_lock_constructor(unsigned int i
 
 #define scoped_irqdesc		((struct irq_desc *)(__guard_ptr(irqdesc_lock)(&scope)))
 
-static inline struct irq_desc *
-irq_get_desc_buslock(unsigned int irq, unsigned long *flags, unsigned int check)
-{
-	return __irq_get_desc_lock(irq, flags, true, check);
-}
-
-static inline void
-irq_put_desc_busunlock(struct irq_desc *desc, unsigned long flags)
-{
-	__irq_put_desc_unlock(desc, flags, true);
-}
-
-static inline struct irq_desc *
-irq_get_desc_lock(unsigned int irq, unsigned long *flags, unsigned int check)
-{
-	return __irq_get_desc_lock(irq, flags, false, check);
-}
-
-static inline void
-irq_put_desc_unlock(struct irq_desc *desc, unsigned long flags)
-{
-	__irq_put_desc_unlock(desc, flags, false);
-}
-
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
 
 static inline unsigned int irqd_get(struct irq_data *d)

