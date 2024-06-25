Return-Path: <linux-tip-commits+bounces-1534-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA30591652C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 12:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9471F1F21163
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 10:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256EB14A4F9;
	Tue, 25 Jun 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v1oo70p7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TaE1pnkO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2214A4C7;
	Tue, 25 Jun 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310833; cv=none; b=b1A052BIRnvaJU/hjx59dt47nYHeqDqXer37bM1J+/6X3BIpjs1+tEs5E8LfjgL+FoqyYNVoX+PTCj6knYNSmu0yWk5r8YGadAh8E8EAdAlroqamLYZwfPr/Xz8g3T5De2g6Sgv41b69K/B9cXTE5Nq8CiAALhiVB2V80MKKkWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310833; c=relaxed/simple;
	bh=U4UKmSL+yS6H3laaPMwSWiFQQcV7Z7beDMbwiaN27C8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EV4XfFSaNsiqVOWyn5xE8XDS74Q7yXNrSr5UZh3kD3zWxoF++LEeUCxMG8xfjfvl0bxMwc7tyn2O9chb1FLswgXeUxxE7o25bmtWKG7R7KMQTbOVWd91N41+Bcm5jquRRpnGgI60dhe10Q4I8l7jlqMSaFzu/63PJsvRlOujRLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v1oo70p7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TaE1pnkO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Jun 2024 10:20:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719310828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2uSvmOwiL69UqeLQmZ71n4aVeb3D8wrFq0BB119oCQ=;
	b=v1oo70p79LGHJNJl2whku34B0Bj+IFzzK33G/4fhUYjJ9KDpS+BPqoq7/w7bdVTArsaueq
	8h8Jpsxz8mWxVTz6pF11VXFJogiXTNkDgFmV3W1b1N2CNyGgVDZAvtZWPskqMyK/3UpbgK
	z/xLrnY5f9W0O5jg1jHS//La8ETy/1ZCLYVazzVE1jbApFb0oXys4qksGTULJ6/f0xW6/c
	gbdoKTSNh0Bh3/BXULyAz3W08Ju62DWTIr9GZKRaWUcShaWwoXblFVa3W/S+e8L178jMYA
	goRJXXK6wxD4MDsMPdH8NXFDKUz1+ReuU42mkpK42JqT8fCxPdkI8WlRJxVKOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719310828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2uSvmOwiL69UqeLQmZ71n4aVeb3D8wrFq0BB119oCQ=;
	b=TaE1pnkObbnlss4mEYvpHPS0FKSP/hiJC+eeCq/l8ddVLPAjS66mVQFoCw26Kr9FTeg+6a
	pY9SM200aav84YDQ==
From: "tip-bot2 for Brian Johannesmeyer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/kmsan: Fix hook for unaligned accesses
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Alexander Potapenko <glider@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240523215029.4160518-1-bjohannesmeyer@gmail.com>
References: <20240523215029.4160518-1-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171931082781.2215.2814033580551774313.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     bf6ab33d8487f5e2a0998ce75286eae65bb0a6d6
Gitweb:        https://git.kernel.org/tip/bf6ab33d8487f5e2a0998ce75286eae65bb0a6d6
Author:        Brian Johannesmeyer <bjohannesmeyer@gmail.com>
AuthorDate:    Thu, 23 May 2024 23:50:29 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 25 Jun 2024 11:37:21 +02:00

x86/kmsan: Fix hook for unaligned accesses

When called with a 'from' that is not 4-byte-aligned, string_memcpy_fromio()
calls the movs() macro to copy the first few bytes, so that 'from' becomes
4-byte-aligned before calling rep_movs(). This movs() macro modifies 'to', and
the subsequent line modifies 'n'.

As a result, on unaligned accesses, kmsan_unpoison_memory() uses the updated
(aligned) values of 'to' and 'n'. Hence, it does not unpoison the entire
region.

Save the original values of 'to' and 'n', and pass those to
kmsan_unpoison_memory(), so that the entire region is unpoisoned.

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Alexander Potapenko <glider@google.com>
Link: https://lore.kernel.org/r/20240523215029.4160518-1-bjohannesmeyer@gmail.com
---
 arch/x86/lib/iomem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/iomem.c b/arch/x86/lib/iomem.c
index e0411a3..5eecb45 100644
--- a/arch/x86/lib/iomem.c
+++ b/arch/x86/lib/iomem.c
@@ -25,6 +25,9 @@ static __always_inline void rep_movs(void *to, const void *from, size_t n)
 
 static void string_memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
 {
+	const void *orig_to = to;
+	const size_t orig_n = n;
+
 	if (unlikely(!n))
 		return;
 
@@ -39,7 +42,7 @@ static void string_memcpy_fromio(void *to, const volatile void __iomem *from, si
 	}
 	rep_movs(to, (const void *)from, n);
 	/* KMSAN must treat values read from devices as initialized. */
-	kmsan_unpoison_memory(to, n);
+	kmsan_unpoison_memory(orig_to, orig_n);
 }
 
 static void string_memcpy_toio(volatile void __iomem *to, const void *from, size_t n)

