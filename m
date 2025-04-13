Return-Path: <linux-tip-commits+bounces-4948-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6AA8737E
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 21:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69F73B5BE8
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 19:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A11033993;
	Sun, 13 Apr 2025 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NZBan11J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gebvaPU4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC6EEBB;
	Sun, 13 Apr 2025 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744571759; cv=none; b=EcPx+t98pX+fi1WMpH/JdHytLSklLqqz33wDCJzlFv/yzufZb6gBdZk4KaCgPSCF7sQvvvfczAtJt0eJ1A8zHCX5nrwTRmP9L+2JHZoIlB29eO6bm1gzUq/TLMfZPNvqeXUGB4BlOjLj3/kB7zzWygkdwbO0lzdlClF8+Sj1QhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744571759; c=relaxed/simple;
	bh=874sJx7dildgIqgEl7Uso2cFBptZ1GFkl3SGFZ0+Zrw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ASMpr/Q92BVlY0+jt/A3Rd7e/HONCivRls4AUAS06HCNPB36Bfyb2xx0o/4vK2tCeD/LY3U+5cVtZLC0InQh6rTLG4ivXRO5ZmAr8jAFtGErxUVjv+U+kr52UqSv+e5hW6dM5aMx+yFlJHESheVuT3JfN4rVLzayOO69XyhW6FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NZBan11J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gebvaPU4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 19:15:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744571754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svoHC3sZPS91BuIJ2nCOq2diPn+s+JbSp4K0OZ41vyU=;
	b=NZBan11JVBQJ4ZCGuIxw2guMr5eOwB880oaNpWHihetrdUo9sJmdOCiEzQjfWAGlqdjOgm
	owqlhUw+OBb0OBxI0seNVjx/FdEyOvdzb2LOgvlq23uctj0DJcLhx0BACJFXVEM0eNgrPO
	Zhz2uSdku94VDXnV/Lidn3vdGJhmmoSt+pHaFicjqJrP/N9aeup1uKr/m/SSmYxNevcjlQ
	/1chfADiNrVifG1PydajbG9z7PxzvNbnC1RxmydyBEln12xmx7DLdhuP0MTpmuhrGYcBLz
	MM+b+hYyyyIof+hcyWrBYdEaPpVYCZaPOt3b+my0GkHXRI4AEVkvqTs3DCuz8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744571754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svoHC3sZPS91BuIJ2nCOq2diPn+s+JbSp4K0OZ41vyU=;
	b=gebvaPU4eCtDu/HGO2l6ntlmgK64WlFnDt2uDbWjHf4ikFvv1L9UNHVMp9DIQXX5GFgequ
	97oXbLK5rrATxdBw==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel/bts: Replace offsetof() with struct_size()
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250413104108.49142-2-thorsten.blum@linux.dev>
References: <20250413104108.49142-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174457175036.31282.16922756285239318022.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5c3627b6f0595f1ec27e6f5df903bd072e9b9136
Gitweb:        https://git.kernel.org/tip/5c3627b6f0595f1ec27e6f5df903bd072e9b9136
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Sun, 13 Apr 2025 12:41:09 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 13 Apr 2025 21:05:50 +02:00

perf/x86/intel/bts: Replace offsetof() with struct_size()

Use struct_size() to calculate the number of bytes to allocate for a new
bts_buffer. Compared to offsetof(), struct_size() provides additional
compile-time checks (e.g., __must_be_array()).

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250413104108.49142-2-thorsten.blum@linux.dev
---
 arch/x86/events/intel/bts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index da03f53..16bc89c 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -101,7 +101,7 @@ bts_buffer_setup_aux(struct perf_event *event, void **pages,
 	if (overwrite && nr_buf > 1)
 		return NULL;
 
-	bb = kzalloc_node(offsetof(struct bts_buffer, buf[nr_buf]), GFP_KERNEL, node);
+	bb = kzalloc_node(struct_size(bb, buf, nr_buf), GFP_KERNEL, node);
 	if (!bb)
 		return NULL;
 

