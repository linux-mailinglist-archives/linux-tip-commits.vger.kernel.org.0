Return-Path: <linux-tip-commits+bounces-3858-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0592AA4D6E9
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA0F165BC1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 08:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2111F5853;
	Tue,  4 Mar 2025 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sC0FcztD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TNXQhhpb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C4718A6A9;
	Tue,  4 Mar 2025 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078015; cv=none; b=SIiYM0Z0VeUjAwHKpH+cjch8Lxhz6CU8/rFcPRnCxsx3YKIV8InHviQ6WkYBHrvy+KQJ6L8y4QkV55OvgkTJ51FSFMj/67v4XX/8rciVcng7q/aKUf6/+AS1T1YQwvgJH88ZghSliao0HPLM6ud5YAZhO7x0qdB2Cvx19hHk2jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078015; c=relaxed/simple;
	bh=ZwO27svF1RShsSUhC5wH3ukEpAbEurbNsY6GO0dgfsI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DXO9mghOIWzic5sFm9QfPUKZheTjUWgdfD5WlnlFnS/nW8EeEhtPRsapfhJSD/PLaGdobxhtUZqFv8qwKatmUo3qWykGxcyOeN59s5njh62m/uXukJDmHEVQYUz4wDyTigxo6Mmiujx0U9U+v2KLTVbykeJOOemubFSCvVqLnP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sC0FcztD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TNXQhhpb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:46:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078012;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6yNIkAFRt0FfGZbt5/GPn8n/W/hipKsdNZPPTsCILc=;
	b=sC0FcztDwIkyoOeWDJilpuEgnlPfW1SetDk2HrhIAAfiOk1pFcoQfaGbqC8wTQaMvzQBqv
	FTuamhKIc4KBscMGMgIxYVuV0fVTSPQFzhuUdMtguzRxTLg8IM80pBk8YdkCdU72jWKX52
	XRUQbKl3BRlilIkg0f2S1BKijbbKbt2irAC4TCFsfVpVcTKXOqS95wkEJHYCEwZ+caCQqH
	dTSLLoO3fXxcJNaUZhbgOTBMAF0SNvhbR346uIkHDFBpUMFGeLrwW102uhFDt/uBEYb6X+
	dEptZHfSRefrjbo3KLlNamtJICf2EgIh7ji8K1EtsK6s+OE3Gde9asAMLyr2tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078012;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6yNIkAFRt0FfGZbt5/GPn8n/W/hipKsdNZPPTsCILc=;
	b=TNXQhhpbg7y4eBuJGi9Isp7ejI1opzCfmQS1NyI7umAZGlT83YLdt0cb6ETR7BnfhiVCE+
	XxrOW0+GSConX4DA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix perf_mmap() failure path
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135519.248358497@infradead.org>
References: <20241104135519.248358497@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107801111.14745.4214008629412841178.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bfd33e88addda078a089657044945858a33c435e
Gitweb:        https://git.kernel.org/tip/bfd33e88addda078a089657044945858a33c435e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 09:39:04 +01:00

perf/core: Fix perf_mmap() failure path

When f_ops->mmap() returns failure, m_ops->close() is *not* called.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://lore.kernel.org/r/20241104135519.248358497@infradead.org
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8b2a8c3..b2334d2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6903,7 +6903,7 @@ aux_unlock:
 	if (!ret)
 		ret = map_range(rb, vma);
 
-	if (event->pmu->event_mapped)
+	if (!ret && event->pmu->event_mapped)
 		event->pmu->event_mapped(event, vma->vm_mm);
 
 	return ret;

