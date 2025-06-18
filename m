Return-Path: <linux-tip-commits+bounces-5863-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528D0ADEB6E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Jun 2025 14:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87D8168DE6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Jun 2025 12:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5582BF01F;
	Wed, 18 Jun 2025 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lxbRM+EK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dqq4Bkcx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ABE27F01C;
	Wed, 18 Jun 2025 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248576; cv=none; b=cEkP+rX7MQAJa7qXB6Uy8CuUvJTtNjUljmDZ+zFRv8XeVgPzqVH0wMGL4r0rPD6exPNMSWxw86uzuRoqTggQCdsNWBYoLq9MYhdvxT58FEO202/kDjSJFKtUfBEjcTgdbjfqD1bi6yAes+N2uyVhyRZqWj8Lk4/GATrQ5swJCa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248576; c=relaxed/simple;
	bh=4YtwtGrx4aQCtrMsMKf0ElnO6wKaWfloCC4JdjDwj04=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oZz4wEi5JrGpkRo/Hj277YOs50hXU+JVvOfIfuiwwBbH8IxuMCLE0yQ9hpKMLJX8Rqtxa+tBP2PNHi1agOesfvLHnwDbYT6FceXf9lG9tL4pmMWw9HVHlumIAK3e7ZhpSpLzn+Txj93wA9dv7n6n/uLlAcvmuiHrvMfdACWV0Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lxbRM+EK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dqq4Bkcx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Jun 2025 12:09:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750248570;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9hRMefuh2yk2fVV25Hs5r4wXJc+OrGZWC+kgojVLKs=;
	b=lxbRM+EKSNQij72uwrYP4AIDEKd99WxLEgESabNKCiVhYiaVxmTgo2M9L5SOfTqkuucKNW
	53rnJ4mZ6zhCeRhwxgmDLLX8ojTjVy7VvBHHXpc18drvmit0Uz+CXA3caHkiM47wkIZtA6
	TSqUqVl9316FUCOc/1XAANPLRpjA0Nvkz7WL7weSDZYBZgyP/uSxJ1hKeVsTpCdGK/5L3S
	TWuZPvlEkjBsfFU+Vq4Nhx5wdFAJk7g68XVH/EhQ82cqnlfJvm9dc4D+K2MdXlDY82fuym
	mFyrTek+bB1kFf085owZfhecDuhLssKOJTJdExScz1uxcrfl3XueUrC3oXMRGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750248570;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9hRMefuh2yk2fVV25Hs5r4wXJc+OrGZWC+kgojVLKs=;
	b=dqq4BkcxQ5E9E1Ubb2uYKGU9arteH4OYNb/zbsE112kRpBteiEvQHe83NcmJBnyuuGrJ5i
	AveB/BCxOHaz93Bw==
From: "tip-bot2 for Masami Hiramatsu (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/alternatives: Fix int3 handling failure from
 broken text_poke array
Cc: Linux Kernel Functional Testing <lkft@linaro.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <\
 175020512308.3582717.13631440385506146631.stgit@mhiramat.tok.corp.google.com>
References: <\
 175020512308.3582717.13631440385506146631.stgit@mhiramat.tok.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175024856942.406.9775952372064270732.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2aebf5ee43bf0ed225a09a30cf515d9f2813b759
Gitweb:        https://git.kernel.org/tip/2aebf5ee43bf0ed225a09a30cf515d9f2813b759
Author:        Masami Hiramatsu (Google) <mhiramat@kernel.org>
AuthorDate:    Wed, 18 Jun 2025 09:05:23 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 18 Jun 2025 13:59:56 +02:00

x86/alternatives: Fix int3 handling failure from broken text_poke array

Since smp_text_poke_single() does not expect there is another
text_poke request is queued, it can make text_poke_array not
sorted or cause a buffer overflow on the text_poke_array.vec[].
This will cause an Oops in int3 because of bsearch failing;

   CPU 0                        CPU 1                      CPU 2
   -----                        -----                      -----

 smp_text_poke_batch_add()

			    smp_text_poke_single() <<-- Adds out of order

							<int3>
                                                	[Fails o find address
                                                        in text_poke_array ]
                                                        OOPS!

Or unhandled page fault because of a buffer overflow;

   CPU 0                        CPU 1
   -----                        -----

 smp_text_poke_batch_add() <<+
 ...                         |
 smp_text_poke_batch_add() <<-- Adds TEXT_POKE_ARRAY_MAX times.

			     smp_text_poke_single() {
			     	__smp_text_poke_batch_add() <<-- Adds entry at
								TEXT_POKE_ARRAY_MAX + 1

                		smp_text_poke_batch_finish()
                        	  [Unhandled page fault because
				   text_poke_array.nr_entries is
				   overwritten]
				   BUG!
			     }

Use smp_text_poke_batch_add() instead of __smp_text_poke_batch_add()
so that it correctly flush the queue if needed.

Closes: https://lore.kernel.org/all/CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com/
Fixes: c8976ade0c1b ("x86/alternatives: Simplify smp_text_poke_single() by using tp_vec and existing APIs")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Link: https://lkml.kernel.org/r/\ 175020512308.3582717.13631440385506146631.stgit@mhiramat.tok.corp.google.com
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9ae80fa..ea1d984 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -3138,6 +3138,6 @@ void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, c
  */
 void __ref smp_text_poke_single(void *addr, const void *opcode, size_t len, const void *emulate)
 {
-	__smp_text_poke_batch_add(addr, opcode, len, emulate);
+	smp_text_poke_batch_add(addr, opcode, len, emulate);
 	smp_text_poke_batch_finish();
 }

