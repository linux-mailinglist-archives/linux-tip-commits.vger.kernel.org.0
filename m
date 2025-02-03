Return-Path: <linux-tip-commits+bounces-3323-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FFAA25A1C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF653164D30
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 12:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD53209F43;
	Mon,  3 Feb 2025 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zux1s2FQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5wvbI0jJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A19205E15;
	Mon,  3 Feb 2025 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738587010; cv=none; b=T7036io3AJgCA3R8SVnREGp+i1pOWqc+tI/U8laXdhNTvFNbJ1QcKHhHCHNilNOzLiK4kXZ1aDam6A84+88oE/w+aM6PV2Opv4ttJX1VuBjKPYX6TSNzKJS1XEgt9+KymbDjkFY58tE3+/2xHJ7J3di0CSKqqKTh7zrVAXW4wwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738587010; c=relaxed/simple;
	bh=X6utmfdWMMjwMJE1wz/xBfcqCs746GeDQCRoKgMcUM8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uy1APobiqR3pqSJ7xWkfuHHws5JixnJKn0VUINqLrnuUCC6euKJMoHqB8RV7UarlbFemNRJciCyni8V7+Dp9pbjuBxsBC7M9gT+RfusGyLy3n4gtr92t2C2RvagAC23SljkNtUa5nIR0BlsaezHU6xYgLumu8MrFbl6SH1WqSP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zux1s2FQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5wvbI0jJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 12:50:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738587006;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ozS1XndEqcJWN8yfxpCC35Ti6MwBJAay8jw8eFkx9wA=;
	b=Zux1s2FQqq8DN7MmlPYsL53mUKPYrJdOwS3KxEtNOzGoUW5pQsRsJZzprOAKRBefr+pJ+D
	UACTVTU6ji4JXiMATPqbhurv0Zk80c4H0QsdB8AjeAdQDK464gfi4s+jS5wC42wA8XMsYN
	jcuTdvem9JpElGcorl5WRpqsMwkpMmNCO0ilEatifBT2tT7EdQ+LiT8OyowM4y3mdKv4cE
	R0I4dwIdgJfFGKsqJ9GKEztERLB7CAaMh7FmnhG+oW70i58jvlaYkjFnBzqmfmuY8QdE/k
	WPVn8pYxdqsp96wtv0LYjHrJoWVOoZfnPwOCqkg7xTPhfMAEjxcd2BjEWcjd5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738587006;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ozS1XndEqcJWN8yfxpCC35Ti6MwBJAay8jw8eFkx9wA=;
	b=5wvbI0jJ6hC1mjrjkjYDtvJ2CRr/aBtQK9JOlZo2nTZsFjdWNLTvG/LFBBVl5SP+uR3nP5
	qA46cG3C3WzDyoDA==
From: "tip-bot2 for Mike Rapoport (Microsoft)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: drop duplicate variable in cpa_flush()
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250126074733.1384926-3-rppt@kernel.org>
References: <20250126074733.1384926-3-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858700637.10177.2674573814444308392.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     4ee788eb0781ba082709c1ac1d5146ebcc40b967
Gitweb:        https://git.kernel.org/tip/4ee788eb0781ba082709c1ac1d5146ebcc40b967
Author:        Mike Rapoport (Microsoft) <rppt@kernel.org>
AuthorDate:    Sun, 26 Jan 2025 09:47:26 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:01 +01:00

x86/mm/pat: drop duplicate variable in cpa_flush()

There is a 'struct cpa_data *data' parameter in cpa_flush() that is
assigned to a local 'struct cpa_data *cpa' variable.

Rename the parameter from 'data' to 'cpa' and drop declaration of the
local 'cpa' variable.

Signed-off-by: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250126074733.1384926-3-rppt@kernel.org
---
 arch/x86/mm/pat/set_memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index ef4514d..1f7698c 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -394,9 +394,8 @@ static void __cpa_flush_tlb(void *data)
 		flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
 }
 
-static void cpa_flush(struct cpa_data *data, int cache)
+static void cpa_flush(struct cpa_data *cpa, int cache)
 {
-	struct cpa_data *cpa = data;
 	unsigned int i;
 
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);

